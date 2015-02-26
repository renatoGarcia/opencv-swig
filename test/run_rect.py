#! /usr/bin/python2

import rect


def cmp(r, t):
    assert(isinstance(r, tuple))
    assert(isinstance(t, tuple))
    epsilon = 0.0001
    for p in zip(r, t):
        assert(abs(p[0] - p[1]) < epsilon)


cmp(rect.rect(),   (18, 4, 154, 150))
cmp(rect.rect_r(), (95, 178, 154, 51))
cmp(rect.rect_p(), (10, 85, 76, 103))
rect.rect((69, 43,  13,  89))
rect.rect_r((190, 11, 136, 219))
rect.rect_p((139, 72, 172, 198))

cmp(rect.rect_int(),   (20, 183, 191, 148))
cmp(rect.rect_int_r(), (120, 23, 100, 55))
cmp(rect.rect_int_p(), (173, 12, 109, 83))
rect.rect_int((156, 146, 132,  10))
rect.rect_int_r((33, 180, 216, 104))
rect.rect_int_p((110,   7, 233,  55))

cmp(rect.rect_double(),   (0.988, 0.837, 0.419, 0.672))
cmp(rect.rect_double_r(), (0.543, 0.585, 0.723, 0.363))
cmp(rect.rect_double_p(), (0.580, 0.216, 0.673, 0.417))
rect.rect_double((0.077, 0.972, 0.865, 0.203))
rect.rect_double_r((0.839, 0.870, 0.689, 0.799))
rect.rect_double_p((0.650, 0.685, 0.290, 0.577))

cmp(rect.rect_float(),   (0.357, 0.460, 0.384, 0.103))
cmp(rect.rect_float_r(), (0.336, 0.606, 0.066, 0.587))
cmp(rect.rect_float_p(), (0.547, 0.462, 0.337, 0.951))
rect.rect_float((0.488, 0.797, 0.436, 0.618))
rect.rect_float_r((0.827, 0.373, 0.257, 0.981))
rect.rect_float_p((0.097, 0.033, 0.570, 0.466))
