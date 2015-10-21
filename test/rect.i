%module rect

%include <opencv/rect.i>
%cv_rect_instantiate_defaults
%cv_size_instantiate_defaults
%cv_point_instantiate_defaults

%header %{
#include "rect.hpp"
%}

%include "rect.hpp"
