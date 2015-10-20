%module vec

%include <opencv/vec.i>
%cv_vec_instantiate_defaults

%header %{
#include "vec.hpp"
%}

%include "vec.hpp"
