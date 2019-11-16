#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_filter


def test_ignore_case():
    """should ignore case when querying artists"""
    results = run_filter('playartist', 'BeatL')
    nose.assert_equal(results[0]['title'], 'The Beatles')


def test_partial():
    """should match partial queries when querying artists"""
    results = run_filter('playartist', 'light or')
    nose.assert_equal(results[0]['title'], 'Electric Light Orchestra')
