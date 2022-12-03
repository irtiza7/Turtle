compiler.exe: parser.tab.c parser.tab.h lex.yy.c
	gcc parser.tab.c -o compiler.exe
	rm parser.tab.c parser.tab.h lex.yy.c

parser.tab.c: parser.y
	bison -d parser.y

lex.yy.c:
	flex lexer.l

clean:
	rm parser.tab.c parser.tab.h lex.yy.c compiler.exe
