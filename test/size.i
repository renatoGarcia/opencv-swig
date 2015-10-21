%module size

%include <opencv/size.i>
%cv_size_instantiate_defaults
%cv_point_instantiate_defaults

%header %{
#include "size.hpp"
%}

%include "size.hpp"
