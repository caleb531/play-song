#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying albums"""
    results = run_filter('playalbum', 'Please PLEASE me')
    nose.assert_equal(results[0]['title'], 'Please Please Me')


def test_query_trim_whitespace():
    """should trim whitespace when querying albums"""
    results = run_filter('playalbum', '    please please me    ')
    nose.assert_equal(results[0]['title'], 'Please Please Me')


def test_query_partial():
    """should match partial queries when querying albums"""
    results = run_filter('playalbum', 'ease m')
    nose.assert_equal(results[0]['title'], 'Please Please Me')


def test_result_title():
    """album result should display album name in title"""
    results = run_filter('playalbum', 'shriek')
    nose.assert_equal(results[0]['title'], 'Shriek')


def test_result_subtitle():
    """album result should display artist name in subtitle"""
    results = run_filter('playalbum', 'shriek')
    nose.assert_equal(results[0]['subtitle'], 'Wye Oak')


def test_result_valid():
    """album result should be actionable"""
    results = run_filter('playalbum', 'please p')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork():
    """album result should display correct artwork as icon"""
    results = run_filter('playalbum', 'abbey road')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
