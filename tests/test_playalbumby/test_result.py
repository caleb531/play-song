#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_title():
    """albumby result should display albumby name in title"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['title'], 'Ultimate Survivor')


def test_subtitle():
    """albumby result should display artist name in subtitle"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['subtitle'], 'Survivor')


def test_valid():
    """albumby result should be actionable"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_artwork():
    """albumby result should display correct artwork as icon"""
    results = run_filter('playalbumby', 'survivor')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
