%include "point.i"
%include "size.i"

%header %{
#include <opencv2/core/core.hpp>
%}

namespace cv
{
    template<typename _Tp> class Rect_
    {
    public:
        Rect_();
        Rect_(_Tp _x, _Tp _y, _Tp _width, _Tp _height);
        Rect_(const cv::Rect_& r);
        Rect_(const cv::Point_<_Tp >& org, const cv::Size_<_Tp >& sz);
        Rect_(const cv::Point_<_Tp >& pt1, const cv::Point_<_Tp >& pt2);

        cv::Point_<_Tp> tl() const;
        cv::Point_<_Tp> br() const;

        cv::Size_<_Tp> size() const;
        _Tp area() const;

        bool contains(const cv::Point_<_Tp>& pt) const;

        _Tp x, y, width, height;

        %pythoncode %{
            def __len__(self):
                return 4

            def __getitem__(self, key):
                return (self.x, self.y, self.width, self.height)[key]

            def __iter__(self):
                return iter((self.x, self.y, self.width, self.height))

            def __repr__(self):
                return repr((self.x, self.y, self.width, self.height))

            def __getstate__(self):
                return self.__repr__()
        %}
    };

    typedef Rect_<int> Rect;

    %template(Rect__int) Rect_<int>;
    %template(Rect__float) Rect_<float>;
    %template(Rect__double) Rect_<double>;

    %pythoncode %{
        Rect = Rect__int
    %}
}

%fragment("cvRect", "header")
{
    template <typename T>
    void toCvRect(PyObject* o, cv::Rect_<T>& rect, char const* format, swig_type_info* ty)
    {
        cv::Rect_<T>* p = NULL;
        if (SWIG_IsOK(SWIG_ConvertPtr(o, (void**)&p, ty, 0)))
        {
            rect = *p;
        }
        else
        {
            T x, y, w, h;
            if(!PyArg_ParseTuple(o, format, &x, &y, &w, &h))
            {
                // PyErr_SetString(PyExc_ValueError,
                //                 "Error converting python tuple to cv::Point.");
                // return NULL;
            }
            rect = cv::Rect_<T>(x, y, w, h);
        }
    }

    bool checkRectType(PyObject* o, swig_type_info* ty)
    {
        if (SWIG_IsOK(SWIG_ConvertPtr(o, NULL, ty, 0)))
        {
            return true;
        }
        else
        {
            return (PyTuple_Check(o) && (PyTuple_Size(o) == 4));
        }
    }
}

#define CV_RECT(type, format, order)                                  \
%typemap(in, fragment="cvRect") cv::Rect_<type >                      \
{                                                                     \
    toCvRect($input,  $1, "format", $descriptor(cv::Rect_<type >*));  \
}                                                                     \
%typemap(in, fragment="cvRect") cv::Rect_<type >&, cv::Rect_<type >*  \
{                                                                     \
    $1 = new cv::Rect_<type >;                                        \
    toCvRect($input,  *$1, "format", $descriptor(cv::Rect_<type >*)); \
}                                                                     \
%typemap(freearg) cv::Rect_<type >&, cv::Rect_<type >*                \
{                                                                     \
    delete $1;                                                        \
}                                                                     \
%typemap(typecheck, fragment="cvRect", precedence=order)              \
    cv::Rect_<type >, cv::Rect_<type >&, cv::Rect_<type >*            \
{                                                                     \
    $1 = checkRectType($input, $descriptor(cv::Rect_<type >*));       \
}

CV_RECT(double, dddd, 200)
CV_RECT(float, ffff, 201)
CV_RECT(int, iiii, 202)
