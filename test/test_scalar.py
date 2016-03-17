#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import scalar


def test_return_12f():
    s = scalar.return_Scalar()
    assert s[0] == 0.096
    assert s[1] == 0.160
    assert s[2] == 0.388
    assert s[3] == 0.293


def test_receive():
    scalar.receive_Scalar(scalar.Scalar(0.628, 0.855, 0.988, 0.015))
