%module point

%include <opencv/point.i>
%cv_point_instantiate_defaults
%cv_vec_instantiate_defaults

%header %{
#include "point.hpp"
%}

%include "point.hpp"
