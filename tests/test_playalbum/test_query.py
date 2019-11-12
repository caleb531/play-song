#!/usr/bin/env python
# coding=utf-8

from __future__ import print_function, unicode_literals

import nose.tools as nose

from tests.utils import run_filter


def test_ignore_case():
    """should ignore case when querying albums"""
    results = run_filter('playalbum', 'Please PLEASE me')
    nose.assert_equal(results[0]['title'], 'Please Please Me')


def test_partial():
    """should match partial queries when querying albums"""
    results = run_filter('playalbum', 'ease me')
    nose.assert_equal(results[0]['title'], 'Please Please Me')
