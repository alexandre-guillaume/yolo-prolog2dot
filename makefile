all:
	bison -d pro2gra.y
	flex pro2gra.lex
	gcc -w -c  lex.yy.c -o lex.yy.o
	gcc -w -c pro2gra.tab.c -o pro2gra.tab.o
	gcc -o test lex.yy.o pro2gra.tab.o -ll -lm -lfl
clean:
	rm *o
