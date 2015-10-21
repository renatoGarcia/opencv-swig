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
