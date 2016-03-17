#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import matx
import numpy as np


def test_return_12f():
    m = matx.return_matx12f()
    assert np.allclose(m[0, 1], 0.242)
    assert np.allclose(m[0], 0.07)


def test_receive():
    m = matx.Matx32d(0.445, 0.473, 0.765, 0.523, 0.832, 0.345)
    matx.receive_matx32d(m)


def test_return_22f():
    m = matx.return_matx22f()
    ar = np.array([[0.657, 0.656], [0.545, 0.034]], dtype=np.float32)
    assert np.allclose(m, ar)
