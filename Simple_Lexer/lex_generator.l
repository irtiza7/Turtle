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

[\(|\)] {
    printf("DELIMITER\n");
}

[{|}] {
    printf("DELIMITER\n");
}

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