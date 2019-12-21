#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_action


cache_path = os.path.expanduser(os.path.join(
    '~', 'Library', 'Caches', 'com.runningwithcrayons.Alfred',
    'Workflow Data', 'com.calebevans.playsong'))


def test_clear_cache():

    try:
        os.mkdir(cache_path)
    except OSError:
        pass
    nose.assert_true(os.path.exists(cache_path))
    run_action('clearcache')
    nose.assert_false(os.path.exists(cache_path))
