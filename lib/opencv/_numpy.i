%pythoncode
{
    import sys
    if sys.byteorder == 'little':
        _cv_numpy_endianess = '<'
    else:
        _cv_numpy_endianess = '>'

    _cv_numpy_typestr_map = {}
}

%inline
%{
    template <typename T>
    struct _SizeOf
    {
        enum {value = sizeof(T)};
    };
%}

%define %cv_numpy_add_type(type, np_basic_type)
    #if !_CV_NUMPY_##type##_
        %template(_cv_numpy_sizeof_##type) _SizeOf< type >;
        %pythoncode
        {
            if _cv_numpy_sizeof_##type##.value == 1:
                _cv_numpy_typestr_map[#type] = "|" + #np_basic_type + "1"
            else:
                _cv_numpy_typestr_map[#type] = _cv_numpy_endianess  + #np_basic_type + str(_cv_numpy_sizeof_##type##.value)
        }
        #define _CV_NUMPY_##type##_
    #endif
%enddef
