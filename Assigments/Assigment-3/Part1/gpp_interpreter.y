%{
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

%}

%union 
{
    int bool;
    char val[10]; 
    char id[10];
}

%start INPUT

%token OP_OP OP_CP OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OC OP_CC
%token KW_AND KW_OR KW_NOT KW_EQUAL KW_GT KW_NIL KW_DEFV KW_SET KW_DEFFUN KW_IF KW_WHILE KW_EXIT KW_TRUE KW_FALSE

%token COMMENT
%token <val> VALUEF
%token <id>ID

%type <val>  INPUT
%type <val>  EXP
%type <bool> EXPB
%type <val>  EXPLIST
%type <val>  IDLIST
%type <val>  NUMLIST

%%

INPUT: 
    COMMENT {;}                                              |
    OP_OP KW_EXIT OP_CP {exit(0);}                           |
    EXP { printf("Syntax OK.\nResult: %s\n", $1);}           |
    EXPLIST { printf("Syntax OK.\nResult: %s\n", $1);}       |
    INPUT EXP { printf("Syntax OK.\nResult: %s\n", $2);}     |
    INPUT EXPLIST { printf("Syntax OK.\nResult: %s\n", $2);}  
;

EXP:
    //operator expression
    OP_OP OP_PLUS EXP EXP OP_CP   {strcpy($$,operator($3,$4,0));}    |
    OP_OP OP_MINUS EXP EXP OP_CP  {strcpy($$,operator($3,$4,1));}    |
    OP_OP OP_MULT EXP EXP OP_CP   {strcpy($$,operator($3,$4,2));}    |
    OP_OP OP_DIV EXP EXP OP_CP    {strcpy($$,operator($3,$4,3));}    |
    
    //defvar and set expressions
    OP_OP KW_SET ID EXP OP_CP  {set_variable($3,$4);strcpy($$,"0f1");}    | 
    OP_OP KW_DEFV ID EXP OP_CP {def_variable($3,$4);strcpy($$,"0f1");}    |


    //if expression
    OP_OP KW_IF EXPB EXPLIST OP_CP      {if($3){strcpy($$,$4);}}                           
    | 
    OP_OP KW_IF EXPB EXP OP_CP          {if($3){strcpy($$,$4);}}          
    | 
    OP_OP KW_IF EXPB EXP EXP OP_CP      {if($3){strcpy($$,$4);} else  {strcpy($$,$5);}}        
    | 
    OP_OP KW_IF EXPB EXP EXPLIST OP_CP  {if($3){strcpy($$,$4);} else  {strcpy($$,$5);}}    
    |  
    //while expresison
    OP_OP KW_WHILE EXPB EXPLIST OP_CP   {   //while(1){
                                                if($3)
                                                    strcpy($$,$4);
                                            //}
                                        }
    |
    OP_OP KW_WHILE EXPB EXP OP_CP       {   //while(1){
                                                if($3)
                                                    strcpy($$,$4);
                                            //}
                                        }
    |
    //deffun expression
    OP_OP KW_DEFFUN ID EXPLIST OP_CP        {def_function($3,$4);strcpy($$,"0f1");}
    |
    OP_OP KW_DEFFUN ID EXP OP_CP            {def_function($3,$4);strcpy($$,"0f1");}
    |
    OP_OP KW_DEFFUN ID IDLIST EXP OP_CP       {def_function_w_p($3,$5,$4);strcpy($$,"0f1");}
    |
    OP_OP KW_DEFFUN ID IDLIST EXPLIST OP_CP   {def_function_w_p($3,$5,$4);strcpy($$,"0f1");}
    |
    //function call expression
    OP_OP ID NUMLIST OP_CP {set_function_paremeters($2,$3); strcpy($$,variable_index_return($2)); } 
    |

    //id and valuef expressions
    ID {strcpy($$,variable_index_return($1));}   |    VALUEF {strcpy($$,$1);}                             
;

EXPB:
    //boolean expressions
    OP_OP KW_AND EXPB EXPB OP_CP {$$ = $3&&$4;}              |
    OP_OP KW_OR EXPB EXPB OP_CP {$$ = $3||$4;}               |
    OP_OP KW_NOT EXPB OP_CP {$$ = !$3;}                      |
    OP_OP KW_EQUAL EXP EXP OP_CP {$$ = !(strcmp($3,$4));}    |
    OP_OP KW_GT EXP EXP OP_CP {$$ = greater_than($3,$4);}    |
    
    KW_TRUE {$$ = 1;}    |   KW_FALSE {$$ = 0;}
;

EXPLIST :
    OP_OP EXP OP_CP {strcpy($$,$2);}                     |
    OP_OP EXP EXP OP_CP {strcpy($$,$3);}                 |
    OP_OP EXP EXP EXP OP_CP {strcpy($$,$4);}             |
    OP_OP EXP EXP EXP EXP OP_CP {strcpy($$,$5);}         |
    OP_OP EXP EXP EXP EXP EXP OP_CP {strcpy($$,$6);}     |
    OP_OP EXP EXP EXP EXP EXP EXP OP_CP {strcpy($$,$7);}  
;

IDLIST :
    OP_OP ID OP_CP {def_variable($2,"0f1"); strcpy($$,$2);} |
    OP_OP ID ID OP_CP {def_variable($2,"0f1"); def_variable($3,"0f1");char temp[100]; sprintf(temp,"%s%c%s",$2,' ',$3); strcpy($$,temp);} |
    OP_OP ID ID ID OP_CP {def_variable($2,"0f1"); def_variable($3,"0f1"); def_variable($4,"0f1");  char temp[100]; sprintf(temp,"%s%c%s%c%s",$2,' ',$3,' ',$4); strcpy($$,temp);}
;

NUMLIST:
    OP_OP EXP OP_CP {strcpy($$,$2);}                                                                            |
    OP_OP EXP EXP OP_CP {char temp[100]; sprintf(temp,"%s%c%s",$2,' ',$3); strcpy($$,temp);}                    |
    OP_OP EXP EXP EXP OP_CP {char temp[100]; sprintf(temp,"%s%c%s%c%s",$2,' ',$3,' ',$4); strcpy($$,temp);}     
;
%%

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