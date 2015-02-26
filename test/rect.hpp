#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>


template <typename T>
void cmp(const cv::Rect_<T>& r, const T t[4])
{
    const double epsilon = 0.0001;
    assert(fabs((double)r.x - t[0]) < epsilon);
    assert(fabs((double)r.y - t[1]) < epsilon);
    assert(fabs((double)r.width - t[2]) < epsilon);
    assert(fabs((double)r.height - t[3]) < epsilon);
}


//-------------------------------------------------- Rect

cv::Rect rect()
{
    return cv::Rect(18, 4, 154, 150);
}

void rect(cv::Rect r)
{
    const int t[4] = {69, 43, 13, 89};
    cmp(r, t);
}

cv::Rect& rect_r()
{
    static cv::Rect r(95, 178, 154, 51);
    return r;
}

void rect_r(cv::Rect& r)
{
    const int t[4] = {190, 11, 136, 219};
    cmp(r, t);
}

cv::Rect* rect_p()
{
    return new cv::Rect(10, 85, 76, 103);
}

void rect_p(cv::Rect* r)
{
    const int t[4] = {139, 72, 172, 198};
    cmp(*r, t);
}

//-------------------------------------------------- Rect_<int>

cv::Rect_<int> rect_int()
{
    return cv::Rect_<int>(20, 183, 191, 148);
}

void rect_int(cv::Rect_<int> r)
{
    const int t[4] = {156, 146, 132, 10};
    cmp(r, t);
}

cv::Rect_<int>& rect_int_r()
{
    static cv::Rect_<int> r(120, 23, 100, 55);
    return r;
}

void rect_int_r(cv::Rect_<int>& r)
{
    const int t[4] = {33, 180, 216, 104};
    cmp(r, t);
}

cv::Rect_<int>* rect_int_p()
{
    return new cv::Rect_<int>(173, 12, 109, 83);
}

void rect_int_p(cv::Rect_<int>* r)
{
    const int t[4] = {110, 7, 233, 55};
    cmp(*r, t);
}


//-------------------------------------------------- Rect_<double>

cv::Rect_<double> rect_double()
{
    return cv::Rect_<double>(0.988, 0.837, 0.419, 0.672);
}

void rect_double(cv::Rect_<double> r)
{
    const double t[4] = {0.077, 0.972, 0.865, 0.203};
    cmp(r, t);
}

cv::Rect_<double>& rect_double_r()
{
    static cv::Rect_<double> r(0.543, 0.585, 0.723, 0.363);
    return r;
}

void rect_double_r(cv::Rect_<double>& r)
{
    const double t[4] = {0.839, 0.870, 0.689, 0.799};
    cmp(r, t);
}

cv::Rect_<double>* rect_double_p()
{
    return new cv::Rect_<double>(0.580, 0.216, 0.673, 0.417);
}

void rect_double_p(cv::Rect_<double>* r)
{
    const double t[4] = {0.650, 0.685, 0.290, 0.577};
    cmp(*r, t);
}


//-------------------------------------------------- Rect_<float>

cv::Rect_<float> rect_float()
{
    return cv::Rect_<float>(0.357f, 0.460f, 0.384f, 0.103f);
}

void rect_float(cv::Rect_<float> r)
{
    const float t[4] = {0.488f, 0.797f, 0.436f, 0.618f};
    cmp(r, t);
}

cv::Rect_<float>& rect_float_r()
{
    static cv::Rect_<float> r(0.336f, 0.606f, 0.066f, 0.587f);
    return r;
}

void rect_float_r(cv::Rect_<float>& r)
{
    const float t[4] = {0.827f, 0.373f, 0.257f, 0.981f};
    cmp(r, t);
}

cv::Rect_<float>* rect_float_p()
{
    return new cv::Rect_<float>(0.547f, 0.462f, 0.337f, 0.951f);
}

void rect_float_p(cv::Rect_<float>* r)
{
    const float t[4] = {0.097f, 0.033f, 0.570f, 0.466f};
    cmp(*r, t);
}
