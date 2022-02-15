#!/usr/bin/env python3
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying albums by an artist"""
    results = run_filter('playalbumby', 'SurVivor')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_query_trim_whitespace():
    """should trim whitespace when querying albums by an artist"""
    results = run_filter('playalbumby', '   survivor   ')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_query_partial():
    """should match partial queries when querying albums by an artist"""
    results = run_filter('playalbumby', 'urviv')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_result_title():
    """albumby result should display albumby name in title"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_result_subtitle():
    """albumby result should display artist name in subtitle"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['subtitle'], 'Survivor')


def test_result_valid():
    """albumby result should be actionable"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork():
    """albumby result should display correct artwork as icon"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')


def test_no_results():
    """should return 'No Results Found' in the case of no album results"""
    results = run_filter('playalbumby', 'zxy')
    nose.assert_equal(results[0]['title'], 'No Results Found')
    nose.assert_equal(results[0]['subtitle'], 'No albums matching \'zxy\'')
    nose.assert_equal(results[0]['valid'], 'no')
    nose.assert_equal(results[0]['icon']['path'],
                      'resources/icon-noartwork.png')
    nose.assert_equal(len(results), 1)
