%module matx

%include <opencv/matx.i>
%cv_matx_instantiate_defaults

%header %{
#include "matx.hpp"
%}

%include "matx.hpp"
