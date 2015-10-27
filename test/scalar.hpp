#include <opencv2/core/core.hpp>

#include <cassert>


cv::Scalar return_Scalar()
{
    return cv::Scalar(0.096, 0.160, 0.388, 0.293);
}

void receive_Scalar(cv::Scalar const& scalar)
{
    assert(scalar(0) == 0.628);
    assert(scalar(1) == 0.855);
    assert(scalar(2) == 0.988);
    assert(scalar(3) == 0.015);
}
