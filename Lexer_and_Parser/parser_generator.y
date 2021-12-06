%{

#include <stdio.h>
int yylex();
int yyerror(char *s);

%}

%start statements

%token o_brace 
%token c_brace
%token o_curly
%token c_curly

%token delimiter
%token assignment 

%token <oper> operator
%token <name> keyword
%token <name> identifier
%token <integer> int_n
%token <decimal> float_n

%type <decimal> expression

%left '+''-'
%left '%''*''/'

%union{
	char name[20];
	char oper;
    int integer;
	float decimal;
}

%%

statements: statement 
;
statements: statement statements 
;

statement: keyword identifier assignment expression 	{ $2 = $4; }
;
statement: identifier assignment expression 			{ $1 = $3; }
;
statement: keyword o_brace expression c_brace 			{ 
															if (keyword == "print") { 
																printf("%d\n", $3); 
															}
														}
;

expression: int_n '+' expression 	{ $$ = $1 + $3; }
;
expression:	int_n 					{ $$ = $1; }
;
expression:	float_n 				{ $$ = $1; }
;
expression:	identifier 				{ $$ = $1; }
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