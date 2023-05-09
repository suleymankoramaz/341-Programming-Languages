%{
    #include <stdio.h>
    #include <ctype.h>
    #include "gpp_interpreter.h"
    void yyerror(char *);
    extern YYSTYPE yylval; 
    int op_cc=1;
%}

COMMENT [;]{2}.*
VALUEF [0-9]*+[f]+[1-9][0-9]*
ID [a-zA-Z][a-zA-Z0-9]*

%%

"("      {return OP_OP;}
")"      {return OP_CP;}
"+ "     {return OP_PLUS;}
"-"      {return OP_MINUS;}
"* "     {return OP_MULT;}
"/ "     {return OP_DIV;}
"\""     { if (op_cc==1){ op_cc=0; return OP_OC;}
           else{ op_cc=1; return OP_CC;}}

"and"       {return KW_AND;}
"or"        {return KW_OR;}
"not"       {return KW_NOT;}
"eq"        {return KW_EQUAL;} 
"gt"        {return KW_GT;}
"nil"       {return KW_NIL;}
"defvar"    {return KW_DEFV;}
"set"       {return KW_SET;}
"deffun"    {return KW_DEFFUN;}
"if"        {return KW_IF;}
"while"     {return KW_WHILE;}
"exit"      {return KW_EXIT;}
"true"      {return KW_TRUE;}
"false"     {return KW_FALSE;}


{COMMENT}    {return COMMENT;} 
{VALUEF}     {strcpy(yylval.val, yytext); return VALUEF;}
{ID} {strcpy(yylval.id, yytext); return ID;}

[\t]    {;}
[\n]    {;}
[ ]     {;}

. {yyerror("SYNTAX_ERROR Expression not recognized");}
%%

int yywrap(){ }