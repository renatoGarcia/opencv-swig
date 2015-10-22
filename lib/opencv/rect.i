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
%include <opencv/size.i>

%define %cv_rect_instantiate(type, type_alias)
    #if !_CV_RECT_##type##_INSTANTIATED_
        %template(_Rect__##type) cv::Rect_< type >;
        %pythoncode
        %{
            Rect2##type_alias = _Rect__##type
        %}
        #define _CV_RECT_##type##_INSTANTIATED_
    #endif
%enddef

%header
%{
    #include <opencv2/core/core.hpp>
    #include <sstream>
%}

namespace cv
{
    template<typename _Tp> class Rect_
    {
    public:
        typedef _Tp value_type;

        //! various constructors
        Rect_();
        Rect_(_Tp _x, _Tp _y, _Tp _width, _Tp _height);
        Rect_(const Rect_& r);
        Rect_(const Point_<_Tp>& org, const Size_<_Tp>& sz);
        Rect_(const Point_<_Tp>& pt1, const Point_<_Tp>& pt2);

        /* Rect_& operator = ( const Rect_& r ); */
        //! the top-left corner
        Point_<_Tp> tl() const;
        //! the bottom-right corner
        Point_<_Tp> br() const;

        //! size (width, height) of the rectangle
        Size_<_Tp> size() const;
        //! area (width*height) of the rectangle
        _Tp area() const;

        //! conversion to another data type
        template<typename _Tp2> operator Rect_<_Tp2>() const;

        //! checks whether the rectangle contains the point
        bool contains(const Point_<_Tp>& pt) const;

        _Tp x, y, width, height; //< the top-left corner, as well as width and height of the rectangle
    };

    typedef Rect_<int> Rect2i;
    typedef Rect_<float> Rect2f;
    typedef Rect_<double> Rect2d;
    typedef Rect2i Rect;

}

%extend cv::Rect_
{
    %pythoncode
    {
        def __iter__(self):
            return iter((self.x, self.y, self.width, self.height))
    }

    char const* __str__()
    {
        std::ostringstream s;
        s << *$self;
        return s.str().c_str();
    }
}

/* %cv_rect_instantiate_defaults
 *
 * Generate a wrapper class to all cv::Rect_ which has a typedef on OpenCV header file.
 */
%define %cv_rect_instantiate_defaults
    %cv_rect_instantiate(int, i)
    %cv_rect_instantiate(float, f)
    %cv_rect_instantiate(double, d)
    %pythoncode
    {
        Rect = Rect2i
    }
%enddef
