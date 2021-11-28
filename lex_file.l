%{

#include <stdio.h>
void showError();

#undef yywrap
#define yywrap() 1

%}
identifier [a-zA-Z]+ | [a-zA-Z]+[a-zA-Z0-9]+
number [^a-z]+[0-9]+

%%

"irtiza" {
    printf("hello irtiza\n");
}
{number} {
    printf("number\n");
}
{identifier} {
    printf("identifier\n");
}
. ;

%%

int main()
{
    yylex();
}
void showError(){
    printf("OTHER");
}