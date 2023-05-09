/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "gpp_interpreter.y"

    //C DEFINITIONS
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "gpp_interpreter.h"
    #define _OPEN_SYS_ITOA_EXT

    //FUNCTION DEFINITIONS
    //implement lexer functions
    extern FILE *yyin;
    void yyerror(char *);
    int  yylex(void);
 
    //function that generate operator expressions
    char* operator(char*,char*,int);
    //function that generate greater that expression
    int   greater_than(char*, char*s);
    //function that generate defvar expression
    void  def_variable(char*,char*);
    //function that generate set expression
    void  set_variable(char*,char*);
    //function that search id in variables array
    char* variable_index_return(char*);

    //function that define function
    void  def_function(char*,char*);
    //function that define function with parameters
    void  def_function_w_p(char*,char*,char*);
    //function that set parameters when function call
    void  set_function_paremeters(char*,char*);
    //function that call function
    char* func_call(char*);

    //variable struct that has name and valuef
    typedef struct Variable{
        char id[10];
        char val[10]; 
    }Variable;

    //variable array struct that has size and variable array
    typedef struct VariableStruct{
        int size;
        Variable* vars;
    }VariableStruct;

    //function struct that has id, explist and parameters
    typedef struct Function{
        char id[10];
        char explist[100];
        char parameters[10];
    }Function;

    //function array struct that has size and function array
    typedef struct FunctionStruct{
        int size;
        Function* funcs;
    }FunctionStruct;


