# - Find the OpenCV library
#
# This module will look by OpenCV libraries listed in components.
#
#   FIND_PACKAGE(OPENCV [REQUIRED|COMPONENTS] components...)
#
# It will work with both OpenCV 2.2.0 new libraries names and the previous
# libraries names.
#
# If OPENCV_DIR is set, the search under it will have precedence above
# the system path.
#
# This module defines:
#  OPENCV_INCLUDE_DIRS          Where to find the library headers.
#  OPENCV_LIBRARIES             All found libraries path.
#  OPENCV_FOUND                 True if the library was found.
#
#  OPENCV_VERSION_STRING        The found OpenCV version.
#  OPENCV_VERSION_MAJOR         The major version of the OpenCV found.
#  OPENCV_VERSION_MINOR         The minor version of the OpenCV found.
#  OPENCV_VERSION_PATCH         The patch version of the OpenCV found.
#
# Cached Variables:
#  OPENCV_INCLUDE_DIR           Path to library headers.
#  OPENCV_${COMPONENT}_LIBRARY  Path to the found library.
#
#=============================================================================
# Copyright 2011-2015 Renato Florentino Garcia
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, on version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# =========================================================================

find_path(OPENCV_INCLUDE_DIR opencv2/core/version.hpp HINTS ${OPENCV_DIR}/include)
set(OPENCV_VERSION_FILE ${OPENCV_INCLUDE_DIR}/opencv2/core/version.hpp)
if(NOT EXISTS ${OPENCV_INCLUDE_DIR})
    find_path(OPENCV_INCLUDE_DIR opencv/cvver.h HINTS ${OPENCV_DIR}/include)
    set(OPENCV_VERSION_FILE ${OPENCV_INCLUDE_DIR}/opencv/cvver.h)
endif()

if(EXISTS ${OPENCV_VERSION_FILE})
    file(STRINGS ${OPENCV_VERSION_FILE} OPENCV_VERSIONS REGEX "^#define CV_VERSION_[A-Z]+[ \t]+[0-9]+[ ]*$")
    file(STRINGS ${OPENCV_VERSION_FILE} OPENCV_OLD_VERSIONS REGEX "^#define CV_[A-Z]+_VERSION[ \t]+[0-9]+[ ]*$")

    if(OPENCV_VERSIONS)
        string(REGEX REPLACE ".*#define CV_VERSION_EPOCH[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_MAJOR ${OPENCV_VERSIONS})
        string(REGEX REPLACE ".*#define CV_VERSION_MAJOR[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_MINOR ${OPENCV_VERSIONS})
        string(REGEX REPLACE ".*#define CV_VERSION_MINOR[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_PATCH ${OPENCV_VERSIONS})
        string(REGEX REPLACE ".*#define CV_VERSION_REVISION[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_TWEAK ${OPENCV_VERSIONS})
    else()
        string(REGEX REPLACE ".*#define CV_MAJOR_VERSION[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_MAJOR ${OPENCV_OLD_VERSIONS})
        string(REGEX REPLACE ".*#define CV_MINOR_VERSION[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_MINOR ${OPENCV_OLD_VERSIONS})
        string(REGEX REPLACE ".*#define CV_SUBMINOR_VERSION[ \t]+([0-9]+).*" "\\1" OPENCV_VERSION_PATCH ${OPENCV_OLD_VERSIONS})
    endif()

    set(OPENCV_VERSION_STRING ${OPENCV_VERSION_MAJOR}.${OPENCV_VERSION_MINOR}.${OPENCV_VERSION_PATCH})
    if(OPENCV_VERSION_TWEAK)
        set(OPENCV_VERSION_STRING ${OPENCV_VERSION_STRING}.${OPENCV_VERSION_MAJOR})
    endif()
endif()

foreach(OPENCV_COMPONENT ${OPENCV_FIND_COMPONENTS})
    string(TOUPPER ${OPENCV_COMPONENT} OPENCV_UPPER_COMPONENT)
    if(WIN32)
        set(OPENCV_COMPONENT ${OPENCV_COMPONENT}${OPENCV_VERSION_MAJOR}${OPENCV_VERSION_MINOR}${OPENCV_VERSION_PATCH})
    endif()
    find_library(OPENCV_${OPENCV_UPPER_COMPONENT}_LIBRARY ${OPENCV_COMPONENT} HINTS ${OPENCV_DIR}/lib)

    list(APPEND OPENCV_COMPONENTS_LIST OPENCV_${OPENCV_UPPER_COMPONENT}_LIBRARY)
    list(APPEND OPENCV_LIBRARIES ${OPENCV_${OPENCV_UPPER_COMPONENT}_LIBRARY})
endforeach()

set(OPENCV_INCLUDE_DIRS ${OPENCV_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OPENCV DEFAULT_MSG ${OPENCV_COMPONENTS_LIST} OPENCV_INCLUDE_DIR)

mark_as_advanced(OPENCV_INCLUDE_DIR ${OPENCV_COMPONENTS_LIST})
