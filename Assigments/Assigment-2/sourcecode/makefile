all: gpp_lexer.l	
	@flex -o gpp_lexer.c gpp_lexer.l
	@gcc gpp_lexer.c -o gpp_lexer
	@./gpp_lexer
input:
	@./gpp_lexer example_input.txt