#line 132 "gpp_interpreter.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "gpp_interpreter.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_OP_OP = 3,                      /* OP_OP  */
  YYSYMBOL_OP_CP = 4,                      /* OP_CP  */
  YYSYMBOL_OP_PLUS = 5,                    /* OP_PLUS  */
  YYSYMBOL_OP_MINUS = 6,                   /* OP_MINUS  */
  YYSYMBOL_OP_DIV = 7,                     /* OP_DIV  */
  YYSYMBOL_OP_MULT = 8,                    /* OP_MULT  */
  YYSYMBOL_OP_OC = 9,                      /* OP_OC  */
  YYSYMBOL_OP_CC = 10,                     /* OP_CC  */
  YYSYMBOL_KW_AND = 11,                    /* KW_AND  */
  YYSYMBOL_KW_OR = 12,                     /* KW_OR  */
  YYSYMBOL_KW_NOT = 13,                    /* KW_NOT  */
  YYSYMBOL_KW_EQUAL = 14,                  /* KW_EQUAL  */
  YYSYMBOL_KW_GT = 15,                     /* KW_GT  */
  YYSYMBOL_KW_NIL = 16,                    /* KW_NIL  */
  YYSYMBOL_KW_DEFV = 17,                   /* KW_DEFV  */
  YYSYMBOL_KW_SET = 18,                    /* KW_SET  */
  YYSYMBOL_KW_DEFFUN = 19,                 /* KW_DEFFUN  */
  YYSYMBOL_KW_IF = 20,                     /* KW_IF  */
  YYSYMBOL_KW_WHILE = 21,                  /* KW_WHILE  */
  YYSYMBOL_KW_EXIT = 22,                   /* KW_EXIT  */
  YYSYMBOL_KW_TRUE = 23,                   /* KW_TRUE  */
  YYSYMBOL_KW_FALSE = 24,                  /* KW_FALSE  */
  YYSYMBOL_COMMENT = 25,                   /* COMMENT  */
  YYSYMBOL_VALUEF = 26,                    /* VALUEF  */
  YYSYMBOL_ID = 27,                        /* ID  */
  YYSYMBOL_YYACCEPT = 28,                  /* $accept  */
  YYSYMBOL_INPUT = 29,                     /* INPUT  */
  YYSYMBOL_EXP = 30,                       /* EXP  */
  YYSYMBOL_EXPB = 31,                      /* EXPB  */
  YYSYMBOL_EXPLIST = 32,                   /* EXPLIST  */
  YYSYMBOL_IDLIST = 33,                    /* IDLIST  */
  YYSYMBOL_NUMLIST = 34                    /* NUMLIST  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  21
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   190

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  28
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  7
/* YYNRULES -- Number of rules.  */
#define YYNRULES  45
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  118

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   282


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    88,    88,    89,    90,    91,    92,    93,    98,    99,
     100,   101,   104,   105,   109,   111,   113,   115,   118,   124,
     131,   133,   135,   137,   140,   144,   144,   149,   150,   151,
     152,   153,   155,   155,   159,   160,   161,   162,   163,   164,
     168,   169,   170,   174,   175,   176
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "OP_OP", "OP_CP",
  "OP_PLUS", "OP_MINUS", "OP_DIV", "OP_MULT", "OP_OC", "OP_CC", "KW_AND",
  "KW_OR", "KW_NOT", "KW_EQUAL", "KW_GT", "KW_NIL", "KW_DEFV", "KW_SET",
  "KW_DEFFUN", "KW_IF", "KW_WHILE", "KW_EXIT", "KW_TRUE", "KW_FALSE",
  "COMMENT", "VALUEF", "ID", "$accept", "INPUT", "EXP", "EXPB", "EXPLIST",
  "IDLIST", "NUMLIST", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-25)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      50,    90,   -25,   -25,   -25,    21,   -25,   -25,   163,    58,
      58,    58,    58,   -24,   -23,   -21,    10,    10,     4,    13,
      37,   -25,   115,   -25,   -25,    13,    58,    58,    58,    58,
      58,    58,   146,   174,   -25,   -25,   152,   152,   -25,    58,
      18,   -25,    56,    19,    31,    45,    51,    65,    66,   140,
      67,    69,   152,    10,    10,    10,    58,    58,    75,    70,
      82,    83,   100,   -25,   -25,   111,   -25,   -25,   -25,   -25,
     -25,   -25,    -2,   -25,   -25,    84,    86,    10,    10,    88,
      58,    58,   -25,    95,    96,   -25,   -25,   -25,   -25,   125,
     -25,   127,   -25,    11,   -25,   -25,   101,   109,   -25,   120,
     121,   -25,   -25,   -25,   160,   -25,   136,   -25,   161,   -25,
     -25,   -25,   -25,   -25,   -25,   170,   -25,   -25
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     2,    26,    25,     0,     4,     5,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    25,
       0,     1,     0,     6,     7,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    32,    33,     0,     0,     3,     0,
       0,    34,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    24,    35,     0,     8,     9,    11,    10,
      13,    12,    25,    21,    20,     0,     0,     0,     0,     0,
       0,     0,    15,     0,     0,    14,    19,    18,    43,     0,
      36,     0,    40,     0,    22,    23,     0,     0,    29,     0,
       0,    16,    17,    44,     0,    37,     0,    41,     0,    27,
      28,    30,    31,    45,    38,     0,    42,    39
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -25,   -25,     0,   -10,    14,   -25,   -25
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     5,    20,    36,     7,    52,    40
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
       6,    39,    92,    30,    31,    23,    32,    37,    38,    26,
      27,    28,    29,    33,     0,   107,    39,     0,     0,    24,
      42,    21,    63,    66,    22,    93,    43,    44,    45,    46,
      47,    48,    50,    34,    35,    67,    58,    60,   108,    62,
       8,    41,    65,    77,    78,    79,    51,     3,     4,    68,
      59,    61,    75,     1,     0,    69,    80,    81,    83,     8,
      64,     8,    89,     3,     4,    91,    76,    96,    97,    70,
      71,    73,    84,    74,    85,     2,     3,     4,    22,    82,
      99,   100,     3,     4,     3,     4,    86,    87,    94,   104,
      95,   106,    98,     8,     0,     9,    10,    11,    12,   101,
     102,     3,     4,     8,    88,   109,   115,    13,    14,    15,
      16,    17,    18,   110,     8,    90,     3,    19,     8,     0,
       9,    10,    11,    12,   111,   112,     3,     4,     8,   103,
       8,   105,    13,    14,    15,    16,    17,     3,     4,     8,
     114,     3,    19,     8,     0,     9,    10,    11,    12,    49,
       0,     3,     4,     3,     4,    22,     0,    13,    14,    15,
      16,    17,     3,     4,   113,   116,     3,    72,     9,    10,
      11,    12,     3,     4,   117,     0,     0,     0,     3,     4,
      13,    14,    15,    16,    17,    53,    54,    55,    56,    57,
      25
};

