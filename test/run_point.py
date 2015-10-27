#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import point


def cmp(r, t):
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


cmp(point.return_Point(), (193, 216))
point.receive_Point(point.Point(87, 97))

cmp(point.return_Point2i(), (192, 218))
point.receive_Point2i(point.Point2i(236, 30))

cmp(point.return_Point2d(), (0.375, 0.243))
point.receive_Point2d(point.Point2d(0.219, 0.426))

cmp(point.return_Point2f(), (0.935, 0.762))
point.receive_Point2f(point.Point2f(0.768, 0.724))

# Test Vec constructor
cmp(point.Point2i(point.Vec2i(76, 81)), (76, 81))
