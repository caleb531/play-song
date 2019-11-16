#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_title():
    """songby result should display songby name in title"""
    results = run_filter('playsongby', 'tokens')
    nose.assert_equal(results[0]['title'], 'The Lion Sleeps Tonight (Wimoweh)')


def test_subtitle():
    """songby result should display artist name in subtitle"""
    results = run_filter('playsongby', 'tokens')
    nose.assert_equal(results[0]['subtitle'], 'The Tokens')


def test_valid():
    """songby result should be actionable"""
    results = run_filter('playsongby', 'beatl')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_artwork():
    """songby result should display correct artwork as icon"""
    results = run_filter('playsongby', 'light o')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
