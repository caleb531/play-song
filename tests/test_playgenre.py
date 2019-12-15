#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying genres"""
    results = run_filter('playgenre', 'disco')
    nose.assert_equal(results[0]['title'], 'Disco')


def test_query_trim_whitespace():
    """should trim whitespace when querying genres"""
    results = run_filter('playgenre', '    disco    ')
    nose.assert_equal(results[0]['title'], 'Disco')


def test_query_partial():
    """should match partial queries when querying genres"""
    results = run_filter('playgenre', 'disc')
    nose.assert_equal(results[0]['title'], 'Disco')


def test_result_title():
    """genre result should display genre name in title"""
    results = run_filter('playgenre', 'disco')
    nose.assert_equal(results[0]['title'], 'Disco')


def test_result_subtitle():
    """genre result should display artist name in subtitle"""
    results = run_filter('playgenre', 'disco')
    nose.assert_equal(results[0]['subtitle'], 'Genre')


def test_result_valid():
    """genre result should be actionable"""
    results = run_filter('playgenre', 'disco')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork():
    """genre result should display correct artwork as icon"""
    results = run_filter('playgenre', 'disco')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')


def test_no_results():
    """should return 'No Results Found' in the case of no genre results"""
    results = run_filter('playgenre', 'zxy')
    nose.assert_equal(results[0]['title'], 'No Results Found')
    nose.assert_equal(results[0]['subtitle'], 'No genres matching \'zxy\'')
    nose.assert_equal(results[0]['valid'], 'no')
    nose.assert_equal(results[0]['icon']['path'],
                      'resources/icon-noartwork.png')
    nose.assert_equal(len(results), 1)
