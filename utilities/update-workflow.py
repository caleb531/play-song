#!/usr/bin/env python
from __future__ import print_function
import binascii
import collections
import glob
import os
import os.path
import plistlib
import re
import shutil
import subprocess
import tempfile
import zipfile


DEVNULL = os.open(os.devnull, os.O_RDWR)

NO_MODIFIERS = 0
CMD_MODIFIER = 1048576

ALFRED_PLIST_NAME = 'com.runningwithcrayons.Alfred-Preferences-3.plist'
ALFRED_PLIST = os.path.expanduser(
    os.path.join('~', 'Library', 'Preferences', ALFRED_PLIST_NAME))
DEFAULT_ALFRED_PREFERENCE_DIR = os.path.expanduser(os.path.join(
    '~', 'Library', 'Application Support', 'Alfred 3'))
WORKFLOW_INFOS_GLOB = os.path.join(
    'Alfred.alfredpreferences', 'workflows', 'user.workflow.*', 'info.plist')


# Returns the path to the filter script corresponding to a keyword
def filter_path(keyword):
    return 'filters/{}.applescript'.format(keyword)


# Returns the path to the action script based on a list keywords
# for which the filter scripts are connected with the action script
def action_path(connections):
    first = connections[0]
    modifiers, keyword = first

    if modifiers == CMD_MODIFIER:
        name = 'queue'
    else:
        if keyword in {'playqueue', 'clearqueue', 'clearcache'}:
            name = keyword
        else:
            name = 'play'

    return 'actions/{}.applescript'.format(name)


# Given a config dict and file path, updates the config with file contents
# Returns whether the file was updated
def update_script(config, path):
    config_script = config['script']

    alias = None
    m = re.match(r'(--\s*@ALIAS@\s*(\S+))', config_script)
    if m:
        alias_line, alias = m.groups()
        path = filter_path(alias)

    with open(path, 'r') as f:
        contents = f.read()

        if alias:
            contents = alias_line + '\n' + contents

        if config_script != contents:
            config['script'] = contents

            if alias:
                print('Updated alias {} for {}'.format(
                    config['keyword'], alias))
            else:
                print('Updated {}'.format(path))

            return True
        else:
            return False


# Returns the path to the installed workflow or None if it can't be found
def get_installation_dir(bundle_id):

    try:
        # We need to read the plist with defaults
        # as plistlib can't handle binary plists before Python 3.4
        preference_dir = subprocess.check_output(['defaults', 'read',
                                                 ALFRED_PLIST, 'syncfolder'],
                                                 stderr=DEVNULL)

        # Ensure ~ is expanded to full home folder path
        # Also remove leading and trailing whitespace
        preference_dir = os.path.expanduser(preference_dir.strip())

    except subprocess.CalledProcessError:
        # If syncfolder couldn't be read use the default preference dir
        preference_dir = DEFAULT_ALFRED_PREFERENCE_DIR

    # Search for workflow dir
    for fname in glob.iglob(os.path.join(preference_dir, WORKFLOW_INFOS_GLOB)):
        info = plistlib.readPlist(fname)
        if info['bundleid'] == bundle_id:
            workflow_dir = os.path.dirname(fname)
            return workflow_dir

    # Workflow not found
    return None

# Path to the directory this file is in
script_path = os.path.dirname(os.path.realpath(__file__))

# Path to the repository
top_path = os.path.dirname(script_path)

os.chdir(top_path)

# The workflows bundle id
workflow_bundle_id = 'com.calebevans.playsong'

# Path to the workflow file
workflow_path = 'Play Song.alfredworkflow'

# Path to resources
resources_path = 'resources'

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
        modifiers = connection['modifiers']
        connections_to[destination_id].append((modifiers, source_id))

# Seperate filter and action scripts
objects = data['objects']
filters = filter(lambda o: o['type'] == 'alfred.workflow.input.scriptfilter'
                 or o['type'] == 'alfred.workflow.input.keyword',
                 objects)
actions = filter(lambda o: o['type'] == 'alfred.workflow.action.script',
                 objects)

# Wether any scripts was changed
scripts_updated = False

# Map from filter script ids to keyword
filter_keywords = {}

# Update filter scripts
for obj in filters:
    config = obj['config']
    keyword = config['keyword']

    filter_keywords[obj['uid']] = keyword

    if obj['type'] == 'alfred.workflow.input.scriptfilter':
        scripts_updated |= update_script(config, filter_path(keyword))

# Update action scripts
for obj in actions:
    config = obj['config']

    connections = connections_to[obj['uid']]
    connections_with_keywords = map(
        lambda c: (c[0], filter_keywords[c[1]]), connections)

    scripts_updated |= update_script(
        config, action_path(connections_with_keywords))

# Temporary directory to store workflow files
tmp_dir = tempfile.mkdtemp()

resource_files = set(os.listdir(resources_path))
old_resource_files = set(file_hashes.keys())

# Print out all files removed from resources
for fname in old_resource_files - resource_files:
    fpath = os.path.join(resources_path, fname)

    print('Removed {}'.format(fpath))

# Copy and print out all files added to resources
for fname in resource_files - old_resource_files:
    fpath = os.path.join(resources_path, fname)

    shutil.copy(fpath, tmp_dir)

    print('Added {}'.format(fpath))

# All files that existed in the old workflow should all be copied
# Only print updated for those files that changed
for fname in resource_files & old_resource_files:
    fpath = os.path.join(resources_path, fname)

    # Always copy the file even if it hasn't changed
    shutil.copy(fpath, tmp_dir)

    with open(fpath, 'r') as f:
        contents = f.read()

        crc = binascii.crc32(contents) & 0xffffffff
        if crc != file_hashes[fname]:
            print('Updated {}'.format(fpath))

# Save data back to plist
plistlib.writePlist(data, os.path.join(tmp_dir, plist_name))

if scripts_updated:
    print('Updated {}'.format(plist_name))

# Zip the temporary directory and save as the workflow
with zipfile.ZipFile(workflow_path, 'w') as workflow:
    for fname in os.listdir(tmp_dir):
        workflow.write(tmp_dir + '/' + fname, fname)

installation_dir = get_installation_dir(workflow_bundle_id)

if not installation_dir:
    # Delete the temporary directory
    shutil.rmtree(tmp_dir)

    print('Workflow installation path not found. Is "Play Song" installed?')
else:
    # Delete the directory
    shutil.rmtree(installation_dir)

    # Move the temporary directory to the installation directory
    os.rename(tmp_dir, installation_dir)

    print('Updated installed workflow')

print('Successfully updated the Alfred workflow.')
