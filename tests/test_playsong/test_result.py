#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import os
import os.path

import nose.tools as nose

from tests.utils import run_filter


def test_title():
    """song result should display song name in title"""
    results = run_filter('playsong', 'mr blue sky')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_subtitle():
    """song result should display artist name in subtitle"""
    results = run_filter('playsong', 'here comes the sun')
    nose.assert_equal(results[0]['subtitle'], 'The Beatles')


def test_valid():
    """song result should be actionable"""
    results = run_filter('playsong', 'how great is our god')
    nose.assert_equal(results[0]['valid'], 'yes')


def test_artwork():
    """song result should display correct artwork as icon"""
    results = run_filter('playsong', 'waterloo')
    nose.assert_true(
        os.path.isabs(results[0]['icon']['path']),
        'artwork path is not an absolute path')
    nose.assert_true(
        os.path.exists(results[0]['icon']['path']),
        'artwork path does not exist')
