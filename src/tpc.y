%{
#include <stdio.h>   
extern int lineno, colno;

extern int yylex();
void yyerror(const char *msg); 
%}

%token TYPE NUM CHARACTER IF ELSE RETURN WHILE EQ ADDSUB DIVSTAR OR AND ORDER IDENT VOID


%%
Prog:  DeclVars DeclFoncts
    ;
DeclVars:
       DeclVars TYPE Declarateurs ';'
    |  DeclVars TYPE Declarateurs '[' NUM ']' ';'
    |
    ;
Declarateurs:
       Declarateurs ',' IDENT
    |  IDENT
    ;
DeclFoncts:
       DeclFoncts DeclFonct
    |  DeclFonct
    ;
DeclFonct:
       EnTeteFonct Corps
    ;
EnTeteFonct:
       TYPE IDENT '(' Parametres ')'
    |  VOID IDENT '(' Parametres ')'
    ;
Parametres:
       VOID
    |  ListTypVar
    ;
ListTypVar:
       ListTypVar ',' TYPE IDENT
    |  TYPE IDENT 
    |  TYPE IDENT'[' ']' 
    ;
Corps: '{' DeclVars SuiteInstr '}'
    ;
SuiteInstr:
       SuiteInstr Instr
    |
    ;
Instr:
       LValue '=' Exp ';'
    |  LValue '=' Exp '[' Exp ']' ';'
    |  IF '(' Exp ')' Instr
    |  IF '(' Exp ')' Instr ELSE Instr
    |  WHILE '(' Exp ')' Instr
    |  IDENT '(' Arguments  ')' ';'
    |  IDENT '[' Exp ']' Instr 
    |  RETURN Exp ';'
    |  RETURN ';'
    |  '{' SuiteInstr '}'
    |  ';'
    ;
Exp :  Exp OR TB
    |  TB
    ;
TB  :  TB AND FB
    |  FB
    ;
FB  :  FB EQ M
    |  M
    ;
M   :  M ORDER E
    |  E
    ;
E   :  E ADDSUB T
    |  T
    ;    
T   :  T DIVSTAR F 
    |  F
    ;
F   :  ADDSUB F
    |  '!' F
    |  '(' Exp ')'
    |  NUM
    |  CHARACTER
    |  LValue
    |  IDENT '(' Arguments  ')'
    |  IDENT '[' Exp ']'
    ;
LValue:
       IDENT
    |  IDENT '[' NUM ']'
    ;
Arguments:
       ListExp
    |
    ;
ListExp:
       ListExp ',' Exp
    |  Exp
    ;
%%

int main(void){
    yyparse();
    return 0;
}

void yyerror(const char *msg){
    fprintf(stderr, "Erreur : l%d:c%d -> %s\n", lineno, colno, msg);
}