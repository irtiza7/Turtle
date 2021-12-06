%{

#include <stdio.h>
#include "y.tab.h"
#undef yywrap
#define yywrap() 1

extern int yylval;
void showError();

%}

%%

(def|return|var|if|else|elif|and|or|null|true|false) {
    yylval.name = yytext[0];
    return keyword;
}
[a-zA-Z][a-zA-Z0-9]* {
    yylval.name = yytext[0];
    return identifier;
}
[0-9][0-9]* {
    yylval.integer = atoi(yytext);
    return int_n;
}
[0-9]+\.[0-9]+ 	{
    yylval.decimal = atof(yytext); 
    return float_n;
}
[+|-|*|/|%] {
    yylval.oper = yytext[0];
    return operator;
}
(=) {
    return assignment;
}
[\(] {
    return o_brace;
}
[\)] {
    return c_brace;
}
[{] {
    return o_curly;
}
[}] {
    return c_curly;
}
[ \t] ;
[\n] ;

(\,|[|]) {
    return delimiter;
}
. {
    showError();
}

%%

int main(int argc, char *argv[])
{
    if (argc != 2) {
        printf("Usage: <./a.exe> <source file> \n");
    }
    
    yyin = fopen(argv[1], "r");
    yylex();
}
void showError(){
    printf("INVALID CHARACTER\n");
}