# DEV_HASH: $Format:%H$

cmake_minimum_required(VERSION 3.12)
cmake_policy(SET CMP0048 NEW)

include(CMakePackageConfigHelpers)


project(opencv-swig VERSION 1.0.0 LANGUAGES NONE)

if(WIN32 AND NOT CYGWIN)
  set(DEF_INSTALL_CMAKE_DIR CMake)
else()
  set(DEF_INSTALL_CMAKE_DIR "lib/cmake/OpenCV-SWIG")
  set(DEF_INSTALL_SWIGLIB_DIR "share/swig/any")
endif()

set(
  OpenCV-SWIG_CMAKE_DIR ${DEF_INSTALL_CMAKE_DIR} CACHE PATH
  "Installation directory for CMake files"
)

set(
  OpenCV-SWIG_LIBDIR ${DEF_INSTALL_SWIGLIB_DIR} CACHE PATH
  "Installation directory for SWIG library files"
)

configure_package_config_file(OpenCV-SWIGConfig.cmake.in
  "${PROJECT_BINARY_DIR}/OpenCV-SWIGConfig.cmake"
  INSTALL_DESTINATION ${OpenCV-SWIG_CMAKE_DIR}
  PATH_VARS OpenCV-SWIG_LIBDIR
)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/OpenCV-SWIGConfigVersion.cmake"
  COMPATIBILITY SameMajorVersion
  ARCH_INDEPENDENT
)

install(
  FILES
    "${PROJECT_BINARY_DIR}/OpenCV-SWIGConfig.cmake"
    "${PROJECT_BINARY_DIR}/OpenCV-SWIGConfigVersion.cmake"
  DESTINATION ${OpenCV-SWIG_CMAKE_DIR}
)

install(
  DIRECTORY lib/
  DESTINATION ${OpenCV-SWIG_LIBDIR}
  FILES_MATCHING PATTERN "*.i"
)
