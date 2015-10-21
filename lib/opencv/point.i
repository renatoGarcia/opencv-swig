/* Copyright (c) 2015, OpenCV-SWIG library authors (see AUTHORS file).
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific prior
 * written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
 * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
