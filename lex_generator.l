%{
#include <stdio.h>
#undef yywrap
#define yywrap() 1

void showError();

%}

%%

(def|return|var|if|else|elif|and|or|null|true|false) {
    printf("KEYWORD\n");
}

[a-zA-Z][a-zA-Z0-9]* {
    printf("IDENTIFIER\n");
}

[0-9][0-9]* {
    printf("NUMBER LITERAL\n");
}

[ \t\n] ;

(;|\,|[|]) {
    printf("DELIMITER\n");
}

(=) {
    printf("ASSIGNMENT OPERATOR\n");
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
    printf("INVALID CHARACTER\n");
}