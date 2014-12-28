#!/usr/bin/env python
import os
import plistlib
import zipfile
import tempfile

def filter_path(keyword):
	k = keyword[4:]
	if k == '':
		k = 'songs'
	elif k == 'song':
		k = 'songs-by-name'
	else:
		k += 's'

	return '/applescripts/filter-{}.applescript'.format(k)

def action_path(connected_keywords):
	if len(connected_keywords) > 1:
		connected_keywords = list(reversed(sorted(connected_keywords)))

	keyword = connected_keywords[0]
	k = keyword[4:]

	return '/applescripts/play-{}.applescript'.format(k)

script_path = os.path.dirname(os.path.realpath(__file__))
top_path = script_path + '/..'

workflow_path = top_path + '/Play Song.alfredworkflow'
plist_name = 'info.plist'

with zipfile.ZipFile(workflow_path, 'r') as workflow:
	with workflow.open(plist_name, 'r') as info:
		data = plistlib.readPlist(info)

	connections_to = {}

	for source_id, connections in data['connections'].iteritems():
		for connection in connections:
			destination_id = connection['destinationuid']
			if not destination_id in connections_to:
				connections_to[destination_id] = []

			connections_to[destination_id].append(source_id)

	objects = data['objects']
	filters = filter(lambda o: o['type'] == 'alfred.workflow.input.scriptfilter', objects)
	actions = filter(lambda o: o['type'] == 'alfred.workflow.action.script', objects)

	filter_keywords = {}

	for obj in filters:
		config = obj['config']
		keyword = config['keyword']

		filter_keywords[obj['uid']] = keyword

		with open(top_path + filter_path(keyword), 'r') as f:
			config['script'] = f.read()

	for obj in actions:
		config = obj['config']

		connections = connections_to[obj['uid']]
		connected_keywords = map(lambda c: filter_keywords[c], connections)

		with open(top_path + action_path(connected_keywords), 'r') as f:
			config['script'] = f.read()

	output_workflow_path = tempfile.mkstemp()[1]

	with zipfile.ZipFile(output_workflow_path, 'w') as output_workflow:
		output_workflow.writestr(plist_name, plistlib.writePlistToString(data))

		for f in workflow.infolist():
			if f.filename != plist_name:
				output_workflow.writestr(f.filename, workflow.read(f.filename))

os.rename(output_workflow_path, workflow_path)
print 'Successfully update the Alfred workflow.'
