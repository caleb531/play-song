#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_filter


def test_ignore_case():
    """should ignore case when querying albums by an artist"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_trim_whitespace():
    """should trim whitespace when querying albums by an artist"""
    results = run_filter('playalbumby', '   survivor   ')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_partial():
    """should match partial queries when querying albums by an artist"""
    results = run_filter('playalbumby', 'urviv')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')
