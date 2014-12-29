#!/usr/bin/env python
import os
import os.path
import collections
import plistlib
import zipfile
import tempfile
import shutil
import subprocess
import glob
import hashlib
import binascii

DEVNULL = os.open(os.devnull, os.O_RDWR)

# Returns the path to the filter script corresponding to a keyword
def filter_path(keyword):
	k = keyword[4:]
	if k == '':
		k = 'songs'
	elif k == 'song':
		k = 'songs-by-name'
	else:
		k += 's'

	return 'filters/filter-{}.applescript'.format(k)

# Returns the path to the action script based on a list keywords
# for which the filter scripts are connected with the action script
def action_path(connected_keywords):
	if len(connected_keywords) > 1:
		connected_keywords = list(reversed(sorted(connected_keywords)))

	keyword = connected_keywords[0]
	k = keyword[4:]

	return 'actions/play-{}.applescript'.format(k)

# Given a config dictionary and a file path updates the config with the file contents
# Returns wether the file was updated
def update_script(config, path):
	with open(path, 'r') as f:
		contents = f.read()
		if config['script'] != contents:
			config['script'] = contents
			print 'Updated {}'.format(path)

			return True
		else:
			return False

# Returns the path to the installed workflow or None if it can't be found
def get_installation_dir(bundle_id):
	ALFRED_PLIST = os.path.expanduser('~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist')
	DEFAULT_ALFRED_PREFERENCE_DIR = os.path.expanduser('~/Library/Application Support/Alfred 2')
	WORKFLOW_INFOS_GLOB = 'Alfred.alfredpreferences/workflows/user.workflow.*/info.plist'

	try:
		# We need to read the plist with defaults
		# as plistlib can't handle binary plists before Python 3.4
		preference_dir = subprocess.check_output(['defaults', 'read', ALFRED_PLIST, 'syncfolder'], stderr=DEVNULL)
	except subprocess.CalledProcessError:
		# If syncfolder couldn't be read use the default preference dir
		preference_dir = DEFAULT_ALFRED_PREFERENCE_DIR

	# Search for workflow dir
	for f in glob.glob(preference_dir + '/' + WORKFLOW_INFOS_GLOB):
		info = plistlib.readPlist(f)
		if info['bundleid'] == bundle_id:
			workflow_dir = os.path.dirname(f)
			return workflow_dir

	# Workflow not found
	return None

# Path to the directory this file is in
script_path = os.path.dirname(os.path.realpath(__file__))

# Path to the repository
top_path = script_path + '/..'

os.chdir(top_path)

# The workflows bundle id
workflow_bundle_id = 'com.calebevans.playsong'

# Path to the workflow file
workflow_path = 'Play Song.alfredworkflow'

# Path to resources
resources_path ='resources'

# Filename of the plist inside the workflow
plist_name = 'info.plist'

# Maps files inside the workflow to CRC-32 hashes
file_hashes = {}

with zipfile.ZipFile(workflow_path, 'r') as workflow:
	# Read the plist inside the workflow into data
	with workflow.open(plist_name, 'r') as info:
		data = plistlib.readPlist(info)

	for f in workflow.infolist():
		# Don't get the hash of the plist
		if f.filename == plist_name:
			continue

		file_hashes[f.filename] = f.CRC

# Get a map from a destination id to a list of source ids
connections_to = collections.defaultdict(list)

for source_id, connections in data['connections'].iteritems():
	for connection in connections:
		destination_id = connection['destinationuid']
		connections_to[destination_id].append(source_id)

# Seperate filter and action scripts
objects = data['objects']
filters = filter(lambda o: o['type'] == 'alfred.workflow.input.scriptfilter', objects)
actions = filter(lambda o: o['type'] == 'alfred.workflow.action.script', objects)

# Wether any scripts was changed
scripts_updated = False

# Map from filter script ids to keyword
filter_keywords = {}

# Update filter scripts
for obj in filters:
	config = obj['config']
	keyword = config['keyword']

	filter_keywords[obj['uid']] = keyword

	scripts_updated |= update_script(config, filter_path(keyword))

# Update action scripts
for obj in actions:
	config = obj['config']

	connections = connections_to[obj['uid']]
	connected_keywords = map(lambda c: filter_keywords[c], connections)

	scripts_updated |= update_script(config, action_path(connected_keywords))

# Temporary directory to store workflow files
tmp_dir = tempfile.mkdtemp()

resource_files = set(os.listdir(resources_path))
old_resource_files = set(file_hashes.keys())

# Print out all files removed from resources
for fname in old_resource_files - resource_files:
	fpath = resources_path + '/' + fname

	print 'Removed {}'.format(fpath)

# Copy and print out all files added to resources
for fname in resource_files - old_resource_files:
	fpath = resources_path + '/' + fname

	shutil.copy(fpath, tmp_dir)

	print 'Added {}'.format(fpath)

# All files that existed in the old workflow should all be copied
# Only print updated for those files that changed
for fname in resource_files & old_resource_files:
	fpath = resources_path + '/' + fname

	with open(fpath, 'r') as f:
		contents = f.read()

		# Always copy the file even if it hasn't changed
		with open(tmp_dir + '/' + fname, 'w') as f2:
			f2.write(contents)

		crc = binascii.crc32(contents) & 0xffffffff
		if crc != file_hashes[fname]:
			print 'Updated {}'.format(fpath)

# Save data back to plist
plistlib.writePlist(data, tmp_dir + '/' + plist_name)

if scripts_updated:
	print 'Updated {}'.format(plist_name)

# Zip the temporary directory and save as the workflow
with zipfile.ZipFile(workflow_path, 'w') as workflow:
	for fname in os.listdir(tmp_dir):
		workflow.write(tmp_dir + '/' + fname, fname)

installation_dir = get_installation_dir(workflow_bundle_id)

if not installation_dir:
	# Delete the temporary directory
	shutil.rmtree(tmp_dir)

	print 'Workflow installation path couldn\'t be found. Is "Play Song" installed?'
else:
	# Delete the directory
	shutil.rmtree(installation_dir)

	# Move the temporary directory to the installation directory
	os.rename(tmp_dir, installation_dir)

	print 'Updated installed workflow'

print 'Successfully updated the Alfred workflow.'
