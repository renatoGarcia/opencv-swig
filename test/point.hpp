#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>


template <typename T>
void cmp(const cv::Point_<T>& p, const T t[2])
{
    const double epsilon = 0.0001;
    assert(fabs((double)p.x - t[0]) < epsilon);
    assert(fabs((double)p.y - t[1]) < epsilon);
}


//-------------------------------------------------- Point

cv::Point return_Point()
{
    return cv::Point(193, 216);
}

void receive_Point(cv::Point p)
{
    const int t[4] = {87, 97};
    cmp(p, t);
}


//-------------------------------------------------- Point2i

cv::Point2i return_Point2i()
{
    return cv::Point2i(192, 218);
}

void receive_Point2i(cv::Point2i p)
{
    const int t[2] = {236, 30};
    cmp(p, t);
}


//-------------------------------------------------- Point2d

cv::Point2d return_Point2d()
{
    return cv::Point2d(0.375, 0.243);
}

void receive_Point2d(cv::Point2d p)
{
    const double t[2] = {0.219, 0.426};
    cmp(p, t);
}



//-------------------------------------------------- Point2f

cv::Point2f return_Point2f()
{
    return cv::Point2f(0.935f, 0.762f);
}

void receive_Point2f(cv::Point2f p)
{
    const float t[2] = {0.768f, 0.724f};
    cmp(p, t);
}
