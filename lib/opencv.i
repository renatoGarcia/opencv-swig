%include "opencv/point.i"

%header %{

#define NPY_NO_DEPRECATED_API NPY_1_9_API_VERSION

#include <opencv2/core/core.hpp>
#include <numpy/ndarrayobject.h>
#include <iostream>

%}

%init
%{
    import_array();
%}


//-------------------------------------------------------------------- cv::Size

#define CV_SIZE(type, format)                                              \
%typemap(out) cv::Size_<type >                                             \
{                                                                          \
    $result = Py_BuildValue("(format)", $1.width, $1.height);              \
}                                                                          \
%typemap(out) cv::Size_<type >&, cv::Size_<type >*                         \
{                                                                          \
    $result = Py_BuildValue("(format)", $1->width, $1->height);            \
}                                                                          \
%typemap(in) cv::Size_<type >                                              \
{                                                                          \
    type width, height;                                                    \
    if(!PyArg_ParseTuple($input, "format", &width, &height))               \
    {                                                                      \
        PyErr_SetString(PyExc_ValueError,                                  \
                        "Error converting python tuple to cv::Size.");     \
        return NULL;                                                       \
    }                                                                      \
    $1 = cv::Size_<type >(width, height);                                  \
}                                                                          \
%typemap(in) cv::Size_<type >&, cv::Size_<type >*                          \
{                                                                          \
    type width, height;                                                    \
    if(!PyArg_ParseTuple($input, "format", &width, &height))               \
    {                                                                      \
        PyErr_SetString(PyExc_ValueError,                                  \
                        "Error converting python tuple to cv::Size.");     \
        return NULL;                                                       \
    }                                                                      \
    $1 = new cv::Size_<type >(width, height);                              \
}                                                                          \
%typemap(freearg) cv::Size_<type >&, cv::Size_<type >*                     \
{                                                                          \
    delete $1;                                                             \
}                                                                          \
%typemap(typecheck) cv::Size_<type >, cv::Size_<type >&, cv::Size_<type >* \
{                                                                          \
    $1 = PySequence_Check($input) && (PySequence_Size($input) == 2);       \
}

CV_SIZE(int, ii)
CV_SIZE(double, dd)
CV_SIZE(float, ff)
%apply cv::Size_<int> { cv::Size, cv::Size2i };
%apply cv::Size_<int>& { cv::Size&, cv::Size2i& };
%apply cv::Size_<int>* { cv::Size*, cv::Size2i* };
%apply cv::Size_<double> { cv::Size2d };
%apply cv::Size_<double>& { cv::Size2d& };
%apply cv::Size_<double>* { cv::Size2d* };
%apply cv::Size_<float> { cv::Size2f };
%apply cv::Size_<float>& { cv::Size2f& };
%apply cv::Size_<float>* { cv::Size2f* };


//-------------------------------------------------------------------- cv::Rect

#define CV_RECT(type, format)                                                 \
%typemap(out) cv::Rect_<type >                                                \
{                                                                             \
    $result = Py_BuildValue("(format)", $1.x, $1.y, $1.width, $1.height);     \
}                                                                             \
%typemap(out) cv::Rect_<type >&, cv::Rect_<type >*                            \
{                                                                             \
    $result = Py_BuildValue("(format)", $1->x, $1->y, $1->width, $1->height); \
}                                                                             \
%typemap(in) cv::Rect_<type >                                                 \
{                                                                             \
    type x, y, w, h;                                                          \
    if(!PyArg_ParseTuple($input, "format", &x, &y, &w, &h))                   \
    {                                                                         \
        PyErr_SetString(PyExc_ValueError,                                     \
                        "Error converting python tuple to cv::Rect.");        \
        return NULL;                                                          \
    }                                                                         \
    $1 = cv::Rect_<type >(x, y, w, h);                                        \
}                                                                             \
%typemap(in) cv::Rect_<type >&, cv::Rect_<type >*                             \
{                                                                             \
    type x, y, w, h;                                                          \
    if(!PyArg_ParseTuple($input, "format", &x, &y, &w, &h))                   \
    {                                                                         \
        PyErr_SetString(PyExc_ValueError,                                     \
                        "Error converting python tuple to cv::Rect.");        \
        return NULL;                                                          \
    }                                                                         \
    $1 = new cv::Rect_<type >(x, y, w, h);                                    \
}                                                                             \
%typemap(freearg) cv::Rect_<type >&, cv::Rect_<type >*                        \
{                                                                             \
    delete $1;                                                                \
}                                                                             \
%typemap(typecheck) cv::Rect_<type >, cv::Rect_<type >&, cv::Rect_<type >*    \
{                                                                             \
    $1 = PySequence_Check($input) && (PySequence_Size($input) == 4);          \
}

