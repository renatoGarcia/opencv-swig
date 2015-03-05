#! /usr/bin/python2

import size


def cmp(r, t):
    assert(isinstance(r, tuple))
    assert(isinstance(t, tuple))
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


cmp(size.size(),   (14, 55))
cmp(size.size_r(), (154, 88))
cmp(size.size_p(), (54, 25))
size.size((21, 175))
size.size_r((94, 96))
size.size_p((211, 35))

cmp(size.size_int(),   (203, 17))
cmp(size.size_int_r(), (158, 87))
cmp(size.size_int_p(), (150, 215))
size.size_int((250, 128))
size.size_int_r((59, 147))
size.size_int_p((17, 180))

cmp(size.size_double(),   (0.039, 0.377))
cmp(size.size_double_r(), (0.720, 0.189))
cmp(size.size_double_p(), (0.862, 0.046))
size.size_double((0.637, 0.256))
size.size_double_r((0.002, 0.211))
size.size_double_p((0.162, 0.433))

cmp(size.size_float(),   (0.460, 0.339))
cmp(size.size_float_r(), (0.948, 0.315))
cmp(size.size_float_p(), (0.231, 0.396))
size.size_float((0.464, 0.239))
size.size_float_r((0.917, 0.375))
size.size_float_p((0.531, 0.205))
