%include "size.i"
%include "rect.i"

%header %{
#include <opencv2/core/core.hpp>
%}

namespace cv
{
    template<typename _Tp> class Point_
    {
    public:
        Point_();
        Point_(_Tp _x, _Tp _y);
        Point_(const cv::Point_& pt);
        Point_(const cv::Size_<_Tp >& sz);
        /* Point_(const cv::Vec<_Tp, 2>& v); */

        _Tp dot(const cv::Point_& pt) const;
        double ddot(const cv::Point_& pt) const;
        double cross(const cv::Point_& pt) const;
        bool inside(const cv::Rect_<_Tp >& r) const;

        _Tp x, y;

        %pythoncode %{
            def __len__(self):
                return 2

            def __getitem__(self, key):
                return (self.x, self.y)[key]

            def __iter__(self):
                return iter((self.x, self.y))

            def __repr__(self):
                return repr((self.x, self.y))

            def __getstate__(self):
                return self.__repr__()
        %}
    };

    typedef Point_<int> Point2i;
    typedef Point2i Point;
    typedef Point_<float> Point2f;
    typedef Point_<double> Point2d;

    %template(Point__int) Point_<int>;
    %template(Point__float) Point_<float>;
    %template(Point__double) Point_<double>;

    %pythoncode %{
        Point2i = Point__int
        Point = Point2i
        Point2f = Point__float
        Point2d = Point__double
    %}
}

%fragment("cvPoint", "header")
{
    template <typename T>
    void toCvPoint(PyObject* o, cv::Point_<T>& point, char const* format, swig_type_info* ty)
    {
        cv::Point_<T>* p = NULL;
        if (SWIG_IsOK(SWIG_ConvertPtr(o, (void**)&p, ty, 0)))
        {
            point = *p;
        }
        else
        {
            T x, y;
            if(!PyArg_ParseTuple(o, format, &x, &y))
            {
                // PyErr_SetString(PyExc_ValueError,
                //                 "Error converting python tuple to cv::Point.");
                // return NULL;
            }
            point = cv::Point_<T>(x, y);
        }
    }

    bool checkPointType(PyObject* o, swig_type_info* ty)
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

#define CV_POINT(type, format, order)                                   \
%typemap(in, fragment="cvPoint") cv::Point_<type >                      \
{                                                                       \
    toCvPoint($input,  $1, "format", $descriptor(cv::Point_<type >*));  \
}                                                                       \
%typemap(in, fragment="cvPoint") cv::Point_<type >&, cv::Point_<type >* \
{                                                                       \
    $1 = new cv::Point_<type >;                                         \
    toCvPoint($input,  *$1, "format", $descriptor(cv::Point_<type >*)); \
}                                                                       \
%typemap(freearg) cv::Point_<type >&, cv::Point_<type >*                \
{                                                                       \
    delete $1;                                                          \
}                                                                       \
%typemap(typecheck, fragment="cvPoint", precedence=order)               \
    cv::Point_<type >, cv::Point_<type >&, cv::Point_<type >*           \
{                                                                       \
    $1 = checkPointType($input, $descriptor(cv::Point_<type >*));       \
}

CV_POINT(double, dd, 200)
CV_POINT(float, ff, 201)
CV_POINT(int, ii, 202)
