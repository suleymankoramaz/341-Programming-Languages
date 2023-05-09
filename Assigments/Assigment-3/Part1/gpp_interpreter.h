/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_GPP_INTERPRETER_H_INCLUDED
# define YY_YY_GPP_INTERPRETER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    OP_OP = 258,                   /* OP_OP  */
    OP_CP = 259,                   /* OP_CP  */
    OP_PLUS = 260,                 /* OP_PLUS  */
    OP_MINUS = 261,                /* OP_MINUS  */
    OP_DIV = 262,                  /* OP_DIV  */
    OP_MULT = 263,                 /* OP_MULT  */
    OP_OC = 264,                   /* OP_OC  */
    OP_CC = 265,                   /* OP_CC  */
    KW_AND = 266,                  /* KW_AND  */
    KW_OR = 267,                   /* KW_OR  */
    KW_NOT = 268,                  /* KW_NOT  */
    KW_EQUAL = 269,                /* KW_EQUAL  */
    KW_GT = 270,                   /* KW_GT  */
    KW_NIL = 271,                  /* KW_NIL  */
    KW_DEFV = 272,                 /* KW_DEFV  */
    KW_SET = 273,                  /* KW_SET  */
    KW_DEFFUN = 274,               /* KW_DEFFUN  */
    KW_IF = 275,                   /* KW_IF  */
    KW_WHILE = 276,                /* KW_WHILE  */
    KW_EXIT = 277,                 /* KW_EXIT  */
    KW_TRUE = 278,                 /* KW_TRUE  */
    KW_FALSE = 279,                /* KW_FALSE  */
    COMMENT = 280,                 /* COMMENT  */
    VALUEF = 281,                  /* VALUEF  */
    ID = 282                       /* ID  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define OP_OP 258
#define OP_CP 259
#define OP_PLUS 260
#define OP_MINUS 261
#define OP_DIV 262
#define OP_MULT 263
#define OP_OC 264
#define OP_CC 265
#define KW_AND 266
#define KW_OR 267
#define KW_NOT 268
#define KW_EQUAL 269
#define KW_GT 270
#define KW_NIL 271
#define KW_DEFV 272
#define KW_SET 273
#define KW_DEFFUN 274
#define KW_IF 275
#define KW_WHILE 276
#define KW_EXIT 277
#define KW_TRUE 278
#define KW_FALSE 279
#define COMMENT 280
#define VALUEF 281
#define ID 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 63 "gpp_interpreter.y"

    int bool;
    char val[10]; 
    char id[10];

#line 127 "gpp_interpreter.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_GPP_INTERPRETER_H_INCLUDED  */
