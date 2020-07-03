%module my_lib

%include <opencv.i>
%cv_instantiate_all_defaults

%{
    #include "my_lib.hpp"
%}

%include "my_lib.hpp"
