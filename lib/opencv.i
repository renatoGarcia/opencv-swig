%header %{

#include <opencv2/core/core.hpp>

%}


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
