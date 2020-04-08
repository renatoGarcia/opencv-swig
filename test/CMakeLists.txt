cmake_minimum_required(VERSION 3.12)

project(opencv-swig-test)

cmake_policy(SET CMP0078 NEW)
cmake_policy(SET CMP0086 NEW)
find_package(SWIG REQUIRED)
set(CMAKE_SWIG_FLAGS "-I${CMAKE_CURRENT_SOURCE_DIR}/../lib/")
include(${SWIG_USE_FILE})

# set(TEST_PYTHON_VERSION "3"
#     CACHE STRING "Python version used on tests.")
# set_property(CACHE TEST_PYTHON_VERSION PROPERTY STRINGS "3" "2")

# if(TEST_PYTHON_VERSION EQUAL 2)
#     find_package(PythonLibs 2)
# else()
#     find_package(PythonLibs 3)
# endif()

find_package(Python3 COMPONENTS Interpreter Development)
find_package(OpenCV REQUIRED opencv_core)
find_package(Boost 1.69.0 REQUIRED)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
    ${OpenCV_INCLUDE_DIRS}
    ${Python3_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS})

enable_testing()

macro(ADD_TEST_RULES name)
    execute_process(COMMAND "${SWIG_EXECUTABLE}" "-python" "-c++"
        ${CMAKE_SWIG_FLAGS} "-MM" "${CMAKE_CURRENT_SOURCE_DIR}/${name}.i"
        OUTPUT_VARIABLE ${name}_DEPENDENCIES)

    # Remove the first line
    string(REGEX REPLACE "^.+: +\\\\\n +" ""
        ${name}_DEPENDENCIES "${${name}_DEPENDENCIES}")
    # Clean the end of each line
    string(REGEX REPLACE " +(\\\\)?\n" "\n"
        ${name}_DEPENDENCIES "${${name}_DEPENDENCIES}")
    # Clean beginning of each line
    string(REGEX REPLACE "\n +" "\n"
        ${name}_DEPENDENCIES "${${name}_DEPENDENCIES}")
    # clean paths
    string(REGEX REPLACE "\\\\\\\\" "/"
        ${name}_DEPENDENCIES "${${name}_DEPENDENCIES}")
    string(REGEX REPLACE "\n" ";"
        ${name}_DEPENDENCIES "${${name}_DEPENDENCIES}")

    set(SWIG_MODULE_${name}_EXTRA_DEPS ${${name}_DEPENDENCIES})
    set_property(SOURCE ${name}.i PROPERTY CPLUSPLUS ON)
    swig_add_library(${name} LANGUAGE python SOURCES ${name}.i ${name}.hpp)
    swig_link_libraries(${name} "${OpenCV_LIBRARIES}" ${Python3_LIBRARIES})
endmacro(ADD_TEST_RULES)

get_property(_include_directories DIRECTORY PROPERTY INCLUDE_DIRECTORIES)
foreach(_include_directory IN LISTS _include_directories)
    list(APPEND CMAKE_SWIG_FLAGS -I${_include_directory})
endforeach()

add_test_rules(range)
add_test_rules(scalar)
add_test_rules(point)
add_test_rules(size)
add_test_rules(rect)
add_test_rules(matx)
add_test_rules(vec)
add_test_rules(mat)
