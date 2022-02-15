#!/usr/bin/env python3
# coding=utf-8

from __future__ import print_function, unicode_literals

import json
import subprocess


def run_applescript(applescript_path, *args):

    return subprocess.check_output([
        'osascript',
        '{}.applescript'.format(applescript_path)
    ] + list(args))


def run_filter(filter_name, *filter_args):

    raw_feedback = run_applescript(
        'filters/{}'.format(filter_name),
        *filter_args)

    return json.loads(raw_feedback)['items']


def run_action(action_name):

    run_applescript('actions/{}'.format(action_name))