CV_RECT(int, iiii)
CV_RECT(double, dddd)
CV_RECT(float, ffff)
%apply cv::Rect_<int> { cv::Rect };
%apply cv::Rect_<int>& { cv::Rect& };
%apply cv::Rect_<int>* { cv::Rect* };

//-------------------------------------------------------------------- cv::Mat_<>

namespace cv
{
    template<typename _Tp, int cn> class Vec;

    typedef Vec<uchar, 2> Vec2b;
    typedef Vec<uchar, 3> Vec3b;
    typedef Vec<uchar, 4> Vec4b;

    typedef Vec<short, 2> Vec2s;
    typedef Vec<short, 3> Vec3s;
    typedef Vec<short, 4> Vec4s;

    typedef Vec<ushort, 2> Vec2w;
    typedef Vec<ushort, 3> Vec3w;
    typedef Vec<ushort, 4> Vec4w;

    typedef Vec<int, 2> Vec2i;
    typedef Vec<int, 3> Vec3i;
    typedef Vec<int, 4> Vec4i;
    typedef Vec<int, 6> Vec6i;
    typedef Vec<int, 8> Vec8i;

    typedef Vec<float, 2> Vec2f;
    typedef Vec<float, 3> Vec3f;
    typedef Vec<float, 4> Vec4f;
    typedef Vec<float, 6> Vec6f;

    typedef Vec<double, 2> Vec2d;
    typedef Vec<double, 3> Vec3d;
    typedef Vec<double, 4> Vec4d;
    typedef Vec<double, 6> Vec6d;

