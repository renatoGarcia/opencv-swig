#ifndef MY_LIB_HPP_INCLUDED
#define MY_LIB_HPP_INCLUDED

#include <opencv2/core.hpp>
#include <iostream>

inline auto moveTo(cv::Point const& p) -> void
{
    std::cout << "cv::Point moved" << std::endl;
}

inline auto getImage() -> cv::Mat3b
{
    return cv::Mat3b(3, 5);
}

#endif /* MY_LIB_HPP_INCLUDED */
