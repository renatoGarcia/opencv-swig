%include "point.i"

%header %{
#include <opencv2/core/core.hpp>
%}

namespace cv
{
    template<typename _Tp> class Size_
    {
    public:
        Size_();
        Size_(_Tp _width, _Tp _height);
        Size_(const cv::Size_& sz);
        Size_(const cv::Point_<_Tp>& pt);

        _Tp area() const;

        _Tp width, height;

        %pythoncode %{
            def __len__(self):
                return 2

            def __getitem__(self, key):
                return (self.width, self.height)[key]

            def __iter__(self):
                return iter((self.width, self.height))

            def __repr__(self):
                return repr((self.width, self.height))

            def __getstate__(self):
                return self.__repr__()
        %}
    };

    typedef Size_<int> Size2i;
    typedef Size_<double> Size2d;
    typedef Size2i Size;
    typedef Size_<float> Size2f;

    %template(Size__int) Size_<int>;
    %template(Size__float) Size_<float>;
    %template(Size__double) Size_<double>;

    %pythoncode %{
        Size2i = Size__int
        Size   = Size2i
        Size2f = Size__float
        Size2d = Size__double
    %}
}

%fragment("cvSize", "header")
{
    template <typename T>
    void toCvSize(PyObject* o, cv::Size_<T>& size, char const* format, swig_type_info* ty)
    {
        cv::Size_<T>* p = NULL;
        if (SWIG_IsOK(SWIG_ConvertPtr(o, (void**)&p, ty, 0)))
        {
            size = *p;
        }
        else
        {
            T width, height;
            if(!PyArg_ParseTuple(o, format, &width, &height))
            {
                // PyErr_SetString(PyExc_ValueError,
                //                 "Error converting python tuple to cv::Point.");
                // return NULL;
            }
            size = cv::Size_<T>(width, height);
        }
    }

    bool checkSizeType(PyObject* o, swig_type_info* ty)
    {
        if (SWIG_IsOK(SWIG_ConvertPtr(o, NULL, ty, 0)))
        {
            return true;
        }
        else
        {
            return (PyTuple_Check(o) && (PyTuple_Size(o) == 2));
        }
    }
}

#define CV_SIZE(type, format, order)                                  \
%typemap(in, fragment="cvSize") cv::Size_<type >                      \
{                                                                     \
    toCvSize($input,  $1, "format", $descriptor(cv::Size_<type >*));  \
}                                                                     \
%typemap(in, fragment="cvSize") cv::Size_<type >&, cv::Size_<type >*  \
{                                                                     \
    $1 = new cv::Size_<type >;                                        \
    toCvSize($input,  *$1, "format", $descriptor(cv::Size_<type >*)); \
}                                                                     \
%typemap(freearg) cv::Size_<type >&, cv::Size_<type >*                \
{                                                                     \
    delete $1;                                                        \
}                                                                     \
%typemap(typecheck, fragment="cvSize", precedence=order)              \
    cv::Size_<type >, cv::Size_<type >&, cv::Size_<type >*            \
{                                                                     \
    $1 = checkSizeType($input, $descriptor(cv::Size_<type >*));       \
}

CV_SIZE(double, dd, 200)
CV_SIZE(float, ff, 201)
CV_SIZE(int, ii, 202)
