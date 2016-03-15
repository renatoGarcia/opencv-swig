#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>

template <typename T, int N>
void cmpa(const cv::Vec<T, N>& v, const cv::Vec<T, N>& ref)
{
    const double epsilon = 0.0001;
    for (int i = 0; i < N; ++i)
    {
        assert(fabs(v[i] - ref[i]) < epsilon);
    }
}

template <typename T>
void cmpa(const T& v, const T& ref)
{
    const double epsilon = 0.0001;
    assert(fabs(v - ref) < epsilon);
}

template <typename T>
void cmp(const cv::Mat& m, const T t[6])
{
    cmpa(m.at<T>(0, 0), t[0]); cmpa(m.at<T>(0, 1), t[1]);
    cmpa(m.at<T>(1, 0), t[2]); cmpa(m.at<T>(1, 1), t[3]);
    cmpa(m.at<T>(2, 0), t[4]); cmpa(m.at<T>(2, 1), t[5]);
}

//-------------------------------------------------- Mat
cv::Mat return_Mat1()
{
    cv::Mat m(3, 2, CV_8UC1);
    m.at<uchar>(0, 0) = 113; m.at<uchar>(0, 1) =  65;
    m.at<uchar>(1, 0) =  70; m.at<uchar>(1, 1) = 143;
    m.at<uchar>(2, 0) = 154; m.at<uchar>(2, 1) = 194;

    return m;
}


cv::Mat return_Mat2()
{
    cv::Mat m(3, 2, CV_16SC2);
    m.at<cv::Vec2s>(0, 0) = cv::Vec2s(81, 19)   ; m.at<cv::Vec2s>(0, 1) = cv::Vec2s(-65, -2);
    m.at<cv::Vec2s>(1, 0) = cv::Vec2s(-3, 22)   ; m.at<cv::Vec2s>(1, 1) = cv::Vec2s(-55, 2);
    m.at<cv::Vec2s>(2, 0) = cv::Vec2s(5575, 600); m.at<cv::Vec2s>(2, 1) = cv::Vec2s(-1720, 21920);

    return m;
}


void receive_Mat(cv::Mat const& m)
{
    const cv::Vec3d t[6] = {cv::Vec3d(0.606, 0.091, 0.098), cv::Vec3d(0.751, 0.639, 0.956),
                            cv::Vec3d(0.721, 0.163, 0.543), cv::Vec3d(0.454, 0.281, 0.909),
                            cv::Vec3d(0.806, 0.348, 0.279), cv::Vec3d(0.462, 0.656, 0.388)};
    cmp(m, t);
}


//-------------------------------------------------- Mat_<>
cv::Mat1b return_Mat1b()
{
    return (cv::Mat1b(3, 2) << 159, 88,
                               244, 66,
                                 3, 136);
}

cv::Mat2b return_Mat2b()
{
    return (cv::Mat2b(3, 2) << cv::Vec2b(129, 29), cv::Vec2b(204, 240),
                               cv::Vec2b(76, 118), cv::Vec2b(15, 107),
                               cv::Vec2b(223, 111), cv::Vec2b(151, 208));
}

cv::Mat3b return_Mat3b()
{
    return (cv::Mat3b(3, 2) << cv::Vec3b(40, 144, 104), cv::Vec3b(80, 141, 228),
                               cv::Vec3b(68, 80, 217), cv::Vec3b(184, 146, 112),
                               cv::Vec3b(255, 111, 230), cv::Vec3b(84, 97, 224));
}

cv::Mat4b return_Mat4b()
{
    return (cv::Mat4b(3, 2) << cv::Vec4b(252, 1, 156, 161), cv::Vec4b(255, 168, 21, 182),
                               cv::Vec4b(97, 101, 64, 219), cv::Vec4b(185, 218, 198, 216),
                               cv::Vec4b(130, 222, 142, 185), cv::Vec4b(196, 3, 99, 224));
}

cv::Mat1d return_Mat1d()
{
    return (cv::Mat1d(3, 2) << 0.161, 0.173, 0.623, 0.713, 0.601, 0.306);
}


void receive_Mat2s(cv::Mat2s mat)
{
    const cv::Vec2s t[6] = {cv::Vec2s(53, -57), cv::Vec2s(-9, -18),
                            cv::Vec2s(-111, 110), cv::Vec2s(52, -103),
                            cv::Vec2s(2276, 11336), cv::Vec2s(18891, 7322)};
    cmp(mat, t);
}
