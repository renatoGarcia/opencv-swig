/*M///////////////////////////////////////////////////////////////////////////////////////
//
//  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
//
//  By downloading, copying, installing or using the software you agree to this license.
//  If you do not agree to this license, do not download, install,
//  copy or use the software.
//
//
//                          License Agreement
//                For Open Source Computer Vision Library
//
// Copyright (C) 2000-2008, Intel Corporation, all rights reserved.
// Copyright (C) 2009, Willow Garage Inc., all rights reserved.
// Copyright (C) 2013, OpenCV Foundation, all rights reserved.
// Third party copyrights are property of their respective owners.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
//   * Redistribution's of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//   * Redistribution's in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//   * The name of the copyright holders may not be used to endorse or promote products
//     derived from this software without specific prior written permission.
//
// This software is provided by the copyright holders and contributors "as is" and
// any express or implied warranties, including, but not limited to, the implied
// warranties of merchantability and fitness for a particular purpose are disclaimed.
// In no event shall the Intel Corporation or contributors be liable for any direct,
// indirect, incidental, special, exemplary, or consequential damages
// (including, but not limited to, procurement of substitute goods or services;
// loss of use, data, or profits; or business interruption) however caused
// and on any theory of liability, whether in contract, strict liability,
// or tort (including negligence or otherwise) arising in any way out of
// the use of this software, even if advised of the possibility of such damage.
//
//M*/

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

%include <opencv/_common.i>

namespace cv
{
    class Mat
    {
    public:
        Mat();
        Mat(int rows, int cols, int type);
        Mat(Size size, int type);
        Mat(int rows, int cols, int type, const Scalar& s);
        Mat(Size size, int type, const Scalar& s);
        Mat(int ndims, const int* sizes, int type);
        Mat(int ndims, const int* sizes, int type, const Scalar& s);
        Mat(const Mat& m);
        Mat(int rows, int cols, int type, void* data, size_t step=AUTO_STEP);
        Mat(Size size, int type, void* data, size_t step=AUTO_STEP);
        Mat(int ndims, const int* sizes, int type, void* data, const size_t* steps=0);
        Mat(const Mat& m, const Range& rowRange, const Range& colRange=Range::all());
        Mat(const Mat& m, const Rect& roi);
        Mat(const Mat& m, const Range* ranges);
        template<typename _Tp> explicit Mat(const std::vector<_Tp>& vec, bool copyData=false);
        template<typename _Tp, int n> explicit Mat(const Vec<_Tp, n>& vec, bool copyData=true);
        template<typename _Tp, int m, int n> explicit Mat(const Matx<_Tp, m, n>& mtx, bool copyData=true);
        template<typename _Tp> explicit Mat(const Point_<_Tp>& pt, bool copyData=true);
        /* template<typename _Tp> explicit Mat(const Point3_<_Tp>& pt, bool copyData=true); */
        /* template<typename _Tp> explicit Mat(const MatCommaInitializer_<_Tp>& commaInitializer); */

        /* explicit Mat(const cuda::GpuMat& m); */

        ~Mat();

        Mat& operator = (const Mat& m);
        /* Mat& operator = (const MatExpr& expr); */
        /* UMat getUMat(int accessFlags, UMatUsageFlags usageFlags = USAGE_DEFAULT) const; */

        Mat row(int y) const;

        Mat col(int x) const;

        Mat rowRange(int startrow, int endrow) const;

        Mat rowRange(const Range& r) const;

        Mat colRange(int startcol, int endcol) const;

        Mat colRange(const Range& r) const;

        Mat diag(int d=0) const;

        /* static Mat diag(const Mat& d); */

        Mat clone() const;

        /* void copyTo( OutputArray m ) const; */

        /* void copyTo( OutputArray m, InputArray mask ) const; */

        /* void convertTo( OutputArray m, int rtype, double alpha=1, double beta=0 ) const; */

        void assignTo( Mat& m, int type=-1 ) const;

        Mat& operator = (const Scalar& s);