    template<typename _Tp> class Mat_;

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

%fragment("cvMat", "header")
{
    PyArrayObject* cvMatAsNpArray(const cv::Mat& mat)
    {
        int type = mat.type();
        int const* sizes = mat.size;
        int dims = mat.dims;

        int depth = CV_MAT_DEPTH(type);
        int cn = CV_MAT_CN(type);
        const int f = (int)(sizeof(size_t)/8);
        int typenum = depth == CV_8U ? NPY_UINT8 :
                      depth == CV_8S ? NPY_INT8 :
                      depth == CV_16U ? NPY_UINT16 :
                      depth == CV_16S ? NPY_INT16 :
                      depth == CV_32S ? NPY_INT32 :
                      depth == CV_32F ? NPY_FLOAT32 :
                      depth == CV_64F ? NPY_FLOAT64 :
                     -1;

        npy_intp _sizes[CV_MAX_DIM + 1];
        for (int i = 0; i < dims; ++i)
        {
            _sizes[i] = sizes[i];
        }

        if( cn > 1 )
        {
            /*if( _sizes[dims-1] == 1 )
              _sizes[dims-1] = cn;
              else*/
            _sizes[dims++] = cn;
        }

        PyArrayObject* o = (PyArrayObject*)PyArray_SimpleNew(dims, _sizes, typenum);
        memcpy(PyArray_DATA(o), (void*)mat.data, mat.elemSize() * mat.total());

        return o;
    }

    template <typename T>
    cv::Mat_<T> npArrayAsCvMat(PyObject* o, int ndims, int dtype)
    {
        if (!PyArray_Check(o))
        {
            PyErr_SetString(PyExc_ValueError, "Value must be a Numpy Array.");
            // return NULL;
        }

        PyArrayObject* array = (PyArrayObject*)o;

        if (!PyArray_IS_C_CONTIGUOUS(array))
        {
            PyErr_SetString(PyExc_ValueError, "The Numpy Array must be contiguous.");
            // return NULL;
        }

        if (PyArray_NDIM(array) != ndims)
        {
            PyErr_SetString(PyExc_ValueError,
                            "The Numpy Array dimensions number is incompatible.");
            // return NULL;
        }

        if (PyArray_DTYPE(array)->type_num != dtype)
        {
            // SWIG_fail;
        }

        npy_intp* shape = PyArray_SHAPE(array);
        if (ndims == 3 && shape[2] != 3) /* if not 3 channels */
        {
            // SWIG_fail;
        }

        cv::Mat_<T> mat(shape[0], shape[1], (T*)PyArray_DATA(array));

        return mat;
    }

    cv::Mat npArrayAsCvMat(PyObject* o)
    {
        if (!PyArray_Check(o))
        {
            PyErr_SetString(PyExc_ValueError, "Value must be a Numpy Array.");
            // return NULL;
        }

        PyArrayObject* array = (PyArrayObject*)o;

        if (!PyArray_IS_C_CONTIGUOUS(array))
        {
            PyErr_SetString(PyExc_ValueError, "The Numpy Array must be contiguous.");
            // return NULL;
        }

        int const ndims = PyArray_NDIM(array);
        int const dtype = PyArray_DTYPE(array)->type_num;
        int const depth = dtype == NPY_UINT8 ? CV_8U :
                          dtype == NPY_INT8 ? CV_8S :
                          dtype == NPY_UINT16 ? CV_16U :
                          dtype == NPY_INT16 ? CV_16S :
                          dtype == NPY_INT32 ? CV_32S :
                          dtype == NPY_FLOAT32 ? CV_32F :
                          dtype == NPY_FLOAT64 ? CV_64F :
                          -1;

        if (depth == -1)
        {
            PyErr_SetString(PyExc_ValueError, "The Numpy Array dtype is invalid.");
            /* SWIG_fail; */
            // return NULL;
        }

        npy_intp* shape = PyArray_SHAPE(array);
        int const nChannels = (ndims == 3) ? shape[2] : 1;

        cv::Mat mat(shape[0], shape[1], CV_MAKETYPE(depth, nChannels),
                    (void*)PyArray_DATA(array));

        return mat;
    }

    bool checkType(PyObject* o, int ndims, int dtype)
    {
        if (PyArray_Check(o))
        {
            PyArrayObject* const array = (PyArrayObject*)o;
            const int nDim = PyArray_NDIM(array);
            const int typeNum = PyArray_DTYPE(array)->type_num;

            return (nDim == ndims) && (typeNum == dtype);
        }
        else
        {
            return false;
        }
    }

    bool checkType(PyObject* o)
    {
        return PyArray_Check(o);
    }
}

%typemap(out, fragment="cvMat") cv::Mat
{
    $result = (PyObject*)cvMatAsNpArray($1);
}

%typemap(out, fragment="cvMat") cv::Mat&, cv::Mat*
{
    $result = (PyObject*)cvMatAsNpArray(*$1);
}

%typemap(out) cv::Mat1b, cv::Mat2b, cv::Mat3b, cv::Mat4b = cv::Mat;
%typemap(out) cv::Mat1b&, cv::Mat2b&, cv::Mat3b&, cv::Mat4b& = cv::Mat&;
%typemap(out) cv::Mat1b*, cv::Mat2b*, cv::Mat3b*, cv::Mat4b* = cv::Mat*;

%typemap(out) cv::Mat1s, cv::Mat2s, cv::Mat3s, cv::Mat4s = cv::Mat;
%typemap(out) cv::Mat1s&, cv::Mat2s&, cv::Mat3s&, cv::Mat4s& = cv::Mat&;
%typemap(out) cv::Mat1s*, cv::Mat2s*, cv::Mat3s*, cv::Mat4s* = cv::Mat*;

%typemap(out) cv::Mat1w, cv::Mat2w, cv::Mat3w, cv::Mat4w = cv::Mat;
%typemap(out) cv::Mat1w&, cv::Mat2w&, cv::Mat3w&, cv::Mat4w& = cv::Mat&;
%typemap(out) cv::Mat1w*, cv::Mat2w*, cv::Mat3w*, cv::Mat4w* = cv::Mat*;

%typemap(out) cv::Mat1i, cv::Mat2i, cv::Mat3i, cv::Mat4i = cv::Mat;
%typemap(out) cv::Mat1i&, cv::Mat2i&, cv::Mat3i&, cv::Mat4i& = cv::Mat&;
%typemap(out) cv::Mat1i*, cv::Mat2i*, cv::Mat3i*, cv::Mat4i* = cv::Mat*;

%typemap(out) cv::Mat1f, cv::Mat2f, cv::Mat3f, cv::Mat4f = cv::Mat;
%typemap(out) cv::Mat1f&, cv::Mat2f&, cv::Mat3f&, cv::Mat4f& = cv::Mat&;
%typemap(out) cv::Mat1f*, cv::Mat2f*, cv::Mat3f*, cv::Mat4f* = cv::Mat*;

%typemap(out) cv::Mat1d, cv::Mat2d, cv::Mat3d, cv::Mat4d = cv::Mat;
%typemap(out) cv::Mat1d&, cv::Mat2d&, cv::Mat3d&, cv::Mat4d& = cv::Mat&;
%typemap(out) cv::Mat1d*, cv::Mat2d*, cv::Mat3d*, cv::Mat4d* = cv::Mat*;


#define CV_MAT(type, ndims, dtype)                                                        \
%typemap(in, fragment="cvMat") cv::Mat_<type >                                            \
{                                                                                         \
    $1 = npArrayAsCvMat<type >($input, ndims, dtype);                                     \
}                                                                                         \
%typemap(in, fragment="cvMat") cv::Mat_<type >&, cv::Mat_<type >*                         \
{                                                                                         \
    cv::Mat_<type >* tmp = new cv::Mat_<type >;                                           \
    *tmp = npArrayAsCvMat<type >($input, ndims, dtype);                                   \
    $1 = tmp;                                                                             \
}                                                                                         \
%typemap(freearg) cv::Mat_<type >&, cv::Mat_<type >*                                      \
{                                                                                         \
    delete $1;                                                                            \
}                                                                                         \
%typemap(typecheck, fragment="cvMat") cv::Mat_<type >, cv::Mat_<type >&, cv::Mat_<type >* \
{                                                                                         \
    $1 = checkType($input, ndims, dtype);                                                 \
}

%typemap(in, fragment="cvMat") cv::Mat
{
    $1 = npArrayAsCvMat($input);
}
%typemap(in, fragment="cvMat") cv::Mat&, cv::Mat*
{
    cv::Mat* tmp = new cv::Mat;
    *tmp = npArrayAsCvMat($input);
    $1 = tmp;
}
%typemap(freearg) cv::Mat&, cv::Mat*
{
    delete $1;
}
%typemap(typecheck, fragment="cvMat") cv::Mat, cv::Mat&, cv::Mat*
{
    $1 = checkType($input);
}

CV_MAT(uchar, 2, NPY_UBYTE)
CV_MAT(cv::Vec2b, 3, NPY_UBYTE)
CV_MAT(cv::Vec3b, 3, NPY_UBYTE)
CV_MAT(cv::Vec4b, 3, NPY_UBYTE)

CV_MAT(short, 2, NPY_SHORT)
CV_MAT(cv::Vec2s, 3, NPY_SHORT)
CV_MAT(cv::Vec3s, 3, NPY_SHORT)
CV_MAT(cv::Vec4s, 3, NPY_SHORT)

CV_MAT(ushort, 2, NPY_USHORT)
CV_MAT(cv::Vec2w, 3, NPY_USHORT)
CV_MAT(cv::Vec3w, 3, NPY_USHORT)
CV_MAT(cv::Vec4w, 3, NPY_USHORT)

CV_MAT(int, 2, NPY_INT)
CV_MAT(cv::Vec2i, 3, NPY_INT)
CV_MAT(cv::Vec3i, 3, NPY_INT)
CV_MAT(cv::Vec4i, 3, NPY_INT)

CV_MAT(float, 2, NPY_FLOAT)
CV_MAT(cv::Vec2f, 3, NPY_FLOAT)
CV_MAT(cv::Vec3f, 3, NPY_FLOAT)
CV_MAT(cv::Vec4f, 3, NPY_FLOAT)

CV_MAT(double, 2, NPY_DOUBLE)
CV_MAT(cv::Vec2d, 3, NPY_DOUBLE)
CV_MAT(cv::Vec3d, 3, NPY_DOUBLE)
CV_MAT(cv::Vec4d, 3, NPY_DOUBLE)
