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

cv::Size return_Size()
{
    return cv::Size(14, 55);
}

void receive_Size(cv::Size s)
{
    const int t[4] = {21, 175};
    cmp(s, t);
}


//-------------------------------------------------- Size2i

cv::Size2i return_Size2i()
{
    return cv::Size2i(203, 17);
}

void receive_Size2i(cv::Size2i s)
{
    const int t[2] = {250, 128};
    cmp(s, t);
}


//-------------------------------------------------- Size2d

cv::Size2d return_Size2d()
{
    return cv::Size2d(0.039, 0.377);
}

void receive_Size2d(cv::Size2d s)
{
    const double t[2] = {0.637, 0.256};
    cmp(s, t);
}

//-------------------------------------------------- Size2f

cv::Size2f return_Size2f()
{
    return cv::Size2f(0.460f, 0.339f);
}

void receive_Size2f(cv::Size2f s)
{
    const float t[2] = {0.464f, 0.239f};
    cmp(s, t);
}
