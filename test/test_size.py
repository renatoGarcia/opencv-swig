#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import size


def cmp(r, t):
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


def test_Size():
    cmp(size.return_Size(), (14, 55))
    size.receive_Size(size.Size(21, 175))


def test_Size2i():
    cmp(size.return_Size2i(), (203, 17))
    size.receive_Size2i(size.Size2i(250, 128))


def test_Size2d():
    cmp(size.return_Size2d(), (0.039, 0.377))
    size.receive_Size2d(size.Size2d(0.637, 0.256))


def test_Size2f():
    cmp(size.return_Size2f(), (0.460, 0.339))
    size.receive_Size2f(size.Size2f(0.464, 0.239))


def test_Vec_constructor():
    cmp(size.Size2i(size.Point2i(23, 58)), (23, 58))
