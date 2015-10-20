#! /usr/bin/python3

import vec
import numpy as np


v1 = vec.return_Vec2f()
assert(np.allclose(v1[0], 0.643))
assert(np.allclose(v1[1], 0.450))

v2 = vec.return_Vec2b()
assert(v2[0] == 34)
assert(v2[1] == 50)

v3 = vec.return_Vec2s()
ar3 = np.array([656, 5454], dtype=np.short)
np.allclose(v3, ar3)

v4 = vec.Vec3b(5, 15, 25)
vec.receive_Vec3b(v4)

v5 = vec.Vec3i(765, 523, 832)
vec.receive_Vec3i(v5)
