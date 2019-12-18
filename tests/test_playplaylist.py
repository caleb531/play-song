#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying playlists"""
    results = run_filter('playplaylist', 'GuARDians')
    nose.assert_equal(results[0]['title'], 'Guardians of the Galaxy')


def test_query_trim_whitespace():
    """should trim whitespace when querying playlists"""
    results = run_filter('playplaylist', '    guardians    ')
    nose.assert_equal(results[0]['title'], 'Guardians of the Galaxy')


def test_query_partial():
    """should match partial queries when querying playlists"""
    results = run_filter('playplaylist', 'of the gal')
    nose.assert_equal(results[0]['title'], 'Guardians of the Galaxy')


def test_result_title():
    """playlist result should display playlist name in title"""
    results = run_filter('playplaylist', 'guardians')
    nose.assert_equal(results[0]['title'], 'Guardians of the Galaxy')


def test_result_subtitle():
    """playlist result should display artist name in subtitle"""
    results = run_filter('playplaylist', 'guardians')
    nose.assert_regexp_matches(
        results[0]['subtitle'], r'\d+ songs, \d+(:\d+)+ in length')


def test_result_valid():
    """playlist result should be actionable"""
    results = run_filter('playplaylist', 'guardians')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork():
    """playlist result should display correct artwork as icon"""
    results = run_filter('playplaylist', 'guardians')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')


def test_no_results():
    """should return 'No Results Found' in the case of no playlist results"""
    results = run_filter('playplaylist', 'zxy')
    nose.assert_equal(results[0]['title'], 'No Results Found')
    nose.assert_equal(results[0]['subtitle'], 'No playlists matching \'zxy\'')
    nose.assert_equal(results[0]['valid'], 'no')
    nose.assert_equal(results[0]['icon']['path'],
                      'resources/icon-noartwork.png')
    nose.assert_equal(len(results), 1)
