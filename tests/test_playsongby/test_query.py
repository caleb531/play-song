#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_filter


def test_ignore_case():
    """should ignore case when querying songs by an artist"""
    results = run_filter('playsongby', 'tokens')
    nose.assert_equal(results[0]['title'], 'The Lion Sleeps Tonight (Wimoweh)')


def test_partial():
    """should match partial queries when querying songs by an artist"""
    results = run_filter('playsongby', 'oken')
    nose.assert_equal(results[0]['title'], 'The Lion Sleeps Tonight (Wimoweh)')
