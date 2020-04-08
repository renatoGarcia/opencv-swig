# OpenCV-SWIG

[![CI.badge]][CI.link]
[![LICENSE.badge]][LICENSE.link]


## A SWIG library for OpenCV types

This library is a collection of [SWIG](http://swig.org/) interface files with rules to
wrap [OpenCV](https://opencv.org/) C++ types as [Python](https://www.python.org/) classes.
The OpenCV itself has a Python binding exposing its API, this library is not that.


## Hello, world!

The use case of this library is when someone is writing a C++ library, which uses OpenCV
types on its API, and desires to create a Python binding to that library.

Let's say you have built some C++ library `MyLib` having a `my_lib.hpp` header:

```C++
#include <opencv2/core.hpp>
#include <iostream>

inline auto moveTo(cv::Point const& p) -> void
{
    std::cout << "cv::Point moved" << std::endl;
}

inline auto getImage() -> cv::Mat3b
{
    return cv::Mat3b(3, 5);
}
```

To generate a `MyLib` Python binding, everything you need is a `my_lib.i` SWIG file as:

```
%module my_lib

%include <opencv.i>
%cv_instantiate_all_defaults

%{
    #include "my_lib.hpp"
%}

%include "my_lib.hpp"
```

and calling SWIG as in:

```shell
swig -I<path to OpenCV-SWIG library> -I<OpenCV include dir> -python -c++ my_lib.i
```

A `my_lib_wrap.cxx` and `my_lib.py` files will be generated containing the binding source
code.

On a Linux system the `my_lib_wrap.cxx` can be compiled to a `_my_lib.so` (as expected by
the Python interpreter) with the command:

```shell
g++ -shared -fpic $(pkg-config --cflags --libs python3) $(pkg-config --cflags --libs opencv4) my_lib_wrap.cxx -o _my_lib.so
```

Notice that the pkg-config package names (`python3` and `opencv4`) can be slightly
different on your particular system. That will create a Python module `my_lib` on the
current directory, and the code bellow should work just fine:

```Python
import my_lib
import numpy as np
import cv2

p0 = my_lib.Point(13, 17)
my_lib.moveTo(p0)

cv_img = my_lib.getImage()
np_arr = cv2.blur(np.asarray(cv_img), (3, 3))

cv_img2 = my_lib.Mat3b.from_array(np_arr)
```

## Install

To install, just copy all files under the `lib` directory to the same directory as the
SWIG Python modules (e.g.:`/usr/share/swig/4.0.1/python`). Another option is to copy the
`lib` directory to another path, `/home/bla/swig_libs` for example, and call SWIG with a
`-I<dir>` argument. Following the above example:

```
swig -I/home/bla/swig_libs -c++ -python my_lib.i
```

## Supported OpenCV versions

This library is known to work with all versions of OpenCV since 2.4.11. Before that no
tests were performed.

Currently all new commits are tested against OpenCV versions 3.3, 3.4, 4.0, 4.1, 4.2 and
4.3. Any new release beyond that range is expected to work, and new tests will be added
when due, but no guarantee can be done beforehand.

When used with an OpenCV version outside of that range, a warning like *"Warning 972:
Using an untested OpenCV version"* will be emitted. To silent it call SWIG with the flag
`-w972`.

[CI.badge]: https://github.com/renatoGarcia/opencv-swig/workflows/CI/badge.svg
[CI.link]: https://github.com/renatoGarcia/opencv-swig/actions?query=workflow%3ACI

[LICENSE.badge]: https://img.shields.io/badge/licence-BSD-blue
[LICENSE.link]: https://raw.githubusercontent.com/renatoGarcia/opencv-swig/master/LICENSE
