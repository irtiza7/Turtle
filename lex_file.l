%{

#include <stdio.h>
void showError();

#undef yywrap
#define yywrap() 1

%}

number ([0-9])+

%%

"irtiza" {
    printf("hello irtiza\n");
}

{number} {
    printf("number\n");
}

. {
    showError();
}

%%

int main()
{
    yylex();
}
void showError(){
    printf("OTHER");
}