        /* Mat& setTo(InputArray value, InputArray mask=noArray()); */

        Mat reshape(int cn, int rows=0) const;
        Mat reshape(int cn, int newndims, const int* newsz) const;

        /* MatExpr t() const; */

        /* MatExpr inv(int method=DECOMP_LU) const; */

        /* MatExpr mul(InputArray m, double scale=1) const; */

        /* Mat cross(InputArray m) const; */
        /* double dot(InputArray m) const; */

        /* static MatExpr zeros(int rows, int cols, int type); */

        /* static MatExpr zeros(Size size, int type); */

        /* static MatExpr zeros(int ndims, const int* sz, int type); */

        /* static MatExpr ones(int rows, int cols, int type); */

        /* static MatExpr ones(Size size, int type); */

        /* static MatExpr ones(int ndims, const int* sz, int type); */

        /* static MatExpr eye(int rows, int cols, int type); */

        /* static MatExpr eye(Size size, int type); */

        void create(int rows, int cols, int type);

        void create(Size size, int type);

        void create(int ndims, const int* sizes, int type);

        void addref();

        void release();

        void deallocate();
        void copySize(const Mat& m);

        void reserve(size_t sz);

        void resize(size_t sz);

        void resize(size_t sz, const Scalar& s);

        void push_back_(const void* elem);

        template<typename _Tp> void push_back(const _Tp& elem);

        template<typename _Tp> void push_back(const Mat_<_Tp>& elem);

        void push_back(const Mat& m);

        void pop_back(size_t nelems=1);

        void locateROI( Size& wholeSize, Point& ofs ) const;

        Mat& adjustROI( int dtop, int dbottom, int dleft, int dright );

        Mat operator()( Range rowRange, Range colRange ) const;

        Mat operator()( const Rect& roi ) const;

        Mat operator()( const Range* ranges ) const;

        template<typename _Tp> operator std::vector<_Tp>() const;
        template<typename _Tp, int n> operator Vec<_Tp, n>() const;
        template<typename _Tp, int m, int n> operator Matx<_Tp, m, n>() const;

        bool isContinuous() const;

        bool isSubmatrix() const;

        size_t elemSize() const;

        size_t elemSize1() const;

        int type() const;

        int depth() const;

        int channels() const;

        size_t step1(int i=0) const;

        bool empty() const;

        size_t total() const;

        int checkVector(int elemChannels, int depth=-1, bool requireContinuous=true) const;

        uchar* ptr(int i0=0);
        const uchar* ptr(int i0=0) const;

        uchar* ptr(int i0, int i1);
        const uchar* ptr(int i0, int i1) const;

        uchar* ptr(int i0, int i1, int i2);
        const uchar* ptr(int i0, int i1, int i2) const;

        uchar* ptr(const int* idx);
        const uchar* ptr(const int* idx) const;
        template<int n> uchar* ptr(const Vec<int, n>& idx);
        template<int n> const uchar* ptr(const Vec<int, n>& idx) const;

        /* template<typename _Tp> _Tp* ptr(int i0=0); */
        /* template<typename _Tp> const _Tp* ptr(int i0=0) const; */
        /* template<typename _Tp> _Tp* ptr(int i0, int i1); */
        /* template<typename _Tp> const _Tp* ptr(int i0, int i1) const; */
        /* template<typename _Tp> _Tp* ptr(int i0, int i1, int i2); */
        /* template<typename _Tp> const _Tp* ptr(int i0, int i1, int i2) const; */
        /* template<typename _Tp> _Tp* ptr(const int* idx); */
        /* template<typename _Tp> const _Tp* ptr(const int* idx) const; */
        /* template<typename _Tp, int n> _Tp* ptr(const Vec<int, n>& idx); */
        /* template<typename _Tp, int n> const _Tp* ptr(const Vec<int, n>& idx) const; */

