#include <opencv2/core/core.hpp>

#include <cassert>
#include <cmath>

template <typename T, int M, int N>
void cmp(const cv::Matx<T, M, N>& m, const T t[M*N])
{
    const double epsilon = 0.0001;
    for (int i = 0; i < N*M; ++i)
    {
        assert(fabs(m.val[i] - t[i]) < epsilon);
    }

}

cv::Matx12f return_matx12f()
{
    return cv::Matx12f(0.070, 0.242);
}

void receive_matx32d(cv::Matx32d matx)
{
    double t[6] = {0.445, 0.473, 0.765, 0.523, 0.832, 0.345};
    cmp(matx, t);
}

cv::Matx22f return_matx22f()
{
    return cv::Matx22f(0.657, 0.656, 0.545, 0.034);
}
