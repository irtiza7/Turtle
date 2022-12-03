%option noyywrap

%{
#include <stdio.h>
#include "parser.tab.h"

#define YY_DECL int yylex()

void showError();

%}

%%
printf("true\n");
(true|false) {return bool_kw;}

"define"    {return define_kw;}
"if"        {return if_kw;}
"print"     {return print_kw;}
"else"      {return else_kw;}
"elif"      {return elif_kw;}
"return"    {return return_kw;}
"var"       {return var_kw;}
"and"       {return and_kw;}
"or"        {return or_kw;}
"null"      {return null_kw;}

[a-zA-Z][a-zA-Z0-9]*    {return identifier;}

[0-9]+\.[0-9]+ 	{
    yylval.float_value = atof(yytext); 
    return float_num;
}
[0-9]+		{
    yylval.integer_value = atoi(yytext); 
    return integer_num;
}
["][[a-zA-Z0-9]*]["] {
    return string_literal;
}

\n		{return newline;}
"="     {return assignment_op;}
"+"		{return plus_op;}
"-"		{return minus_op;}
"*"		{return multiply_op;}
"/"		{return division_op;}

"("		{return open_brace;}
")"		{return close_brace;}
"{"     {return open_curly;}
"}"     {return close_curly;}

[ \t\n]	;

. {showError();}

%%

void showError() {
    printf("Invalid character\n");
}