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
