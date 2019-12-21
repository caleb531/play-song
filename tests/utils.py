#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import json
import subprocess


def run_applescript(applescript_path, *args):

    return subprocess.check_output([
        'osascript',
        '{}.applescript'.format(applescript_path)
    ] + list(args))


def run_filter(filter_name, filter_arg):

    raw_feedback = subprocess.check_output([
        'osascript',
        'filters/{}.applescript'.format(filter_name),
        filter_arg
    ])

    return json.loads(raw_feedback)['items']


def run_action(action_name):

    subprocess.check_output([
        'osascript',
        'actions/{}.applescript'.format(action_name)
    ])
