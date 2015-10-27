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

/* %cv_scalar_instantiate(type, type_alias, np_basic_type)
 *
 *  Generete the wrapper code to a specific cv::Scalar_<> template instantiation.
 *
 *  type - The cv::Scalar_<> value type.
 *  type_alias - The value type alias used at the cv::Vec typedefs.
 *  np_basic_type - The character code[0] describing the numpy array item type.
 *
 *  For instance, the C++ type cv::Scalar_<double> would be instantiated with:
 *
 *      %cv_scalar_instantiate(double, d, f)
 *
 *  which would generate a wrapper Python class Scalar4d.
 *
 *  [0]: http://docs.scipy.org/doc/numpy/reference/arrays.interface.html#__array_interface__
 */
%define %cv_scalar_instantiate(type, type_alias, np_basic_type)
    #if !_CV_SCALAR_##type##_INSTANTIATED_
        %cv_vec_instantiate(type, 4, type_alias, np_basic_type)
        %template(_Scalar__##type) cv::Scalar_< type >;
        %pythoncode
        %{
            Scalar4##type_alias = _Scalar__##type
        %}
        #define _CV_SCALAR_##type##_INSTANTIATED_
    #endif
%enddef

%header
%{
    #include <opencv2/core/core.hpp>
    #include <sstream>
%}

namespace cv
{
    template<typename _Tp> class Scalar_ : public Vec<_Tp, 4>
    {
    public:
        //! various constructors
        Scalar_();
        Scalar_(_Tp v0, _Tp v1, _Tp v2=0, _Tp v3=0);
        Scalar_(_Tp v0);

        template<typename _Tp2, int cn>
            Scalar_(const Vec<_Tp2, cn>& v);

        //! returns a scalar with all elements set to v0
        static Scalar_<_Tp> all(_Tp v0);

        //! conversion to another data type
        template<typename T2> operator Scalar_<T2>() const;

        //! per-element product
        Scalar_<_Tp> mul(const Scalar_<_Tp>& a, double scale=1 ) const;

        // returns (v0, -v1, -v2, -v3)
        Scalar_<_Tp> conj() const;

        // returns true iff v1 == v2 == v3 == 0
        bool isReal() const;
    };

    typedef Scalar_<double> Scalar;
}

%extend cv::Scalar_
{
    %pythoncode
    {
        def __iter__(self):
            return iter((self(0), self(1), self(2), self(3)))

        def __getitem__(self, key):
            if not isinstance(key, int):
                raise TypeError

            if key >= 4:
                raise IndexError

            return self(key)
     }

    char const* __str__()
    {
        std::ostringstream s;
        s << *$self;
        return s.str().c_str();
    }
}


/* %cv_scalar_instantiate_defaults
 *
 * Generate a wrapper class to all cv::Scalar_<> which has a typedef on OpenCV header file.
 */
%define %cv_scalar_instantiate_defaults
    %cv_scalar_instantiate(double, d, f)
    %pythoncode
    {
        Scalar = Scalar4d
    }
%enddef
