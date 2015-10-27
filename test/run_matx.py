#! /usr/bin/python3

import sys
sys.path.insert(0, ".")

import matx
import numpy as np

m1 = matx.return_matx12f()
assert(np.allclose(m1[0, 1], 0.242))
assert(np.allclose(m1[0], 0.07))

m2 = matx.Matx32d(0.445, 0.473, 0.765, 0.523, 0.832, 0.345)
matx.receive_matx32d(m2)

m3 = matx.return_matx22f()
ar3 = np.array([[0.657, 0.656], [0.545, 0.034]], dtype=np.float32)
np.allclose(m3, ar3)
