#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_title():
    """album result should display album name in title"""
    results = run_filter('playalbum', 'shriek')
    nose.assert_equal(results[0]['title'], 'Shriek')


def test_subtitle():
    """album result should display artist name in subtitle"""
    results = run_filter('playalbum', 'shriek')
    nose.assert_equal(results[0]['subtitle'], 'Wye Oak')


def test_valid():
    """album result should be actionable"""
    results = run_filter('playalbum', 'please p')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_artwork_jpeg():
    """album result should display correct JPEG artwork as icon"""
    results = run_filter('playalbum', 'abbey road')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