        template<typename _Tp> _Tp& at(int i0=0);
        template<typename _Tp> const _Tp& at(int i0=0) const;
        template<typename _Tp> _Tp& at(int i0, int i1);
        template<typename _Tp> const _Tp& at(int i0, int i1) const;
        template<typename _Tp> _Tp& at(int i0, int i1, int i2);
        template<typename _Tp> const _Tp& at(int i0, int i1, int i2) const;
        template<typename _Tp> _Tp& at(const int* idx);
        template<typename _Tp> const _Tp& at(const int* idx) const;
        template<typename _Tp, int n> _Tp& at(const Vec<int, n>& idx);
        template<typename _Tp, int n> const _Tp& at(const Vec<int, n>& idx) const;
        template<typename _Tp> _Tp& at(Point pt);
        template<typename _Tp> const _Tp& at(Point pt) const;
        /* template<typename _Tp> MatIterator_<_Tp> begin(); */
        /* template<typename _Tp> MatConstIterator_<_Tp> begin() const; */

        /* %template(atkkk) at<uint8_t>; */
        /* %template(atkkk) at<uint8_t>; */

        /* template<typename _Tp> MatIterator_<_Tp> end(); */
        /* template<typename _Tp> MatConstIterator_<_Tp> end() const; */

        template<typename _Tp, typename Functor> void forEach(const Functor& operation);
        template<typename _Tp, typename Functor> void forEach(const Functor& operation) const;

        enum { MAGIC_VAL  = 0x42FF0000, AUTO_STEP = 0, CONTINUOUS_FLAG = CV_MAT_CONT_FLAG, SUBMATRIX_FLAG = CV_SUBMAT_FLAG };
        enum { MAGIC_MASK = 0xFFFF0000, TYPE_MASK = 0x00000FFF, DEPTH_MASK = 7 };

        int flags;
        int dims;
        int rows, cols;
        uchar* data;

        const uchar* datastart;
        const uchar* dataend;
        const uchar* datalimit;

        /* MatAllocator* allocator; */
        /* static MatAllocator* getStdAllocator(); */

        /* UMatData* u; */

        /* MatSize size; */
        /* MatStep step; */

    protected:
        template<typename _Tp, typename Functor> void forEach_impl(const Functor& operation);
    };

