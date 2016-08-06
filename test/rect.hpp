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
cv::Rect return_Rect()
{
    return cv::Rect(18, 4, 154, 150);
}

void receive_Rect(cv::Rect r)
{
    const int t[4] = {69, 43, 13, 89};
    cmp(r, t);
}

//-------------------------------------------------- Rect2i
cv::Rect_<int> return_Rect2i()
{
    return cv::Rect_<int>(20, 183, 191, 148);
}

void receive_Rect2i(cv::Rect_<int> r)
{
    const int t[4] = {156, 146, 132, 10};
    cmp(r, t);
}


//-------------------------------------------------- Rect2d
cv::Rect_<double> return_Rect2d()
{
    return cv::Rect_<double>(0.988, 0.837, 0.419, 0.672);
}

void receive_Rect2d(cv::Rect_<double> r)
{
    const double t[4] = {0.077, 0.972, 0.865, 0.203};
    cmp(r, t);
}


//-------------------------------------------------- Rect2f
cv::Rect_<float> return_Rect2f()
{
    return cv::Rect_<float>(0.357f, 0.460f, 0.384f, 0.103f);
}

void receive_Rect2f(cv::Rect_<float> r)
{
    const float t[4] = {0.488f, 0.797f, 0.436f, 0.618f};
    cmp(r, t);
}
