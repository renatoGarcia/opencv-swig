%module mat

%include <opencv/mat.i>
%cv_mat__instantiate_defaults

%header %{
#include "mat.hpp"
%}

%include "mat.hpp"
