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

%include <opencv/vec.i>

%define %cv_point_instantiate(type, type_alias)
    #if !_CV_POINT_##type##_INSTANTIATED_
        %template(_Point__##type) cv::Point_< type >;
        %pythoncode
        %{
            Point2##type_alias = _Point__##type
        %}
        #define _CV_POINT_##type##_INSTANTIATED_
    #endif
%enddef

%header
%{
    #include <opencv2/core/core.hpp>
    #include <sstream>
%}

namespace cv
{
    template<typename _Tp> class Point_
    {
    public:
        typedef _Tp value_type;

        // various constructors
        Point_();
        Point_(_Tp _x, _Tp _y);
        /* Point_(const Point_& pt); */
        /* Point_(const Size_<_Tp>& sz); */
        Point_(const Vec<_Tp, 2>& v);

        /* Point_& operator = (const Point_& pt); */
        /* //! conversion to another data type */
        /* template<typename _Tp2> operator Point_<_Tp2>() const; */

        /* //! conversion to the old-style C structures */
        /* operator Vec<_Tp, 2>() const; */

        //! dot product
        _Tp dot(const Point_& pt) const;
        //! dot product computed in double-precision arithmetics
        double ddot(const Point_& pt) const;
        //! cross-product
        double cross(const Point_& pt) const;
        /* //! checks whether the point is inside the specified rectangle */
        /* bool inside(const Rect_<_Tp>& r) const; */

        _Tp x, y; //< the point coordinates
    };

    typedef Point_<int> Point2i;
    typedef Point_<float> Point2f;
    typedef Point_<double> Point2d;
    typedef Point2i Point;
}

%extend cv::Point_
{
    %pythoncode
    {
        def __iter__(self):
            return iter((self.x, self.y))
    }

    char const* __str__()
    {
        std::ostringstream s;
        s << *$self;
        return s.str().c_str();
    }
}

/* %cv_point_instantiate_defaults
 *
 * Generate a wrapper class to all cv::Point_ which has a typedef on OpenCV header file.
 */
%define %cv_point_instantiate_defaults
    %cv_point_instantiate(int, i)
    %cv_point_instantiate(float, f)
    %cv_point_instantiate(double, d)
    %pythoncode
    {
        Point = Point2i
    }
%enddef