static const yytype_int8 yycheck[] =
{
       0,     3,     4,    27,    27,     5,    27,    17,     4,     9,
      10,    11,    12,     3,    -1,     4,     3,    -1,    -1,     5,
      20,     0,     4,     4,     3,    27,    26,    27,    28,    29,
      30,    31,    32,    23,    24,     4,    36,    37,    27,    39,
       3,     4,    42,    53,    54,    55,    32,    26,    27,     4,
      36,    37,    52,     3,    -1,     4,    56,    57,    58,     3,
       4,     3,    62,    26,    27,    65,    52,    77,    78,     4,
       4,     4,    58,     4,     4,    25,    26,    27,     3,     4,
      80,    81,    26,    27,    26,    27,     4,     4,     4,    89,
       4,    91,     4,     3,    -1,     5,     6,     7,     8,     4,
       4,    26,    27,     3,     4,     4,   106,    17,    18,    19,
      20,    21,    22,     4,     3,     4,    26,    27,     3,    -1,
       5,     6,     7,     8,     4,     4,    26,    27,     3,     4,
       3,     4,    17,    18,    19,    20,    21,    26,    27,     3,
       4,    26,    27,     3,    -1,     5,     6,     7,     8,     3,
      -1,    26,    27,    26,    27,     3,    -1,    17,    18,    19,
      20,    21,    26,    27,     4,     4,    26,    27,     5,     6,
       7,     8,    26,    27,     4,    -1,    -1,    -1,    26,    27,
      17,    18,    19,    20,    21,    11,    12,    13,    14,    15,
      27
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     3,    25,    26,    27,    29,    30,    32,     3,     5,
       6,     7,     8,    17,    18,    19,    20,    21,    22,    27,
      30,     0,     3,    30,    32,    27,    30,    30,    30,    30,
      27,    27,    27,     3,    23,    24,    31,    31,     4,     3,
      34,     4,    30,    30,    30,    30,    30,    30,    30,     3,
      30,    32,    33,    11,    12,    13,    14,    15,    30,    32,
      30,    32,    30,     4,     4,    30,     4,     4,     4,     4,
       4,     4,    27,     4,     4,    30,    32,    31,    31,    31,
      30,    30,     4,    30,    32,     4,     4,     4,     4,    30,
       4,    30,     4,    27,     4,     4,    31,    31,     4,    30,
      30,     4,     4,     4,    30,     4,    30,     4,    27,     4,
       4,     4,     4,     4,     4,    30,     4,     4
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    28,    29,    29,    29,    29,    29,    29,    30,    30,
      30,    30,    30,    30,    30,    30,    30,    30,    30,    30,
      30,    30,    30,    30,    30,    30,    30,    31,    31,    31,
      31,    31,    31,    31,    32,    32,    32,    32,    32,    32,
      33,    33,    33,    34,    34,    34
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     3,     1,     1,     2,     2,     5,     5,
       5,     5,     5,     5,     5,     5,     6,     6,     5,     5,
       5,     5,     6,     6,     4,     1,     1,     5,     5,     4,
       5,     5,     1,     1,     3,     4,     5,     6,     7,     8,
       3,     4,     5,     3,     4,     5
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* INPUT: COMMENT  */
#line 88 "gpp_interpreter.y"
            {;}
#line 1229 "gpp_interpreter.c"
    break;

  case 3: /* INPUT: OP_OP KW_EXIT OP_CP  */
#line 89 "gpp_interpreter.y"
                        {exit(0);}
#line 1235 "gpp_interpreter.c"
    break;

  case 4: /* INPUT: EXP  */
#line 90 "gpp_interpreter.y"
        { printf("Syntax OK.\nResult: %s\n", (yyvsp[0].val));}
#line 1241 "gpp_interpreter.c"
    break;

  case 5: /* INPUT: EXPLIST  */
#line 91 "gpp_interpreter.y"
            { printf("Syntax OK.\nResult: %s\n", (yyvsp[0].val));}
#line 1247 "gpp_interpreter.c"
    break;

  case 6: /* INPUT: INPUT EXP  */
#line 92 "gpp_interpreter.y"
              { printf("Syntax OK.\nResult: %s\n", (yyvsp[0].val));}
#line 1253 "gpp_interpreter.c"
    break;

  case 7: /* INPUT: INPUT EXPLIST  */
#line 93 "gpp_interpreter.y"
                  { printf("Syntax OK.\nResult: %s\n", (yyvsp[0].val));}
#line 1259 "gpp_interpreter.c"
    break;

  case 8: /* EXP: OP_OP OP_PLUS EXP EXP OP_CP  */
#line 98 "gpp_interpreter.y"
                                  {strcpy((yyval.val),operator((yyvsp[-2].val),(yyvsp[-1].val),0));}
#line 1265 "gpp_interpreter.c"
    break;

  case 9: /* EXP: OP_OP OP_MINUS EXP EXP OP_CP  */
#line 99 "gpp_interpreter.y"
                                  {strcpy((yyval.val),operator((yyvsp[-2].val),(yyvsp[-1].val),1));}
#line 1271 "gpp_interpreter.c"
    break;

  case 10: /* EXP: OP_OP OP_MULT EXP EXP OP_CP  */
#line 100 "gpp_interpreter.y"
                                  {strcpy((yyval.val),operator((yyvsp[-2].val),(yyvsp[-1].val),2));}
#line 1277 "gpp_interpreter.c"
    break;

  case 11: /* EXP: OP_OP OP_DIV EXP EXP OP_CP  */
#line 101 "gpp_interpreter.y"
                                  {strcpy((yyval.val),operator((yyvsp[-2].val),(yyvsp[-1].val),3));}
#line 1283 "gpp_interpreter.c"
    break;

  case 12: /* EXP: OP_OP KW_SET ID EXP OP_CP  */
#line 104 "gpp_interpreter.y"
                               {set_variable((yyvsp[-2].id),(yyvsp[-1].val));strcpy((yyval.val),"0f1");}
#line 1289 "gpp_interpreter.c"
    break;

  case 13: /* EXP: OP_OP KW_DEFV ID EXP OP_CP  */
#line 105 "gpp_interpreter.y"
                               {def_variable((yyvsp[-2].id),(yyvsp[-1].val));strcpy((yyval.val),"0f1");}
#line 1295 "gpp_interpreter.c"
    break;

  case 14: /* EXP: OP_OP KW_IF EXPB EXPLIST OP_CP  */
#line 109 "gpp_interpreter.y"
                                        {if((yyvsp[-2].bool)){strcpy((yyval.val),(yyvsp[-1].val));}}
#line 1301 "gpp_interpreter.c"
    break;

  case 15: /* EXP: OP_OP KW_IF EXPB EXP OP_CP  */
#line 111 "gpp_interpreter.y"
                                        {if((yyvsp[-2].bool)){strcpy((yyval.val),(yyvsp[-1].val));}}
#line 1307 "gpp_interpreter.c"
    break;

  case 16: /* EXP: OP_OP KW_IF EXPB EXP EXP OP_CP  */
#line 113 "gpp_interpreter.y"
                                        {if((yyvsp[-3].bool)){strcpy((yyval.val),(yyvsp[-2].val));} else  {strcpy((yyval.val),(yyvsp[-1].val));}}
#line 1313 "gpp_interpreter.c"
    break;

  case 17: /* EXP: OP_OP KW_IF EXPB EXP EXPLIST OP_CP  */
#line 115 "gpp_interpreter.y"
                                        {if((yyvsp[-3].bool)){strcpy((yyval.val),(yyvsp[-2].val));} else  {strcpy((yyval.val),(yyvsp[-1].val));}}
#line 1319 "gpp_interpreter.c"
    break;

  case 18: /* EXP: OP_OP KW_WHILE EXPB EXPLIST OP_CP  */
#line 118 "gpp_interpreter.y"
                                        {   //while(1){
                                                if((yyvsp[-2].bool))
                                                    strcpy((yyval.val),(yyvsp[-1].val));
                                            //}
                                        }
#line 1329 "gpp_interpreter.c"
    break;

  case 19: /* EXP: OP_OP KW_WHILE EXPB EXP OP_CP  */
#line 124 "gpp_interpreter.y"
                                        {   //while(1){
                                                if((yyvsp[-2].bool))
                                                    strcpy((yyval.val),(yyvsp[-1].val));
                                            //}
                                        }
#line 1339 "gpp_interpreter.c"
    break;

  case 20: /* EXP: OP_OP KW_DEFFUN ID EXPLIST OP_CP  */
#line 131 "gpp_interpreter.y"
                                            {def_function((yyvsp[-2].id),(yyvsp[-1].val));strcpy((yyval.val),"0f1");}
#line 1345 "gpp_interpreter.c"
    break;

  case 21: /* EXP: OP_OP KW_DEFFUN ID EXP OP_CP  */
#line 133 "gpp_interpreter.y"
                                            {def_function((yyvsp[-2].id),(yyvsp[-1].val));strcpy((yyval.val),"0f1");}
#line 1351 "gpp_interpreter.c"
    break;

  case 22: /* EXP: OP_OP KW_DEFFUN ID IDLIST EXP OP_CP  */
#line 135 "gpp_interpreter.y"
                                              {def_function_w_p((yyvsp[-3].id),(yyvsp[-1].val),(yyvsp[-2].val));strcpy((yyval.val),"0f1");}
#line 1357 "gpp_interpreter.c"
    break;

  case 23: /* EXP: OP_OP KW_DEFFUN ID IDLIST EXPLIST OP_CP  */
#line 137 "gpp_interpreter.y"
                                              {def_function_w_p((yyvsp[-3].id),(yyvsp[-1].val),(yyvsp[-2].val));strcpy((yyval.val),"0f1");}
#line 1363 "gpp_interpreter.c"
    break;

  case 24: /* EXP: OP_OP ID NUMLIST OP_CP  */
#line 140 "gpp_interpreter.y"
                           {set_function_paremeters((yyvsp[-2].id),(yyvsp[-1].val)); strcpy((yyval.val),variable_index_return((yyvsp[-2].id))); }
#line 1369 "gpp_interpreter.c"
    break;

  case 25: /* EXP: ID  */
#line 144 "gpp_interpreter.y"
       {strcpy((yyval.val),variable_index_return((yyvsp[0].id)));}
#line 1375 "gpp_interpreter.c"
    break;

  case 26: /* EXP: VALUEF  */
#line 144 "gpp_interpreter.y"
                                                             {strcpy((yyval.val),(yyvsp[0].val));}
#line 1381 "gpp_interpreter.c"
    break;

  case 27: /* EXPB: OP_OP KW_AND EXPB EXPB OP_CP  */
#line 149 "gpp_interpreter.y"
                                 {(yyval.bool) = (yyvsp[-2].bool)&&(yyvsp[-1].bool);}
#line 1387 "gpp_interpreter.c"
    break;

  case 28: /* EXPB: OP_OP KW_OR EXPB EXPB OP_CP  */
#line 150 "gpp_interpreter.y"
                                {(yyval.bool) = (yyvsp[-2].bool)||(yyvsp[-1].bool);}
#line 1393 "gpp_interpreter.c"
    break;

  case 29: /* EXPB: OP_OP KW_NOT EXPB OP_CP  */
#line 151 "gpp_interpreter.y"
                            {(yyval.bool) = !(yyvsp[-1].bool);}
#line 1399 "gpp_interpreter.c"
    break;

  case 30: /* EXPB: OP_OP KW_EQUAL EXP EXP OP_CP  */
#line 152 "gpp_interpreter.y"
                                 {(yyval.bool) = !(strcmp((yyvsp[-2].val),(yyvsp[-1].val)));}
#line 1405 "gpp_interpreter.c"
    break;

  case 31: /* EXPB: OP_OP KW_GT EXP EXP OP_CP  */
#line 153 "gpp_interpreter.y"
                              {(yyval.bool) = greater_than((yyvsp[-2].val),(yyvsp[-1].val));}
#line 1411 "gpp_interpreter.c"
    break;

  case 32: /* EXPB: KW_TRUE  */
#line 155 "gpp_interpreter.y"
            {(yyval.bool) = 1;}
#line 1417 "gpp_interpreter.c"
    break;

  case 33: /* EXPB: KW_FALSE  */
#line 155 "gpp_interpreter.y"
                                      {(yyval.bool) = 0;}
#line 1423 "gpp_interpreter.c"
    break;

  case 34: /* EXPLIST: OP_OP EXP OP_CP  */
#line 159 "gpp_interpreter.y"
                    {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1429 "gpp_interpreter.c"
    break;

  case 35: /* EXPLIST: OP_OP EXP EXP OP_CP  */
#line 160 "gpp_interpreter.y"
                        {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1435 "gpp_interpreter.c"
    break;

  case 36: /* EXPLIST: OP_OP EXP EXP EXP OP_CP  */
#line 161 "gpp_interpreter.y"
                            {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1441 "gpp_interpreter.c"
    break;

  case 37: /* EXPLIST: OP_OP EXP EXP EXP EXP OP_CP  */
#line 162 "gpp_interpreter.y"
                                {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1447 "gpp_interpreter.c"
    break;

  case 38: /* EXPLIST: OP_OP EXP EXP EXP EXP EXP OP_CP  */
#line 163 "gpp_interpreter.y"
                                    {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1453 "gpp_interpreter.c"
    break;

  case 39: /* EXPLIST: OP_OP EXP EXP EXP EXP EXP EXP OP_CP  */
#line 164 "gpp_interpreter.y"
                                        {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1459 "gpp_interpreter.c"
    break;

  case 40: /* IDLIST: OP_OP ID OP_CP  */
#line 168 "gpp_interpreter.y"
                   {def_variable((yyvsp[-1].id),"0f1"); strcpy((yyval.val),(yyvsp[-1].id));}
#line 1465 "gpp_interpreter.c"
    break;

  case 41: /* IDLIST: OP_OP ID ID OP_CP  */
#line 169 "gpp_interpreter.y"
                      {def_variable((yyvsp[-2].id),"0f1"); def_variable((yyvsp[-1].id),"0f1");char temp[100]; sprintf(temp,"%s%c%s",(yyvsp[-2].id),' ',(yyvsp[-1].id)); strcpy((yyval.val),temp);}
#line 1471 "gpp_interpreter.c"
    break;

  case 42: /* IDLIST: OP_OP ID ID ID OP_CP  */
#line 170 "gpp_interpreter.y"
                         {def_variable((yyvsp[-3].id),"0f1"); def_variable((yyvsp[-2].id),"0f1"); def_variable((yyvsp[-1].id),"0f1");  char temp[100]; sprintf(temp,"%s%c%s%c%s",(yyvsp[-3].id),' ',(yyvsp[-2].id),' ',(yyvsp[-1].id)); strcpy((yyval.val),temp);}
#line 1477 "gpp_interpreter.c"
    break;

  case 43: /* NUMLIST: OP_OP EXP OP_CP  */
#line 174 "gpp_interpreter.y"
                    {strcpy((yyval.val),(yyvsp[-1].val));}
#line 1483 "gpp_interpreter.c"
    break;

  case 44: /* NUMLIST: OP_OP EXP EXP OP_CP  */
#line 175 "gpp_interpreter.y"
                        {char temp[100]; sprintf(temp,"%s%c%s",(yyvsp[-2].val),' ',(yyvsp[-1].val)); strcpy((yyval.val),temp);}
#line 1489 "gpp_interpreter.c"
    break;

  case 45: /* NUMLIST: OP_OP EXP EXP EXP OP_CP  */
#line 176 "gpp_interpreter.y"
                            {char temp[100]; sprintf(temp,"%s%c%s%c%s",(yyvsp[-3].val),' ',(yyvsp[-2].val),' ',(yyvsp[-1].val)); strcpy((yyval.val),temp);}
#line 1495 "gpp_interpreter.c"
    break;


#line 1499 "gpp_interpreter.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 178 "gpp_interpreter.y"


//definitions of arrays
VariableStruct  variables; //for variables
FunctionStruct  functions; //for functions

//FUNCTION DECLERATIONS
//-------------------------------------------------------------------
char* operator(char* f, char* s,int op){

    //temporary variables
    //f1 , s1 = numerator and denominator of first valuef 
    //f2 , s2 = numerator and denominator of second valuef 
    int  f1,s1,f2,s2;

    //first valuef
    //set sayi1 with chararters until 'f' from begin
    char* sayi1 = strtok(f,"f");
    //set sayi2 with chararters until end from 'f'
    char* sayi2 = strtok(NULL,"f");
    //convertiog integer
    f1 = atoi(sayi1);
    s1 = atoi(sayi2);

    //second valuef
    sayi1 = strtok(s,"f");
    sayi2 = strtok(NULL,"f");
    f2 = atoi(sayi1);
    s2 = atoi(sayi2);

    char rtn[100];
    char* rtn0;
    int   rtn1;
    int   rtn2;

    //operator control
    // 0 = plus , 1 = minus , 2 = mult , 3 = div
    switch(op)
    {
        case 0:
            rtn1 = (f1*s2) + (f2*s1);
            rtn2 = (s1*s2);
            break;
        case 1:
            rtn1 = (f1*s2) - (f2*s1);
            rtn2 = (s1*s2);
            break;
        case 2:
            rtn1 = (f1*f2);
            rtn2 = (s1*s2);
            break;
        case 3:
            rtn1 = (f1*s2);
            rtn2 = (s1*f2);
            break;
    }  

    //return value , append numerator + 'f' + denominator
    sprintf(rtn,"%d%s%d",rtn1,"f",rtn2);
    rtn0 = rtn;
    return rtn0;
}

int greater_than(char* f, char* s){
    //temporary variables
    //f1 , s1 = numerator and denominator of first valuef 
    //f2 , s2 = numerator and denominator of second valuef 
    int  f1,s1,f2,s2;

    //first valuef
    //set sayi1 with characters until 'f' from begin
    char* sayi1 = strtok(f,"f");
    //set sayi1 with characters until end from 'f'
    char* sayi2 = strtok(NULL,"f");

    //converting integer
    f1 = atoi(sayi1);
    s1 = atoi(sayi2);

    //second valuef
    sayi1 = strtok(s,"f");
    sayi2 = strtok(NULL,"f");
    f2 = atoi(sayi1);
    s2 = atoi(sayi2);

    if( (f1/s1) > (f2/s2))
        return 1;
    else
        return 0;
}

void def_variable(char* id,char* num){ 
    //control variable
    int check = 0;
    //control is there a variable that has same id
    for(int i=0;i< variables.size;i++){
        if(strcmp(variables.vars[i].id,id)==0){
            check = 1;
        }
    }

    //if there is return error
    if(check == 1){
        printf("ERROR!! %s Already defined.\n",id);
        exit(-1);
    }

    //if there is no error
    //if there is no element in variables array
    if(variables.size==0 || variables.vars==NULL){
        variables.vars=(Variable*) malloc(1);
        strcpy(variables.vars[0].id,id);
        strcpy(variables.vars[0].val,num);
        variables.size=1;
    }
    
    //if there is at least one element in variables array
    else{
        variables.vars=(Variable*)realloc(variables.vars,sizeof(Variable)*(variables.size+1));
        strcpy(variables.vars[variables.size].id,id);
        strcpy(variables.vars[variables.size].val,num);
        variables.size++;
    }
}

void set_variable(char* id,char* num){
    //control variable
    int check = 0;
    for(int i=0;i< variables.size;i++){
        //find variable that has this id
        if(strcmp(variables.vars[i].id,id)==0){
            //set valuef or variable
            strcpy(variables.vars[i].val,num);
            check = 1;
        }
    }
    //if there is no variable that has this id
    if(check==0){
        printf("ERROR!! %s Does not exist.\n",id);
        exit(-1);check = 1;
    }
}

char* variable_index_return(char* id){
    //find variable in variables array and return it's valluef
    for(int i=0;i< variables.size;i++){
        if(strcmp(variables.vars[i].id,id)==0)
            return  variables.vars[i].val;
    }
    //if there is no variable control functions because it can be function call too
    func_call(id);
}

void def_function(char* id,char* explist){
    //control variable
    int check = 0;
    //control is there a function that has same id
    for(int i=0;i< functions.size;i++){
        if(strcmp(functions.funcs[i].id,id)==0){
            check = 1;
        }
    }

    //if there is a function that has same id
    if(check == 1){
        printf("ERROR!! %s Already defined.\n",id);
        exit(-1);check = 1;
    }

    //if there is no function that has same id
    //if there is no element in functions array
    if(functions.size==0 || functions.funcs==NULL){
        functions.funcs=(Function*) malloc(1);
        strcpy(functions.funcs[0].id,id);
        strcpy(functions.funcs[0].explist,explist);
        functions.size=1;
    }
    //if there is at least one element in functions array
    else{
        functions.funcs=(Function*)realloc(functions.funcs,sizeof(Function)*(functions.size+1));
        strcpy(functions.funcs[functions.size].id,id);
        strcpy(functions.funcs[functions.size].explist,explist);
        functions.size++;
    }
}

void def_function_w_p(char* id,char* explist,char* parameters){
    //control variable
    int check = 0;
    //control is there a function that has same id
    for(int i=0;i< functions.size;i++){
        if(strcmp(functions.funcs[i].id,id)==0){
            check = 1;
        }
    }
    //if there is a function that has same id
    if(check == 1){
        printf("ERROR!! %s Already defined.\n",id);
        exit(-1);check = 1;
    }
    
    //if there is no function that has same id
    //if there is no element in functions array
    if(functions.size==0 || functions.funcs==NULL){
        functions.funcs=(Function*) malloc(1);
        strcpy(functions.funcs[0].id,id);
        strcpy(functions.funcs[0].explist,explist);
        strcpy(functions.funcs[0].parameters,parameters);
        functions.size=1;
    }
    //if there is at least one element in functions array
    else{
        functions.funcs=(Function*)realloc(functions.funcs,sizeof(Function)*(functions.size+1));
        strcpy(functions.funcs[functions.size].id,id);
        strcpy(functions.funcs[functions.size].explist,explist);
        strcpy(functions.funcs[functions.size].parameters,parameters);
        functions.size++;
    }
}

void set_function_paremeters(char* func_id,char* explist){
    
    //array for function parameters
    char str[100];
    for(int i=0;i<functions.size;i++){
        if(strcmp(functions.funcs[i].id,func_id)==0){
            strcpy(str,functions.funcs[i].parameters);
        }
    }

    //array for expression list expressions
    char* pch1;
    char* pch2;

    //seperate string to array
    //-------------------------------
    pch1 = strtok (str," ");
    char* pch01[3];
    char* pch02[3];
    
    int i = 0, j = 0;
    while (pch1 != NULL)
    {
        pch01[i] = pch1;
        pch1 = strtok (NULL, " ");
        i++;
    }

    pch2 = strtok (explist," ");
    while (pch2 != NULL)
    {
        pch02[j] = pch2;
        pch2 = strtok (NULL, " ");
        j++;
    }
    //-------------------------------

    //set variables 
    //for loop for control number of parameters
    for(int k=0;k<i;k++){
        set_variable(pch01[k],pch02[k]);
    }
}

char* func_call(char* id){
    //find function in functions array and return explist valuef
    for(int i=0;i< functions.size;i++){
        if(strcmp(functions.funcs[i].id,id)==0)
            return functions.funcs[i].explist;
    }

    //if there is no function that has this id
    printf("Does not exist %s\n",id);
    exit(-1);
}
//-------------------------------------------------------------------


//main function
int main(){
    //initial values of arrays
    variables.size=0;
    variables.vars=NULL;
    functions.size=0;
    functions.funcs=NULL;

    //loop until exit
    while(1)
        yyparse();
        
    return 0;
}

//error function
void yyerror(char * s){
    printf ("%s\n", s); exit(0);
}
