#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import vec
import numpy as np


def test_Vec2f():
    v = vec.return_Vec2f()
    assert np.allclose(v[0], 0.643)
    assert np.allclose(v[1], 0.450)


def test_Vec2b():
    v = vec.return_Vec2b()
    assert v[0] == 34
    assert v[1] == 50


def test_Vec2s():
    v = vec.return_Vec2s()
    print(v)
    ar = np.array([[656], [5454]], dtype=np.short)
    assert np.allclose(v, ar)


def test_Vec3b():
    v = vec.Vec3b(5, 15, 25)
    vec.receive_Vec3b(v)


def test_Vec3i():
    v = vec.Vec3i(765, 523, 832)
    vec.receive_Vec3i(v)
