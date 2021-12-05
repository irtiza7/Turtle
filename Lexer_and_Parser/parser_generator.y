%{

#include <stdio.h>
int yylex();
int yyerror(char *s);

%}

%token o_brace c_brace delimiter identifier assignment newline semicolon

%left '+''-'
%left '%''*''/'

%type <float> identifier
%token <num> int_n
%token <deci> float_n
%type <deci> expression
%token <name> keyword

%union{
	char name[20];
	char op;
    int num;
	float deci;
}

%%

stmts:
		
	| stmt semicolon stmts
	| stmt semicolon 
;
stmt: 
	keyword identifier assignment expression 	{ $2 = $4; }
	| identifier assignment expression 			{ $1 = $3; }
	| keyword o_brace expression c_brace 		{
		if (keyword == "print") {
			printf("%d\n", $3);
		}
	}
;
expression: 
	int_n '+' expression 	{ $$ = $1 + $3; }
	| int_n 				{ $$ = $1; }
	| float_n 				{ $$ = $1; }
	| identifier 			{ $$ = $1; }
;
%%

int yyerror(char *s) {
	printf("Syntax Error on line %s\n", s);
	return 0;
}
int main() {
    yyparse();
    return 0;
}