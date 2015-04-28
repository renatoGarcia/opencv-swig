#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>


template <typename T>
void cmp(const cv::Size_<T>& s, const T t[2])
{
    const double epsilon = 0.0001;
    assert(fabs((double)s.width - t[0]) < epsilon);
    assert(fabs((double)s.height - t[1]) < epsilon);
}


//-------------------------------------------------- Size

cv::Size size()
{
    return cv::Size(14, 55);
}

void size(cv::Size s)
{
    const int t[4] = {21, 175};
    cmp(s, t);
}

cv::Size& size_r()
{
    static cv::Size s(154, 88);
    return s;
}

void size_r(cv::Size& s)
{
    const int t[2] = {94, 96};
    cmp(s, t);
}

cv::Size* size_p()
{
    return new cv::Size(54, 25);
}

void size_p(cv::Size* s)
{
    const int t[2] = {211, 35};
    cmp(*s, t);
}

//-------------------------------------------------- Size_<int>

cv::Size_<int> size_int()
{
    return cv::Size_<int>(203, 17);
}

void size_int(cv::Size_<int> s)
{
    const int t[2] = {250, 128};
    cmp(s, t);
}

cv::Size_<int>& size_int_r()
{
    static cv::Size_<int> s(158, 87);
    return s;
}

void size_int_r(cv::Size_<int>& s)
{
    const int t[2] = {59, 147};
    cmp(s, t);
}

cv::Size_<int>* size_int_p()
{
    return new cv::Size_<int>(150, 215);
}

void size_int_p(cv::Size_<int>* s)
{
    const int t[2] = {17, 180};
    cmp(*s, t);
}


//-------------------------------------------------- Size_<double>

cv::Size_<double> size_double()
{
    return cv::Size_<double>(0.039, 0.377);
}

void size_double(cv::Size_<double> s)
{
    const double t[2] = {0.637, 0.256};
    cmp(s, t);
}

cv::Size_<double>& size_double_r()
{
    static cv::Size_<double> s(0.720, 0.189);
    return s;
}

void size_double_r(cv::Size_<double>& s)
{
    const double t[2] = {0.002, 0.211};
    cmp(s, t);
}

cv::Size_<double>* size_double_p()
{
    return new cv::Size_<double>(0.862, 0.046);
}

void size_double_p(cv::Size_<double>* s)
{
    const double t[2] = {0.162, 0.433};
    cmp(*s, t);
}


//-------------------------------------------------- Size_<float>

cv::Size_<float> size_float()
{
    return cv::Size_<float>(0.460f, 0.339f);
}

void size_float(cv::Size_<float> s)
{
    const float t[2] = {0.464f, 0.239f};
    cmp(s, t);
}

cv::Size_<float>& size_float_r()
{
    static cv::Size_<float> s(0.948f, 0.315f);
    return s;
}

void size_float_r(cv::Size_<float>& s)
{
    const float t[2] = {0.917f, 0.375f};
    cmp(s, t);
}

cv::Size_<float>* size_float_p()
{
    return new cv::Size_<float>(0.231f, 0.396f);
}

void size_float_p(cv::Size_<float>* s)
{
    const float t[2] = {0.531f, 0.205f};
    cmp(*s, t);
}

//-------------------------------------------------- SizeTypecheck
int sizeTypecheck(cv::Size)
{
    return 1;
}

int sizeTypecheck(cv::Size2f)
{
    return 2;
}

int sizeTypecheck(cv::Size2d)
{
    return 3;
}
