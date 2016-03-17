OpenCV-SWIG
===========

A SWIG library for OpenCV types
-------------------------------

This library is a collection of SWIG interface files with rules to wrap OpenCV types as
Python classes. The OpenCV itself has a Python binding exposing its API, this library is
not that.

Hello, world!
-------------

The use case of this library is when someone is writing a C++ library, which uses OpenCV
types on its API, and desires to create a Python binding to that library using SWIG.

Say you have built some C++ library `MyLib` having a `my_lib.hpp` header:

```C++
#include <opencv2/core.hpp>
#include <iostream>

inline
void moveTo(cv::Point const& p)
{
    std::cout << "cv::Point moved" << std::endl;
}

inline
cv::Mat3b getImage()
{
    return cv::Mat3b(3, 5);
}
```

To generate a Python binding to `MyLib` all that is needed is a `my_lib.i` SWIG file as:

```
%module my_lib

%include <opencv.i>
%cv_instantiate_all_defaults

%{
    #include "my_lib.hpp"
%}

%include "my_lib.hpp"
```

Running SWIG as in:

```shell
swig -I<path to OpenCV-SWIG library> -python -c++ my_lib.i
```

a `my_lib_wrap.cxx` and `my_lib.py` files will be generated containing the binding source
code.

In a Linux system the `my_lib_wrap.cxx` can be compiled to a `_my_lib.so` (as expected by
the Python interpreter) with the command:

```shell
g++ -shared -fpic my_lib_wrap.cxx $(pkg-config --cflags python3) $(pkg-config --libs opencv) -o _my_lib.so
```

That will create a Python module `my_lib` on the current directory, and the code bellow will
work just fine:

```Python
import my_lib
import numpy as np
import cv2

p0 = my_lib.Point(13, 17)
my_lib.moveTo(p0)

img = my_lib.getImage()
img = cv2.blur(np.asarray(img), (3, 3))
```

Installation
------------

To install, just copy all files under the `lib` directory to the same directory as SWIG
Python modules. Another option is move the `lib` directory to another path, say
`/home/bla/swig_libs`, and call SWIG with a `-I<dir>` argument. Following the above example:

```
swig -I/home/bla/swig_libs -c++ -python my_lib.i
```

License
-------
OpenCV-SWIG is distributed under the 3-clause BSD license.
