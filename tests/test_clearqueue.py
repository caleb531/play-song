#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_applescript, run_action


def test_clear_queue():

    run_action('clearqueue')
    song_count = int(run_applescript('tests/applescript/test_clearqueue'))
    nose.assert_equal(song_count, 0)
