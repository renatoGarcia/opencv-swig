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

cv::Point point()
{
    return cv::Point(193, 216);
}

void point(cv::Point p)
{
    const int t[4] = {87, 97};
    cmp(p, t);
}

cv::Point& point_r()
{
    static cv::Point p(185, 80);
    return p;
}

void point_r(cv::Point& p)
{
    const int t[2] = {115, 203};
    cmp(p, t);
}

cv::Point* point_p()
{
    return new cv::Point(35, 18);
}

void point_p(cv::Point* p)
{
    const int t[2] = {89, 137};
    cmp(*p, t);
}

//-------------------------------------------------- Point_<int>

cv::Point_<int> point_int()
{
    return cv::Point_<int>(192, 218);
}

void point_int(cv::Point_<int> p)
{
    const int t[2] = {236, 30};
    cmp(p, t);
}

cv::Point_<int>& point_int_r()
{
    static cv::Point_<int> p(25, 141);
    return p;
}

void point_int_r(cv::Point_<int>& p)
{
    const int t[2] = {72, 180};
    cmp(p, t);
}

cv::Point_<int>* point_int_p()
{
    return new cv::Point_<int>(78, 131);
}

void point_int_p(cv::Point_<int>* p)
{
    const int t[2] = {225, 66};
    cmp(*p, t);
}


//-------------------------------------------------- Point_<double>

cv::Point_<double> point_double()
{
    return cv::Point_<double>(0.375, 0.243);
}

void point_double(cv::Point_<double> p)
{
    const double t[2] = {0.219, 0.426};
    cmp(p, t);
}

cv::Point_<double>& point_double_r()
{
    static cv::Point_<double> p(0.647,  0.530);
    return p;
}

void point_double_r(cv::Point_<double>& p)
{
    const double t[2] = {0.650, 0.581};
    cmp(p, t);
}

cv::Point_<double>* point_double_p()
{
    return new cv::Point_<double>(0.745, 0.163);
}

void point_double_p(cv::Point_<double>* p)
{
    const double t[2] = {0.156, 0.634};
    cmp(*p, t);
}


//-------------------------------------------------- Point_<float>

cv::Point_<float> point_float()
{
    return cv::Point_<float>(0.935f, 0.762f);
}

void point_float(cv::Point_<float> p)
{
    const float t[2] = {0.768f, 0.724f};
    cmp(p, t);
}

cv::Point_<float>& point_float_r()
{
    static cv::Point_<float> p(0.356f, 0.847f);
    return p;
}

void point_float_r(cv::Point_<float>& p)
{
    const float t[2] = {0.152f, 0.552f};
    cmp(p, t);
}

cv::Point_<float>* point_float_p()
{
    return new cv::Point_<float>(0.301f, 0.893f);
}

void point_float_p(cv::Point_<float>* p)
{
    const float t[2] = {0.079f, 0.624f};
    cmp(*p, t);
}

//-------------------------------------------------- PointTypecheck
int pointTypecheck(cv::Point)
{
    return 1;
}

int pointTypecheck(cv::Point2f)
{
    return 2;
}

int pointTypecheck(cv::Point2d)
{
    return 3;
}
