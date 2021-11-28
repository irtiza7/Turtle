%{

#include <stdio.h>
void showError();

#undef yywrap
#define yywrap() 1

%}

%%

(def|return|var|if|else|elif|and|or|null|true|false) {
    printf("keyword\n");
}

[a-zA-Z][a-zA-Z0-9]* {
    printf("identifier\n");
}

[0-9][0-9]* {
    printf("number\n");
}

[ \t\n] ;

. {
    printf("invalid character\n");
}

%%

int main()
{
    yylex();
}
void showError(){
    printf("OTHER");
}