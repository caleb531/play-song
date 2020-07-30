#!/usr/bin/env python3
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_query_ignore_case():
    """should ignore case when querying songs"""
    results = run_filter('playsong', 'mr Blue SKY')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_query_trim_whitespace():
    """should trim whitespace when querying songs"""
    results = run_filter('playsong', '   mr blue sky   ')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_query_partial():
    """should match partial queries when querying songs"""
    results = run_filter('playsong', 'blue sky')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_result_title():
    """song result should display song name in title"""
    results = run_filter('playsong', 'mr blue sky')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_result_subtitle():
    """song result should display artist name in subtitle"""
    results = run_filter('playsong', 'here comes the sun')
    nose.assert_equal(results[0]['subtitle'], 'The Beatles')


def test_result_valid():
    """song result should be actionable"""
    results = run_filter('playsong', 'how great is our god')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_result_artwork_jpeg():
    """song result should display correct JPEG artwork as icon"""
    results = run_filter('playsong', 'waterloo')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
    nose.assert_equal(
        os.path.splitext(results[0]['icon']['path'])[1],
        '.jpeg')


def test_result_artwork_png():
    """song result should display correct PNG artwork as icon"""
    results = run_filter('playsong', 'receives')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
    nose.assert_equal(
        os.path.splitext(results[0]['icon']['path'])[1],
        '.png')


def test_no_results():
    """should return 'No Results Found' in the case of no song results"""
    results = run_filter('playsong', 'zxy')
    nose.assert_equal(results[0]['title'], 'No Results Found')
    nose.assert_equal(results[0]['subtitle'], 'No songs matching \'zxy\'')
    nose.assert_equal(results[0]['valid'], 'no')
    nose.assert_equal(results[0]['icon']['path'],
                      'resources/icon-noartwork.png')
    nose.assert_equal(len(results), 1)
