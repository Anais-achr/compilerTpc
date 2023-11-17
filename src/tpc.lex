%{
#include "tpc.tab.h"
int lineno = 1;
int colno = 1;
%}

%option noinput
%option nounput
%option noyywrap

%x COMMENT_SIMPLE
%x COMMENT_MULTILINES

%%

"="|"!"|";"|","|"("|")"|"{"|"}"|"["|"]"   { return yytext[0]; }


[0-9]+     { return NUM; }
[a-zA-Z]   { return IDENT; } 

if         { return IF; }
else       { return ELSE; }
return     { return RETURN; }
while      { return WHILE; }

int        { return TYPE; }
char       { return TYPE; }
void       { return VOID; }

"=="|"!="  { return EQ; }
"+"|"-"    { return ADDSUB; }   
"*"|"/"|"%" { return DIVSTAR; }
"||"       { return OR; }
"&&"       { return AND; }
[_a-zA-Z][_a-zA-Z0-9]* { return IDENT; }

"<"|">"|"<="|">=" { return ORDER; }
\n        { lineno++; colno = 1; }
[ \r\t]+  ;

"//" { BEGIN COMMENT_SIMPLE; }
<COMMENT_SIMPLE>. ;
<COMMENT_SIMPLE>\n { BEGIN INITIAL; lineno++; colno = 1; }

"/*" { BEGIN COMMENT_MULTILINES; }
<COMMENT_MULTILINES>\n { lineno++; colno = 1; }
<COMMENT_MULTILINES>. ;
<COMMENT_MULTILINES>"*/" { BEGIN INITIAL; }
%%
