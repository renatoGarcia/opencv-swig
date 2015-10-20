%include <std_vector.i>


%pythoncode
{
    import sys
    if sys.byteorder == 'little':
        _endianess = '<'
    else:
        _endianess = '>'

    _array_map = {}
    _typestr_map = {}
}

%inline
%{
    template <typename T>
    struct _SizeOf
    {
        enum {value = sizeof(T)};
    };
%}

/* %cv_matx_instantiate(type, d1, d2, type_alias, np_basic_type)
 *
 *  Generete the wrapper code to a specific cv::Matx template instantiation.
 *
 *  type - The cv::Matx value type.
 *  d1 - The number of rows.
 *  d2 - The number of columns.
 *  type_alias - The value type alias used at the cv::Matx typedefs.
 *  np_basic_type - The character code[0] describing the numpy array item type.
 *
 *  For instance, the C++ type cv::Matx<double, 2, 1> would be instantiated with:
 *
 *      %cv_matx_instantiate(double, 2, 1, d, f)
 *
 *  which would generate a wrapper Python class Matx21d.
 *
 *  [0]: http://docs.scipy.org/doc/numpy/reference/arrays.interface.html#__array_interface__
 */
%define %cv_matx_instantiate(type, d1, d2, type_alias, np_basic_type)

    // If it hasn't been instantiated yet, instantiate all auxiliary structure to this
    // Matx value type.
    #if !_ARRAY_##type##_INSTANTIATED_
        %template(_##type##Array) std::vector< type >;
        %template(_sizeof_##type) _SizeOf< type >;
        #define _ARRAY_##type##_INSTANTIATED_
        %pythoncode
        {
            _array_map[#type] = _##type##Array
            if _sizeof_##type##.value == 1:
                _typestr_map[#type] = "|" + #np_basic_type + "1"
            else:
                _typestr_map[#type] = _endianess  + #np_basic_type + str(_sizeof_##type##.value)
        }
    #endif

    // If it hasn't been instantiated yet, instantiate the Matx wrapper code.
    #if !_CV_MAT_##type##_##d1##_##d2##_INSTANTIATED_
        %template(_Matx_##type##_##d1##_##d2) cv::Matx< type, d1, d2>;
        %pythoncode
        %{
            Matx##d1##d2##type_alias = _Matx_##type##_##d1##_##d2
        %}
        #define _CV_MAT_##type##_##d1##_##d2##_INSTANTIATED_
    #endif
%enddef


%header
%{
    #include <opencv2/core/core.hpp>
    #include <sstream>

    #include <boost/preprocessor/repetition/repeat_from_to.hpp>
    #include <boost/preprocessor/repetition/enum.hpp>
    #include <boost/preprocessor/list/for_each.hpp>

    /* Macros mapping the Matx channels number to a Boost Preprocessor list[0] with the
     * arities of its constructors. Note that to a Matx with N channels, the maximum arity
     * of its constructors is N, an there aren't constructors with arities greater than
     * 16, neither constructors 15-ary, 14-ary, 13-ary or 11-ary.
     *
     * [0]: http://www.boost.org/doc/libs/release/libs/preprocessor/doc/data/lists.html
     */
    #define _0_CHANNELS_ARITIES_LIST (0, BOOST_PP_NIL)
    #define _1_CHANNELS_ARITIES_LIST (1, _0_CHANNELS_ARITIES_LIST)
    #define _2_CHANNELS_ARITIES_LIST (2, _1_CHANNELS_ARITIES_LIST)
    #define _3_CHANNELS_ARITIES_LIST (3, _2_CHANNELS_ARITIES_LIST)
    #define _4_CHANNELS_ARITIES_LIST (4, _3_CHANNELS_ARITIES_LIST)
    #define _5_CHANNELS_ARITIES_LIST (5, _4_CHANNELS_ARITIES_LIST)
    #define _6_CHANNELS_ARITIES_LIST (6, _5_CHANNELS_ARITIES_LIST)
    #define _7_CHANNELS_ARITIES_LIST (7, _6_CHANNELS_ARITIES_LIST)
    #define _8_CHANNELS_ARITIES_LIST (8, _7_CHANNELS_ARITIES_LIST)
    #define _9_CHANNELS_ARITIES_LIST (9, _8_CHANNELS_ARITIES_LIST)
    #define _10_CHANNELS_ARITIES_LIST (10, _9_CHANNELS_ARITIES_LIST)
    #define _11_CHANNELS_ARITIES_LIST _10_CHANNELS_ARITIES_LIST
    #define _12_CHANNELS_ARITIES_LIST (12, _10_CHANNELS_ARITIES_LIST)
    #define _13_CHANNELS_ARITIES_LIST _12_CHANNELS_ARITIES_LIST
    #define _14_CHANNELS_ARITIES_LIST _12_CHANNELS_ARITIES_LIST
    #define _15_CHANNELS_ARITIES_LIST _12_CHANNELS_ARITIES_LIST
    #define _16_CHANNELS_ARITIES_LIST (16, _12_CHANNELS_ARITIES_LIST)


    #define ARITIES_LIST(channels) _##channels##_CHANNELS_ARITIES_LIST

    #define ARG(z, n, data) arg[n]
    #define ELSE_IF_STATEMENT(r, data, n)                                   \
        else if (arg.size() == n)                                           \
        {                                                                   \
            return new M(BOOST_PP_ENUM(n, ARG, _));                         \
        }
    #define IF_ELSE_CHAIN(channels) if (false);                             \
        BOOST_PP_LIST_FOR_EACH(ELSE_IF_STATEMENT, _, ARITIES_LIST(channels))


    /* Factory to Matx with 10 channels or more.
     *
     * It should be 16 channels, but as of OpenCV 3.0.0, there are a bug at which only
     * Matx's with exactly 12 or 16 channels can call a 12-ary or 16-ary constructors
     * respectively.
     */
    template <typename M, int Channels=M::channels>
    struct Factory
    {
        static M* construct(std::vector<typename M::value_type> const& arg)
        {
            IF_ELSE_CHAIN(10)
        }
    };

    #define FACTORY(z, channels, data)                                      \
        template <typename M>                                               \
        struct Factory<M, channels>                                         \
        {                                                                   \
            static M* construct(std::vector<typename M::value_type> const& arg) \
            {                                                               \
                IF_ELSE_CHAIN(channels)                                     \
            }                                                               \
        };

    BOOST_PP_REPEAT_FROM_TO(1, 10, FACTORY, _)


    template <int A, int B>
    struct MinInt
    {
        enum
        {
            value = (A < B) ? A : B
        };
    };

%}

namespace cv
{
    struct Matx_AddOp {};
    struct Matx_SubOp {};
    struct Matx_ScaleOp {};
    struct Matx_MulOp {};
    struct Matx_MatMulOp {};
    struct Matx_TOp {};

    /* Class header from OpenCV version 3.0.0 */
    template<typename _Tp, int m, int n> class Matx
    {
    public:
        enum { depth = DataDepth<_Tp>::value,
               rows = m,
               cols = n,
               channels = rows*cols,
               type = CV_MAKETYPE(depth, channels),
               shortdim = MinInt<m, n>::vale // SWIG can not handle the original expression.
             };

        typedef _Tp                    value_type;
        typedef Matx<_Tp, m, n>        mat_type;
        typedef Matx<_Tp, shortdim, 1> diag_type;

        explicit Matx(const _Tp* vals); //!< initialize from a plain array

        static Matx all(_Tp alpha);
        static Matx zeros();
        static Matx ones();
        static Matx eye();
        /* static Matx diag(const diag_type& d); */
        static Matx randu(_Tp a, _Tp b);
        static Matx randn(_Tp a, _Tp b);

        //! dot product computed with the default precision
        _Tp dot(const cv::Matx<_Tp, m, n>& v) const;

        //! dot product computed in double-precision arithmetics
        double ddot(const cv::Matx<_Tp, m, n>& v) const;

        /* //! conversion to another data type */
        /* template<typename T2> operator Matx<T2, m, n>() const; */

        //! change the matrix shape
        template<int m1, int n1> cv::Matx<_Tp, m1, n1> reshape() const;

        //! extract part of the matrix
        template<int m1, int n1> cv::Matx<_Tp, m1, n1> get_minor(int i, int j) const;

        /* //! extract the matrix row */
        /* Matx<_Tp, 1, n> row(int i) const; */

        /* //! extract the matrix column */
        /* Matx<_Tp, m, 1> col(int i) const; */

        /* //! extract the matrix diagonal */
        /* diag_type diag() const; */

        //! transpose the matrix
        cv::Matx<_Tp, n, m> t() const;

        /* //! invert the matrix */
        /* Matx<_Tp, n, m> inv(int method=DECOMP_LU, bool *p_is_ok = NULL) const; */

        //! solve linear system
        /* template<int l> Matx<_Tp, n, l> solve(const Matx<_Tp, m, l>& rhs, int flags=DECOMP_LU) const; */
        /* cv::Vec<_Tp, n> solve(const cv::Vec<_Tp, m>& rhs, int method) const; */

        //! multiply two matrices element-wise
        cv::Matx<_Tp, m, n> mul(const cv::Matx<_Tp, m, n>& a) const;

        //! divide two matrices element-wise
        Matx<_Tp, m, n> div(const Matx<_Tp, m, n>& a) const;

        //! element access
        const value_type& operator()(int i, int j) const;

        Matx(const cv::Matx<_Tp, m, n>& a, const cv::Matx<_Tp, m, n>& b, Matx_AddOp);
        Matx(const cv::Matx<_Tp, m, n>& a, const cv::Matx<_Tp, m, n>& b, Matx_SubOp);
        template<typename _T2> Matx(const cv::Matx<_Tp, m, n>& a, _T2 alpha, Matx_ScaleOp);
        Matx(const cv::Matx<_Tp, m, n>& a, const cv::Matx<_Tp, m, n>& b, Matx_MulOp);
        template<int l> Matx(const cv::Matx<_Tp, m, l>& a, const cv::Matx<_Tp, l, n>& b, Matx_MatMulOp);
        Matx(const cv::Matx<_Tp, n, m>& a, Matx_TOp);

        _Tp val[m*n]; //< matrix elements
    };

    typedef Matx<float, 1, 2> Matx12f;
    typedef Matx<double, 1, 2> Matx12d;
    typedef Matx<float, 1, 3> Matx13f;
    typedef Matx<double, 1, 3> Matx13d;
    typedef Matx<float, 1, 4> Matx14f;
    typedef Matx<double, 1, 4> Matx14d;
    typedef Matx<float, 1, 6> Matx16f;
    typedef Matx<double, 1, 6> Matx16d;

    typedef Matx<float, 2, 1> Matx21f;
    typedef Matx<double, 2, 1> Matx21d;
    typedef Matx<float, 3, 1> Matx31f;
    typedef Matx<double, 3, 1> Matx31d;
    typedef Matx<float, 4, 1> Matx41f;
    typedef Matx<double, 4, 1> Matx41d;
    typedef Matx<float, 6, 1> Matx61f;
    typedef Matx<double, 6, 1> Matx61d;

    typedef Matx<float, 2, 2> Matx22f;
    typedef Matx<double, 2, 2> Matx22d;
    typedef Matx<float, 2, 3> Matx23f;
    typedef Matx<double, 2, 3> Matx23d;
    typedef Matx<float, 3, 2> Matx32f;
    typedef Matx<double, 3, 2> Matx32d;

    typedef Matx<float, 3, 3> Matx33f;
    typedef Matx<double, 3, 3> Matx33d;

    typedef Matx<float, 3, 4> Matx34f;
    typedef Matx<double, 3, 4> Matx34d;
    typedef Matx<float, 4, 3> Matx43f;
    typedef Matx<double, 4, 3> Matx43d;

    typedef Matx<float, 4, 4> Matx44f;
    typedef Matx<double, 4, 4> Matx44d;
    typedef Matx<float, 6, 6> Matx66f;
    typedef Matx<double, 6, 6> Matx66d;
}

%extend cv::Matx
{
    %pythoncode
     {
         import re
         _re_pattern = re.compile("_Matx_(?P<value_type>[a-zA-Z_][a-zA-Z0-9_]*)_(?P<rows>[0-9]+)_(?P<cols>[0-9]+)")
     }

    Matx(std::vector<value_type> arg)
    {
        return Factory< $parentclassname >::construct(arg);
    }

    %pythonprepend Matx(std::vector<value_type> arg)
    {
        ma = self._re_pattern.fullmatch(self.__class__.__name__)
        value_type = ma.group("value_type")
        rows = int(ma.group("rows"))
        cols = int(ma.group("cols"))

        array = _array_map[value_type](rows*cols)
        for i in range(len(args)):
            array[i] = args[i]

        args = [array]
    }

    %pythoncode
    {
        def __getattribute__(self, name):
            if name == "__array_interface__":
                ma = self._re_pattern.fullmatch(self.__class__.__name__)
                value_type = ma.group("value_type")
                rows = int(ma.group("rows"))
                cols = int(ma.group("cols"))
                return {"shape": (rows, cols),
                        "typestr": _typestr_map[value_type],
                        "data": (int(self.val), False)}
            else:
                return object.__getattribute__(self, name)


        def __getitem__(self, key):
            ma = self._re_pattern.fullmatch(self.__class__.__name__)
            rows = int(ma.group("rows"))
            cols = int(ma.group("cols"))

            if isinstance(key, int):
                if rows != 1 and cols != 1:
                    raise IndexError
                i = key
                j = 0
            elif isinstance(key, tuple) and len(key) == 2:
                i = key[0]
                j = key[1]
            else:
                raise TypeError

            if i >= rows or j >= cols:
                raise IndexError

            return self(i, j)
    }

    char const* __str__()
    {
        std::ostringstream s;
        s << *$self;
        return s.str().c_str();
    }
}


/* %cv_matx_instantiate_defaults
 *
 * Generate a wrapper class to all cv::Matx which has a typedef on OpenCV header file.
 */
%define %cv_matx_instantiate_defaults
    %cv_matx_instantiate(float, 1, 2, f, f)
    %cv_matx_instantiate(double, 1, 2, d, f)
    %cv_matx_instantiate(float, 1, 3, f, f)
    %cv_matx_instantiate(double, 1, 3, d, f)
    %cv_matx_instantiate(float, 1, 4, f, f)
    %cv_matx_instantiate(double, 1, 4, d, f)
    %cv_matx_instantiate(float, 1, 6, f, f)
    %cv_matx_instantiate(double, 1, 6, d, f)

    %cv_matx_instantiate(float, 2, 1, f, f)
    %cv_matx_instantiate(double, 2, 1, d, f)
    %cv_matx_instantiate(float, 3, 1, f, f)
    %cv_matx_instantiate(double, 3, 1, d, f)
    %cv_matx_instantiate(float, 4, 1, f, f)
    %cv_matx_instantiate(double, 4, 1, d, f)
    %cv_matx_instantiate(float, 6, 1, f, f)
    %cv_matx_instantiate(double, 6, 1, d, f)

    %cv_matx_instantiate(float, 2, 2, f, f)
    %cv_matx_instantiate(double, 2, 2, d, f)
    %cv_matx_instantiate(float, 2, 3, f, f)
    %cv_matx_instantiate(double, 2, 3, d, f)
    %cv_matx_instantiate(float, 3, 2, f, f)
    %cv_matx_instantiate(double, 3, 2, d, f)

    %cv_matx_instantiate(float, 3, 3, f, f)
    %cv_matx_instantiate(double, 3, 3, d, f)

    %cv_matx_instantiate(float, 3, 4, f, f)
    %cv_matx_instantiate(double, 3, 4, d, f)
    %cv_matx_instantiate(float, 4, 3, f, f)
    %cv_matx_instantiate(double, 4, 3, d, f)

    %cv_matx_instantiate(float, 4, 4, f, f)
    %cv_matx_instantiate(double, 4, 4, d, f)
    %cv_matx_instantiate(float, 6, 6, f, f)
    %cv_matx_instantiate(double, 6, 6, d, f)
%enddef
