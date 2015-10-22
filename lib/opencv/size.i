/* Copyright (c) 2015 The OpenCV-SWIG Library Developers. See the AUTHORS file at the
 * top-level directory of this distribution and at
 * https://github.com/renatoGarcia/opencv-swig/blob/master/AUTHORS.
 *
 * This file is part of OpenCV-SWIG Library. It is subject to the 3-clause BSD license
 * terms as in the LICENSE file found in the top-level directory of this distribution and
 * at https://github.com/renatoGarcia/opencv-swig/blob/master/LICENSE. No part of
 * OpenCV-SWIG Library, including this file, may be copied, modified, propagated, or
 * distributed except according to the terms contained in the LICENSE file.
 */

%include <opencv/point.i>

%define %cv_size_instantiate(type, type_alias)
    #if !_CV_SIZE_##type##_INSTANTIATED_
        %template(_Size__##type) cv::Size_< type >;
        %pythoncode
        %{
            Size2##type_alias = _Size__##type
        %}
        #define _CV_SIZE_##type##_INSTANTIATED_
    #endif
%enddef

%header
%{
    #include <opencv2/core/core.hpp>
    #include <sstream>
%}

namespace cv
{
    template<typename _Tp> class Size_
    {
    public:
        typedef _Tp value_type;

        //! various constructors
        Size_();
        Size_(_Tp _width, _Tp _height);
        Size_(const Size_& sz);
        Size_(const Point_<_Tp>& pt);

        /* Size_& operator = (const Size_& sz); */
        //! the area (width*height)
        _Tp area() const;

        /* //! conversion of another data type. */
        template<typename _Tp2> operator Size_<_Tp2>() const;

        _Tp width, height; // the width and the height
    };

    typedef Size_<int> Size2i;
    typedef Size_<float> Size2f;
    typedef Size_<double> Size2d;
    typedef Size2i Size;
}

%extend cv::Size_
{
    %pythoncode
    {
        def __iter__(self):
            return iter((self.width, self.height))
    }

    char const* __str__()
    {
        std::ostringstream s;
        s << *$self;
        return s.str().c_str();
    }
}

/* %cv_size_instantiate_defaults
 *
 * Generate a wrapper class to all cv::Size_ which has a typedef on OpenCV header file.
 */
%define %cv_size_instantiate_defaults
    %cv_size_instantiate(int, i)
    %cv_size_instantiate(float, f)
    %cv_size_instantiate(double, d)
    %pythoncode
    {
        Size = Size2i
    }
%enddef
