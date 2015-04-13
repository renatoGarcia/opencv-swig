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
cv::Mat mat()
{
    cv::Mat m(3, 2, CV_8UC1);
    m.at<uchar>(0, 0) = 113; m.at<uchar>(0, 1) =  65;
    m.at<uchar>(1, 0) =  70; m.at<uchar>(1, 1) = 143;
    m.at<uchar>(2, 0) = 154; m.at<uchar>(2, 1) = 194;

    return m;
}

void mat(cv::Mat m)
{
    const short t[6] = {-1174, -6302,
                        -17670, 17012,
                        -10228, 27393};
    cmp(m, t);
}

cv::Mat& mat_r()
{
    static cv::Mat m(3, 2, CV_16UC1);
    m.at<ushort>(0, 0) = 57759; m.at<ushort>(0, 1) = 49461;
    m.at<ushort>(1, 0) = 8358; m.at<ushort>(1, 1) = 52972;
    m.at<ushort>(2, 0) = 12458; m.at<ushort>(2, 1) = 4139;

    return m;
}

void mat_r(cv::Mat& m)
{
    const cv::Vec2i t[6] = {cv::Vec2i(24461, 84053), cv::Vec2i(-45230, -59792),
                            cv::Vec2i(86076, -65378), cv::Vec2i(41973, 6477),
                            cv::Vec2i(-36188, -22605), cv::Vec2i(-42794, 6418)};
    cmp(m, t);
}

cv::Mat* mat_p()
{
    static cv::Mat m(3, 2, CV_32FC4);
    m.at<cv::Vec4f>(0, 0) = cv::Vec4f(0.960, 0.560, 0.259, 0.386);
    m.at<cv::Vec4f>(0, 1) = cv::Vec4f(0.555, 0.142, 0.600, 0.261);
    m.at<cv::Vec4f>(1, 0) = cv::Vec4f(0.049, 0.537, 0.121, 0.397);
    m.at<cv::Vec4f>(1, 1) = cv::Vec4f(0.958, 0.903, 0.178, 0.737);
    m.at<cv::Vec4f>(2, 0) = cv::Vec4f(0.386, 0.206, 0.546, 0.805);
    m.at<cv::Vec4f>(2, 1) = cv::Vec4f(0.069, 0.747, 0.553, 0.688);

    return &m;
}

void mat_p(cv::Mat* m)
{
    const cv::Vec3d t[6] = {cv::Vec3d(0.606, 0.091, 0.098), cv::Vec3d(0.751, 0.639, 0.956),
                            cv::Vec3d(0.721, 0.163, 0.543), cv::Vec3d(0.454, 0.281, 0.909),
                            cv::Vec3d(0.806, 0.348, 0.279), cv::Vec3d(0.462, 0.656, 0.388)};
    cmp(*m, t);
}


//-------------------------------------------------- MatXb
cv::Mat1b mat1b()
{
    return (cv::Mat1b(3, 2) << 159, 88, 244, 66, 3, 136);
}

void mat1b(cv::Mat1b mat)
{
    const unsigned char t[6] = {252, 108, 93, 136, 116, 201};
    cmp(mat, t);
}

cv::Mat2b mat2b()
{
    return (cv::Mat2b(3, 2) << cv::Vec2b(129, 29), cv::Vec2b(204, 240),
                               cv::Vec2b(76, 118), cv::Vec2b(15, 107),
                               cv::Vec2b(223, 111), cv::Vec2b(151, 208));
}

cv::Mat3b mat3b()
{
    return (cv::Mat3b(3, 2) << cv::Vec3b(40, 144, 104), cv::Vec3b(80, 141, 228),
                               cv::Vec3b(68, 80, 217), cv::Vec3b(184, 146, 112),
                               cv::Vec3b(255, 111, 230), cv::Vec3b(84, 97, 224));
}

void mat3b(cv::Mat3b mat)
{
    const cv::Vec3b t[6] = {cv::Vec3b(159, 161, 66), cv::Vec3b(103, 191, 179),
                            cv::Vec3b(10, 170, 215), cv::Vec3b(138, 178, 203),
                            cv::Vec3b(134, 107, 140), cv::Vec3b(177, 41, 169)};
    cmp(mat, t);
}

cv::Mat4b mat4b()
{
    return (cv::Mat4b(3, 2) << cv::Vec4b(252, 1, 156, 161), cv::Vec4b(255, 168, 21, 182),
                               cv::Vec4b(97, 101, 64, 219), cv::Vec4b(185, 218, 198, 216),
                               cv::Vec4b(130, 222, 142, 185), cv::Vec4b(196, 3, 99, 224));
}


//-------------------------------------------------- MatXs

cv::Mat1s& mat1s_r()
{
    static cv::Mat1s mat = (cv::Mat1s(3, 2) << 58, -38, -6, -53, 16921, 25357);
    return mat;
}

void mat1s_r(cv::Mat1s& mat)
{
    const short int t[6] = {13, -88, 78, 21, -11203, 24126};
    cmp(mat, t);
}

cv::Mat2s* mat2s_p()
{
    static cv::Mat2s mat = (cv::Mat2s(3, 2) << cv::Vec2s(81, 19), cv::Vec2s(-65, -2),
                                               cv::Vec2s(-3, 22), cv::Vec2s(-55, 2),
                                               cv::Vec2s(5575, 600), cv::Vec2s(-1720, 21920));

    return &mat;
}

void mat2s_p(cv::Mat2s* mat)
{
    const cv::Vec2s t[6] = {cv::Vec2s(53, -57), cv::Vec2s(-9, -18),
                            cv::Vec2s(-111, 110), cv::Vec2s(52, -103),
                            cv::Vec2s(2276, 11336), cv::Vec2s(18891, 7322)};
    cmp(*mat, t);
}

//-------------------------------------------------- MatXd

cv::Mat1d mat1d()
{
    return (cv::Mat1d(3, 2) << 0.161, 0.173, 0.623, 0.713, 0.601, 0.306);
}

cv::Mat2d mat2d()
{
    return (cv::Mat2d(3, 2) << cv::Vec2d(0.512, 0.705), cv::Vec2d(0.752, 0.684),
                               cv::Vec2d(0.285, 0.649), cv::Vec2d(0.968, 0.628),
                               cv::Vec2d(0.452, 0.652), cv::Vec2d(0.637, 0.576));
}

cv::Mat3d mat3d()
{
    return (cv::Mat3d(3, 2) << cv::Vec3d(0.534, 0.988, 0.492), cv::Vec3d(0.040, 0.123, 0.365),
                               cv::Vec3d(0.956, 0.016, 0.731), cv::Vec3d(0.374, 0.713, 0.739),
                               cv::Vec3d(0.082, 0.604, 0.901), cv::Vec3d(0.335, 0.118, 0.654));
}

cv::Mat4d mat4d()
{
    return (cv::Mat4d(3, 2) << cv::Vec4d(0.741, 0.510, 0.174, 0.642),
                               cv::Vec4d(0.356, 0.444, 0.412, 0.769),
                               cv::Vec4d(0.766, 0.352, 0.150, 0.918),
                               cv::Vec4d(0.034, 0.643, 0.534, 0.548),
                               cv::Vec4d(0.684, 0.116, 0.568, 0.869),
                               cv::Vec4d(0.211, 0.550, 0.945, 0.762));
}
