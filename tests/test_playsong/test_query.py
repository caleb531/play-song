#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_filter


def test_ignore_case():
    """should ignore case when querying songs"""
    results = run_filter('playsong', 'mr Blue SKY')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')


def test_partial():
    """should match partial queries"""
    results = run_filter('playsong', 'blue sky')
    nose.assert_equal(results[0]['title'], 'Mr. Blue Sky')
