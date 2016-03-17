#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import range


def test_return():
    r = range.return_Range()
    assert r.start == 13
    assert r.end == 42


def test_receive():
    range.receive_Range(range.Range(10, 15))
