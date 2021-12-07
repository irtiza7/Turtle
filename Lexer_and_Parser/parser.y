%{

#include <stdio.h>
#include <stdlib.h>

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

%type <integer_value> expression
%type <float_value> compound_expression

%left plus_op minus_op
%left multiply_op division_op

%%

lines:
	    
	| lines line {printf("Line Parsed\n");}
;

line : newline
;
line : compound_expression newline 		{printf("Expression_evaluated_to: %f\n", $1);}
;
line : expression newline 				{printf("Expression_evaluated_to: %i\n", $1);}
;
line : assignment newline
;

line : if_kw open_brace condition close_brace condition_block newline
;
line : if_kw open_brace condition close_brace condition_block else_kw condition_block newline
;
line : if_kw open_brace condition close_brace condition_block elif_kw condition_block else_kw condition_block newline
;
line : if_kw open_brace condition close_brace condition_block elif_kw condition_block newline
;
line : function_definition function_block newline
;
line : function_call newline
;
line : print_kw open_brace expression close_brace newline
;
line : print_kw open_brace compound_expression close_brace newline
;
line : print_kw open_brace identifier close_brace newline
;

compound_expression : float_num                 		 						{ $$ = $1; }
;
compound_expression : compound_expression plus_op compound_expression	 		{ $$ = $1 + $3; }
;
compound_expression : compound_expression minus_op compound_expression	 		{ $$ = $1 - $3; }
;
compound_expression : compound_expression multiply_op compound_expression 		{ $$ = $1 * $3; }
;
compound_expression : compound_expression division_op compound_expression	 	{ $$ = $1 / $3; }
;
compound_expression : open_brace compound_expression close_brace		 		{ $$ = $2; }
;
compound_expression : expression plus_op compound_expression	 	 			{ $$ = $1 + $3; }
;
compound_expression : expression minus_op compound_expression	 	 			{ $$ = $1 - $3; }
;
compound_expression : expression multiply_op compound_expression 	 			{ $$ = $1 * $3; }
;
compound_expression : expression division_op compound_expression	 			{ $$ = $1 / $3; }
;
compound_expression : compound_expression plus_op expression	 	 			{ $$ = $1 + $3; }
;
compound_expression : compound_expression minus_op expression	 	 			{ $$ = $1 - $3; }
;
compound_expression : compound_expression multiply_op expression 	 			{ $$ = $1 * $3; }
;
compound_expression : compound_expression division_op expression	 			{ $$ = $1 / $3; }
;
compound_expression : expression division_op expression		 					{ $$ = $1 / (float)$3; }
;

expression : integer_num							{ $$ = $1; }
;
expression : expression plus_op expression			{ $$ = $1 + $3; }
;
expression : expression minus_op expression			{ $$ = $1 - $3; }
;
expression : expression multiply_op expression		{ $$ = $1 * $3; }
;
expression : open_brace expression close_brace		{ $$ = $2; }
;
expression : identifier plus_op expression			
;
expression : identifier minus_op expression			
;
expression : identifier multiply_op expression		
;
expression : identifier division_op expression		
;
expression : expression plus_op identifier			
;
expression : expression minus_op identifier			
;
expression : expression multiply_op identifier		
;
expression : expression division_op identifier		
;
expression : identifier plus_op identifier			
;
expression : identifier minus_op identifier			
;
expression : identifier multiply_op identifier		
;
expression : identifier division_op identifier		
;

assignment : var_kw identifier assignment_op integer_num
;
assignment : var_kw identifier assignment_op float_num
;
assignment : var_kw identifier assignment_op expression
;
assignment : var_kw identifier assignment_op compound_expression
;
assignment : identifier assignment_op integer_num
;
assignment : identifier assignment_op float_num
;
assignment : identifier assignment_op expression
;
assignment : identifier assignment_op compound_expression
;
assignment : var_kw identifier assignment_op identifier
;
assignment : identifier assignment_op identifier
;
assignment : var_kw identifier assignment_op bool_kw
;
assignment : identifier assignment_op bool_kw
;

condition : bool_kw
;
condition : expression
;
condition : compound_expression
;

condition_block : open_curly close_curly
;
condition_block : open_curly newline lines newline close_curly
;

function_definition : define_kw identifier open_brace close_brace
;

function_block : open_curly newline lines return_kw expression newline close_curly
;

function_call : identifier open_brace close_brace
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
