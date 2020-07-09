# OpenCV-SWIG

[![CI.badge]][CI.link]
[![LICENSE.badge]][LICENSE.link]


## A SWIG library for OpenCV types

This library is a collection of [SWIG](http://swig.org/) interface files with rules to
wrap [OpenCV](https://opencv.org/) C++ types as [Python](https://www.python.org/) classes.
The OpenCV itself has a Python binding exposing its API, this library is not that.


## Hello, world!

The use case for this library is when someone writing a C++ library, which uses OpenCV
types on its public API, wants create a Python binding to that library.

Let's suppose you have built a C++ library named `MyLib` having a `my_lib.hpp` header:

```C++
#ifndef MY_LIB_HPP_INCLUDED
#define MY_LIB_HPP_INCLUDED

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

#endif /* MY_LIB_HPP_INCLUDED */
```

To generate a `MyLib` Python binding all you need is a `my_lib.i` SWIG file as:

```swig
%module my_lib

%include <opencv.i>
%cv_instantiate_all_defaults

%{
    #include "my_lib.hpp"
%}

%include "my_lib.hpp"
```

and a `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.0)

cmake_policy(SET CMP0074 NEW)
cmake_policy(SET CMP0078 NEW)
cmake_policy(SET CMP0086 NEW)

project(MyLib)

find_package(OpenCV-SWIG REQUIRED)
find_package(SWIG REQUIRED COMPONENTS python)
find_package(Boost REQUIRED)
find_package(OpenCV REQUIRED core)
find_package(Python REQUIRED COMPONENTS Interpreter Development)

include(UseSWIG)

set_property(SOURCE my_lib.i PROPERTY CPLUSPLUS ON)
swig_add_library(my_lib LANGUAGE python SOURCES my_lib.i my_lib.hpp)
set_property(
  TARGET my_lib
  PROPERTY SWIG_INCLUDE_DIRECTORIES
    ${OpenCV-SWIG_INCLUDE_DIRS}
    ${OpenCV_INCLUDE_DIRS}
)

target_include_directories(my_lib
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${Python_INCLUDE_DIRS}
    ${OpenCV_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
)

target_link_libraries(my_lib
  ${OpenCV_LIBRARIES}
)
```

After calling:

```shell
mkdir build
cd build
cmake .. -DOpenCV-SWIG_ROOT=</path/to/OpenCV-SWIG/install/dir/if/not/on/system/dir>
make
```

A Python module `my_lib.py` will be created on the current directory, and the code bellow
should work just fine:

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

To install, execute on the package root dir:

```shell
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=</path/to/install/dir>
make install
```

### Nix

If using [Nix](https://nixos.org/), any Git commit can be used as `buildInputs` with:

```text
opencv-swig = pkgs.callPackage (
  fetchTarball https://github.com/renatoGarcia/opencv-swig/archive/<git-commit-hash>.tar.gz
) {};
```

To built the [Hello, World!](#hello-world) example, a `shell.nix` as below will set a
correct environment:

```nix
let
  pkgs = import <nixpkgs> {};
  opencv-swig = pkgs.callPackage (
    fetchTarball https://github.com/renatoGarcia/opencv-swig/archive/v1.0.1.tar.gz
  ) {};

in pkgs.mkShell {
  buildInputs = [
    opencv-swig
    pkgs.boost
    pkgs.swig
    pkgs.cmake
    pkgs.pythonPackages.opencv
  ];
}
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
