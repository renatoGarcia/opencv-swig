#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import pytest
import mat
import numpy as np
import cv2


def cmp(m, t):
    assert(isinstance(m, np.ndarray))
    assert(isinstance(t, np.ndarray))
    assert(m.dtype == t.dtype)
    assert(m.shape == t.shape)
    assert(np.allclose(m, t))


# ---------------------------------------------------------------------- Mat
class TestMatFromArray:
    def test_float32(self):
        a = np.array([[[0.606, 0.091, 0.098], [0.751, 0.639, 0.956]],
                      [[0.721, 0.163, 0.543], [0.454, 0.281, 0.909]],
                      [[0.806, 0.348, 0.279], [0.462, 0.656, 0.388]]],
                     dtype=np.float32)
        m = mat.Mat.from_array(a)
        assert m.type() == cv2.CV_32FC3
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]

    def test_uint8(self):
        a = np.array([[[49, 148]],
                      [[112, 39]],
                      [[133, 6]]],
                     dtype=np.uint8)
        m = mat.Mat.from_array(a)
        assert m.type() == cv2.CV_8UC2
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]

    def test_int16(self):
        a = np.array([[10571, 8889],
                      [9236, -15519],
                      [-28325, -22440]],
                     dtype=np.int16)
        m = mat.Mat.from_array(a)
        assert m.type() == cv2.CV_16SC1
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]


class TestMatAsArray:
    def test_uint8(self):
        m = mat.Mat(3, 2, cv2.CV_8UC3)
        a = np.asarray(m)
        assert len(a.shape) == 3
        assert a.shape[0] == 3
        assert a.shape[1] == 2
        assert a.shape[2] == 3
        assert a.dtype == np.uint8


class TestMatReturn:
    def test_uint8(self):
        m = mat.return_Mat1()
        assert m.type() == cv2.CV_8UC1
        assert isinstance(m, mat.Mat)
        cmp(np.asarray(m), np.array([[113, 65],
                                     [70, 143],
                                     [154, 194]],
                                    dtype=np.uint8))

    def test_int16(self):
        m = mat.return_Mat2()
        assert m.type() == cv2.CV_16SC2
        assert isinstance(m, mat.Mat)
        cmp(np.asarray(m), np.array([[[81, 19], [-65, -2]],
                                     [[-3, 22], [-55, 2]],
                                     [[5575, 600], [-1720, 21920]]],
                                    dtype=np.int16))


class TestMatReceive:
    def test_float64(self):
        a = np.array([[[0.606, 0.091, 0.098], [0.751, 0.639, 0.956]],
                      [[0.721, 0.163, 0.543], [0.454, 0.281, 0.909]],
                      [[0.806, 0.348, 0.279], [0.462, 0.656, 0.388]]],
                     dtype=np.float64)
        mat.receive_Mat(mat.Mat.from_array(a))


# ---------------------------------------------------------------------- Mat_
class TestMat_FromArray:
    def test_Mat1f(self):
        a = np.array([[0.479, 0.996],
                      [0.339, 0.107],
                      [0.658, 0.907]],
                     dtype=np.float32)
        m = mat.Mat1f.from_array(a)
        assert m.type() == cv2.CV_32FC1
        assert isinstance(m, mat.Mat1f)
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]

    def test_Mat2f(self):
        a = np.array([[[0.479, 0.804], [0.132, 0.996]],
                      [[0.339, 0.661], [0.214, 0.107]],
                      [[0.658, 0.712], [0.498, 0.907]]],
                     dtype=np.float32)
        m = mat.Mat2f.from_array(a)
        assert m.type() == cv2.CV_32FC2
        assert isinstance(m, mat.Mat2f)
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]

    def test_Mat1b(self):
        a = np.array([[33],
                      [188],
                      [229]],
                     dtype=np.uint8)
        m = mat.Mat1b.from_array(a)
        assert m.type() == cv2.CV_8UC1
        assert isinstance(m, mat.Mat1b)
        assert m.rows == a.shape[0]
        assert m.cols == a.shape[1]

        with pytest.raises(ValueError):
            # Mat1b cannot be built with a float32 array.
            a = np.array([0.479], dtype=np.float32)
            mat.Mat1b.from_array(a)

        with pytest.raises(ValueError):
            # Mat1b expects a shape (l, c) a.shape is (1, 1, 2)
            a = np.array([[[129, 29]]], dtype=np.uint8)
            mat.Mat1b.from_array(a)


class TestMat_Return:
    def test_Mat1b(self):
        m = mat.return_Mat1b()
        assert m.type() == cv2.CV_8UC1
        assert isinstance(m, mat.Mat1b)
        cmp(np.asarray(m), np.array([[159, 88],
                                     [244, 66],
                                     [3, 136]],
                                    dtype=np.uint8))

    def test_Mat2b(self):
        m = mat.return_Mat2b()
        assert m.type() == cv2.CV_8UC2
        assert isinstance(m, mat.Mat2b)
        cmp(np.asarray(m), np.array([[[129, 29], [204, 240]],
                                     [[76, 118], [15, 107]],
                                     [[223, 111], [151, 208]]],
                                    dtype=np.uint8))

    def test_Mat3b(self):
        m = mat.return_Mat3b()
        assert m.type() == cv2.CV_8UC3
        assert isinstance(m, mat.Mat3b)
        cmp(np.asarray(m), np.array([[[40, 144, 104], [80, 141, 228]],
                                     [[68, 80, 217], [184, 146, 112]],
                                     [[255, 111, 230], [84, 97, 224]]],
                                    dtype=np.uint8))

    def test_Mat4b(self):
        m = mat.return_Mat4b()
        assert m.type() == cv2.CV_8UC4
        assert isinstance(m, mat.Mat4b)
        cmp(np.asarray(m), np.array([[[252, 1, 156, 161], [255, 168, 21, 182]],
                                     [[97, 101, 64, 219], [185, 218, 198, 216]],
                                     [[130, 222, 142, 185], [196, 3, 99, 224]]],
                                    dtype=np.uint8))

    def test_Mat1d(self):
        m = mat.return_Mat1d()
        assert m.type() == cv2.CV_64FC1
        assert isinstance(m, mat.Mat1d)
        cmp(np.asarray(m), np.array([[0.161, 0.173],
                                     [0.623, 0.713],
                                     [0.601, 0.306]],
                                    dtype=np.float64))


class TestMat_Receive:
    def test_Mat2s(self):
        a = np.array([[[53, -57], [-9, -18]],
                      [[-111, 110], [52, -103]],
                      [[2276, 11336], [18891, 7322]]],
                     dtype=np.int16)
        mat.receive_Mat2s(mat.Mat2s.from_array(a))
