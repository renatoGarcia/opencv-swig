#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import rect


def cmp(r, t):
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


def test_Rect():
    cmp(rect.return_Rect(), (18, 4, 154, 150))
    rect.receive_Rect(rect.Rect(69, 43,  13,  89))


def test_Rect2i():
    cmp(rect.return_Rect2i(), (20, 183, 191, 148))
    rect.receive_Rect2i(rect.Rect2i(156, 146, 132,  10))


def test_Rect2d():
    cmp(rect.return_Rect2d(), (0.988, 0.837, 0.419, 0.672))
    rect.receive_Rect2d(rect.Rect2d(0.077, 0.972, 0.865, 0.203))


def test_Rect2f():
    cmp(rect.return_Rect2f(), (0.357, 0.460, 0.384, 0.103))
    rect.receive_Rect2f(rect.Rect2f(0.488, 0.797, 0.436, 0.618))
