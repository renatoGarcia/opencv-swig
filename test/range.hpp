#include <opencv2/core/core.hpp>

#include <cassert>


cv::Range return_Range()
{
    return cv::Range(13, 42);
}

void receive_Range(cv::Range const& range)
{
    assert(range.start == 10);
    assert(range.end == 15);
}
