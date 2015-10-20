#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>

template <typename T, int M>
void cmp(const cv::Vec<T, M>& m, const T t[M])
{
    const double epsilon = 0.0001;
    for (int i = 0; i < M; ++i)
    {
        assert(fabs(m.val[i] - t[i]) < epsilon);
    }

}

cv::Vec2f return_Vec2f()
{
    return cv::Vec2f(0.643, 0.450);
}

cv::Vec2b return_Vec2b()
{
    return cv::Vec2b(34, 50);
}

cv::Vec2s return_Vec2s()
{
    return cv::Vec2s(656, 5454);
}

void receive_Vec3b(cv::Vec3b const& vec)
{
    uchar t[3] = {5, 15, 25};
    cmp(vec, t);
}

void receive_Vec3i(cv::Vec3i const& vec)
{
    int t[3] = {765, 523, 832};
    cmp(vec, t);
}
