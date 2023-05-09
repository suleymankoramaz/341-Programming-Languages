all:
	yacc -d gpp_interpreter.y -o gpp_interpreter.c
	lex -o gpp_lexer.c gpp_lexer.l
	cc -g gpp_lexer.c gpp_interpreter.c -o gpp_interpreter.out
	./gpp_interpreter.out