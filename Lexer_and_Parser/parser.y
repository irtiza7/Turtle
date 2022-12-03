%{

#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

%}

%union {
	int integer_value;
	float float_value;
}

%start lines

%token keyword
%token print_kw
%token if_kw
%token else_kw
%token elif_kw
%token define_kw
%token bool_kw
%token return_kw
%token null_kw
%token and_kw
%token or_kw
%token var_kw

%token identifier
%token newline

%token assignment_op
%token plus_op 
%token minus_op 
%token multiply_op 
%token division_op

%token open_brace
%token close_brace
%token open_curly
%token close_curly

%token <integer_value> integer_num
%token <float_value> float_num
%token string_literal

%left plus_op minus_op
%left multiply_op division_op

%%

lines:
	    
	| lines line {printf("Line Parsed\n");}
;

line : newline
;
line : var_kw identifier assignment_op integer_num
;
line : var_kw identifier assignment_op float_num
;
line : var_kw identifier assignment_op string_literal
;
line : print_kw open_brace integer_num close_brace
;
line : print_kw open_brace identifier close_brace
;
line : define_kw identifier open_brace identifier close_brace func_body
;
func_body :  open_curly var_kw identifier assignment_op integer_num close_curly
;
line : identifier open_brace identifier close_brace
;
line : identifier open_brace integer_num close_brace
;
line : identifier open_brace close_brace
;

%%

int main(int argc, char *argv[]) {
	// Reading the code file and giving it to lexer.
	yyin = fopen(argv[1], "r");

	yyparse();
	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Error! Type: %s\n", s);
	exit(1);
}