    template<typename _Tp> class Mat_ : public Mat
    {
    public:
        typedef _Tp value_type;
        typedef typename DataType<_Tp>::channel_type channel_type;
        /* typedef MatIterator_<_Tp> iterator; */
        /* typedef MatConstIterator_<_Tp> const_iterator; */

        Mat_();
        Mat_(int _rows, int _cols);
        /* Mat_(int _rows, int _cols, const _Tp& value); */
        explicit Mat_(Size _size);
        Mat_(Size _size, const _Tp& value);
        Mat_(int _ndims, const int* _sizes);
        /* Mat_(int _ndims, const int* _sizes, const _Tp& value); */
        Mat_(const Mat& m);
        Mat_(const Mat_& m);
        /* Mat_(int _rows, int _cols, value_type* _data, size_t _step=0); */
        /* Mat_(int _ndims, const int* _sizes, _Tp* _data, const size_t* _steps=0); */
        Mat_(const Mat_& m, const Range& rowRange, const Range& colRange=Range::all());
        Mat_(const Mat_& m, const Rect& roi);
        /* Mat_(const Mat_& m, const Range* ranges); */
        /* explicit Mat_(const MatExpr& e); */
        explicit Mat_(const std::vector<_Tp>& vec, bool copyData=false);
        template<int n> explicit Mat_(const Vec<typename DataType<_Tp>::channel_type, n>& vec, bool copyData=true);
        template<int m, int n> explicit Mat_(const Matx<typename DataType<_Tp>::channel_type, m, n>& mtx, bool copyData=true);
        explicit Mat_(const Point_<typename DataType<_Tp>::channel_type>& pt, bool copyData=true);
        /* explicit Mat_(const Point3_<typename DataType<_Tp>::channel_type>& pt, bool copyData=true); */
        /* explicit Mat_(const MatCommaInitializer_<_Tp>& commaInitializer); */

        /* Mat_& operator = (const Mat& m); */
        /* Mat_& operator = (const Mat_& m); */
        /* Mat_& operator = (const _Tp& s); */
        /* Mat_& operator = (const MatExpr& e); */

        /* iterator begin(); */
        /* iterator end(); */
        /* const_iterator begin() const; */
        /* const_iterator end() const; */

        template<typename Functor> void forEach(const Functor& operation);
        template<typename Functor> void forEach(const Functor& operation) const;

        void create(int _rows, int _cols);
        void create(Size _size);
        void create(int _ndims, const int* _sizes);
        Mat_ cross(const Mat_& m) const;
        template<typename T2> operator Mat_<T2>() const;
        Mat_ row(int y) const;
        Mat_ col(int x) const;
        Mat_ diag(int d=0) const;
        Mat_ clone() const;

        size_t elemSize() const;
        size_t elemSize1() const;
        int type() const;
        int depth() const;
        int channels() const;
        size_t step1(int i=0) const;
        size_t stepT(int i=0) const;

        /* static MatExpr zeros(int rows, int cols); */
        /* static MatExpr zeros(Size size); */
        /* static MatExpr zeros(int _ndims, const int* _sizes); */
        /* static MatExpr ones(int rows, int cols); */
        /* static MatExpr ones(Size size); */
        /* static MatExpr ones(int _ndims, const int* _sizes); */
        /* static MatExpr eye(int rows, int cols); */
        /* static MatExpr eye(Size size); */

        Mat_& adjustROI( int dtop, int dbottom, int dleft, int dright );
        Mat_ operator()( const Range& rowRange, const Range& colRange ) const;
        Mat_ operator()( const Rect& roi ) const;
        Mat_ operator()( const Range* ranges ) const;

        /* _Tp* operator [](int y); */
        /* const _Tp* operator [](int y) const; */

        _Tp& operator ()(const int* idx);
        const _Tp& operator ()(const int* idx) const;

        template<int n> _Tp& operator ()(const Vec<int, n>& idx);
        template<int n> const _Tp& operator ()(const Vec<int, n>& idx) const;

        _Tp& operator ()(int idx0);
        const _Tp& operator ()(int idx0) const;
        _Tp& operator ()(int idx0, int idx1);
        const _Tp& operator ()(int idx0, int idx1) const;
        _Tp& operator ()(int idx0, int idx1, int idx2);
        const _Tp& operator ()(int idx0, int idx1, int idx2) const;

        _Tp& operator ()(Point pt);
        const _Tp& operator ()(Point pt) const;

        /* operator std::vector<_Tp>() const; */
        template<int n> operator Vec<typename DataType<_Tp>::channel_type, n>() const;
        template<int m, int n> operator Matx<typename DataType<_Tp>::channel_type, m, n>() const;
    };

    typedef Mat_<uchar> Mat1b;
    typedef Mat_<Vec2b> Mat2b;
    typedef Mat_<Vec3b> Mat3b;
    typedef Mat_<Vec4b> Mat4b;

    typedef Mat_<short> Mat1s;
    typedef Mat_<Vec2s> Mat2s;
    typedef Mat_<Vec3s> Mat3s;
    typedef Mat_<Vec4s> Mat4s;

    typedef Mat_<ushort> Mat1w;
    typedef Mat_<Vec2w> Mat2w;
    typedef Mat_<Vec3w> Mat3w;
    typedef Mat_<Vec4w> Mat4w;

    typedef Mat_<int>   Mat1i;
    typedef Mat_<Vec2i> Mat2i;
    typedef Mat_<Vec3i> Mat3i;
    typedef Mat_<Vec4i> Mat4i;

    typedef Mat_<float> Mat1f;
    typedef Mat_<Vec2f> Mat2f;
    typedef Mat_<Vec3f> Mat3f;
    typedef Mat_<Vec4f> Mat4f;

    typedef Mat_<double> Mat1d;
    typedef Mat_<Vec2d> Mat2d;
    typedef Mat_<Vec3d> Mat3d;
    typedef Mat_<Vec4d> Mat4d;
}
