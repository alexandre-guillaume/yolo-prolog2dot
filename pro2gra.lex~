%{
#include <string.h>
#include "pro2gra.tab.h"
#include <stdio.h>
#include "arbre.h"
%}

%option noyywrap

blanks          [ \t\n]+
const		[a-z][a-zA-Z0-9]*
variable	[A-Z][a-zA-Z0-9]*
entier		[0-9]+
char ([0-9]|[a-z]|[A-Z]|[_])



%%
{blanks}        { /* ignore */ }

{const}		{yylval = strdup(yytext); return(CONST); }
{variable}	{yylval = strdup(yytext); return(VARIABLE);}
{entier}	{yylval = strdup(yytext); return(ENTIER); }
\"{char}*\" 	{yylval = strdup(yytext); return(CONST_CHAR);}
[+]		{return(PLUS); }
[-]		{return(MOINS); }
[*]		{return(FOIS); }
[/]		{return(DIVISE); }
[(]		{return(OUVRIR); }
[)]		{return(FERMER); }
=		{return(AFFECT); }
> 		{return(GT);}
>= 		{return(GTE);}
[<] 		{return(LT);}
"<=" 		{return(LTE);}
== 		{return(EQ);}
!= 		{return(NE);}
%.* 		{}
"/*"([^*]|[*][^/])*"*/" {}
[,] 		{return(AND);}
[.] 		{return(EOL);}
":-" 		{return(SEP);}
.|\n 		{;}
%%

