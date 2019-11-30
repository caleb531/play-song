#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying artists"""
    results = run_filter('playartist', 'BeatL')
    nose.assert_equal(results[0]['title'], 'The Beatles')


def test_query_trim_whitespace():
    """should trim whitespace when querying artists"""
    results = run_filter('playartist', '   beatles   ')
    nose.assert_equal(results[0]['title'], 'The Beatles')


def test_query_partial():
    """should match partial queries when querying artists"""
    results = run_filter('playartist', 'light or')
    nose.assert_equal(results[0]['title'], 'Electric Light Orchestra')


def test_result_title():
    """artist result should display artist name in title"""
    results = run_filter('playartist', 'wye oak')
    nose.assert_equal(results[0]['title'], 'Wye Oak')


def test_result_subtitle():
    """artist result should display genre name in subtitle"""
    results = run_filter('playartist', 'wye oak')
    nose.assert_equal(results[0]['subtitle'], 'Alternative')


def test_result_valid():
    """artist result should be actionable"""
    results = run_filter('playartist', 'beatl')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork():
    """artist result should display correct artwork as icon"""
    results = run_filter('playartist', 'light o')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
