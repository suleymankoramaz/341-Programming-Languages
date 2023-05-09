/** G++ Language Lexer using Flex **/
   
    /* DEFINITION PART */

%{  
    /* Deffine value for open-close quote */
    int op_cc = 1;
%}

    /* Definition of comment,values and idendifier */

COMMENT [;]{2}.*
VALUEF [1-9][0-9]*+[f]+[1-9][0-9]*
VALUEI [1-9][0-9]*|[0]
VALUESTR ["]+[a-zA-Z][a-zA-Z0-9]*+["]
IDENTIFIER [a-zA-Z][a-zA-Z0-9]*

    /* END OF DEFINITION PART */


    /* RULE PART */
%%

    /* OPERATORS */

[+]     {printf("OP_PLUS\n");}
[-]     {printf("OP_MINUS\n");}
[/]     {printf("OP_DIV\n");}
[*]     {printf("OP_MULT\n");}
[(]     {printf("OP_OP\n");}
[)]     {printf("OP_CP\n");}
[*]{2}  {printf("OP_DBLMULT\n");}
[0]     {printf("INSTANCE(0)\n");}
["]     {        
            if(op_cc == 1) {printf("OP_OC\n"); op_cc = 0;}
            else           {printf("OP_CC\n"); op_cc = 1;}
        }
[,]     {printf("OP_PLUS\n");}

    /* KEYWORDS */

and     {printf("KW_AND\n");}
or      {printf("KW_OR\n");}
not     {printf("KW_NOT\n");}
equal   {printf("KW_EQUAL\n");}
less    {printf("KW_LESS\n");}
nil     {printf("KW_NIL\n");}
list    {printf("KW_LIST\n");}
append  {printf("KW_APPEND\n");}
concat  {printf("KW_CONCAT\n");}
set     {printf("KW_SET\n");}
deffun  {printf("KW_DEFFUN\n");}
for     {printf("KW_FOR\n");}
if      {printf("KW_IF\n");}
exit    {printf("KW_EXIT\n"); return 0;}
load    {printf("KW_LOAD\n");}
disp    {printf("KW_DISP\n");}
true    {printf("KW_TRUE\n");}
false   {printf("KW_FALSE\n");}

    /* Check error in keywords */
    /* for example:
    /* list -> correct | liste -> incorrect */
    /* liste -> list + e */
and+[a-zA-Z]*      {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
or+[a-zA-Z]*       {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
not+[a-zA-Z]*      {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
equal+[a-zA-Z]*    {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
less+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
nil+[a-zA-Z]*      {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
list+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
append+[a-zA-Z]*   {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
concat+[a-zA-Z]*   {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
set+[a-zA-Z]*      {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
deffun+[a-zA-Z]*   {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
for+[a-zA-Z]*      {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
if+[a-zA-Z]*       {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
exit+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
load+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
disp+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
true+[a-zA-Z]*     {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}
false+[a-zA-Z]*    {printf("Error!! Lexically incorrect statements or expressions: '%s'.\n",yytext);return 0;}


    /* Rules of the comment,values and idetifier */

{COMMENT}       {printf("COMMENT\n");}
{VALUEI}        {printf("VALUEI\n");}
{VALUEF}        {printf("VALUEF\n");}
{VALUESTR}      {printf("VALUESTR\n");}
{IDENTIFIER}    {printf("IDENTIFIER\n");}

    /* Rule for ignore \n,\t and space */
[\t]    {;}
[\n]    {;}
[ ]     {;}

    /* Error check for undefined statements */
. { printf("Error!! Undefined statement: '%s'\n",yytext);}

%%
    /* END OF RULE PART */


int yywrap() {}
int main(int argc , char** argv)
{
    if(argc == 1)
    {
        printf("Type exit to exit\n");
        printf("Lexer started:\n");
    }

    else if (argc == 2)
    {
        FILE *fp;
        fp = fopen(argv[1], "r");
        yyin = fp;
    }

    yylex();
    return 0;
}