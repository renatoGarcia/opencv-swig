cmake_minimum_required(VERSION 3.1)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})

find_package(SWIG REQUIRED)
set(CMAKE_SWIG_FLAGS "-I${CMAKE_CURRENT_SOURCE_DIR}/../lib/")
include(${SWIG_USE_FILE})

find_package(PythonLibs 2.7)
include_directories(${PYTHON_INCLUDE_PATH})

find_package(OPENCV REQUIRED opencv_core)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
    ${OPENCV_INCLUDE_DIRS}
    ${PYTHON_INCLUDE_PATH})

enable_testing()

set_source_files_properties(point.i PROPERTIES CPLUSPLUS ON)
swig_add_module(point python point.i point.hpp)
swig_link_libraries(point ${OPENCV_LIBRARIES})
file(COPY run_point.py DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
add_test(NAME point COMMAND ./run_point.py)

set_source_files_properties(size.i PROPERTIES CPLUSPLUS ON)
swig_add_module(size python size.i size.hpp)
swig_link_libraries(size ${OPENCV_LIBRARIES})
file(COPY run_size.py DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
add_test(NAME size COMMAND ./run_size.py)

set_source_files_properties(rect.i PROPERTIES CPLUSPLUS ON)
swig_add_module(rect python rect.i rect.hpp)
swig_link_libraries(rect ${OPENCV_LIBRARIES})
file(COPY run_rect.py DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
add_test(NAME rect COMMAND ./run_rect.py)

set_source_files_properties(mat.i PROPERTIES CPLUSPLUS ON)
swig_add_module(mat python mat.i mat.hpp)
swig_link_libraries(mat ${OPENCV_LIBRARIES})
file(COPY run_mat.py DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
add_test(NAME mat COMMAND ./run_mat.py)
