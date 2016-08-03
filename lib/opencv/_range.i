/* Copyright (c) 2015-2016 The OpenCV-SWIG Library Developers. See the AUTHORS file at the
 * top-level directory of this distribution and at
 * https://github.com/renatoGarcia/opencv-swig/blob/master/AUTHORS.
 *
 * This file is part of OpenCV-SWIG Library. It is subject to the 3-clause BSD license
 * terms as in the LICENSE file found in the top-level directory of this distribution and
 * at https://github.com/renatoGarcia/opencv-swig/blob/master/LICENSE. No part of
 * OpenCV-SWIG Library, including this file, may be copied, modified, propagated, or
 * distributed except according to the terms contained in the LICENSE file.
 */

%include <opencv2/core/version.hpp>

#if CV_VERSION_MAJOR > 3
    // This OpenCV version was not tested
    %include <opencv/_range-3_0_0.i>
#elif CV_VERSION_MAJOR == 3 && CV_VERSION_MINOR > 1
    // This OpenCV version was not tested
    %include <opencv/_range-3_0_0.i>
#elif CV_VERSION_MAJOR == 3 && CV_VERSION_MINOR >= 0
    %include <opencv/_range-3_0_0.i>
#else
    // This OpenCV version was not tested
    %include <opencv/_range-3_0_0.i>
#endif
