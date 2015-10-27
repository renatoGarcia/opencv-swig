%module scalar

%include <opencv/scalar.i>
%cv_scalar_instantiate_defaults

%header %{
#include "scalar.hpp"
%}

%include "scalar.hpp"
