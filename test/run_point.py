#! /usr/bin/python3

import point


def cmp(r, t):
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


cmp(point.point(), (193, 216))
cmp(point.point_r(), point.Point(185, 80))
cmp(point.point_p(), (35, 18))
point.point((87, 97))
point.point_r((115, 203))
point.point_p((89, 137))

cmp(point.point_int(), (192, 218))
cmp(point.point_int_r(), (25, 141))
cmp(point.point_int_p(), point.Point2i(78, 131))
point.point_int((236, 30))
point.point_int_r((72, 180))
point.point_int_p((225, 66))

cmp(point.point_double(), (0.375, 0.243))
cmp(point.point_double_r(), (0.647,  0.530))
cmp(point.point_double_p(), point.Point2d(0.745, 0.163))
point.point_double((0.219, 0.426))
point.point_double_r((0.650, 0.581))
point.point_double_p((0.156, 0.634))

cmp(point.point_float(), point.Point2f(0.935, 0.762))
cmp(point.point_float_r(), (0.356, 0.847))
cmp(point.point_float_p(), (0.301, 0.893))
point.point_float((0.768, 0.724))
point.point_float_r((0.152, 0.552))
point.point_float_p((0.079, 0.624))

assert point.pointTypecheck((1, 2)) == 3
assert point.pointTypecheck((1.1, 2.2)) == 3
assert point.pointTypecheck(point.Point2f(1.1, 2.2)) == 2
assert point.pointTypecheck(point.Point2d(1.1, 2.2)) == 3
assert point.pointTypecheck(point.Point2i(1, 2)) == 1
