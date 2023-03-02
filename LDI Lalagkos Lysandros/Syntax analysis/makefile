Lalanguage: Test1.Lalanguage Test2.Lalanguage Test3.Lalanguage Test4.Lalanguage Test5.Lalanguage lexer.l Syntax.y
	bison -v -d Syntax.y
	flex lexer.l
	gcc Syntax.tab.c lex.yy.c -lm
	./a.exe Test1.Lalanguage > output1.txt
	./a.exe Test2.Lalanguage > output2.txt
	./a.exe Test3.Lalanguage > output3.txt
	./a.exe Test4.Lalanguage > output4.txt
	./a.exe Test5.Lalanguage > output5.txt
clean:
	rm -f parser.tab.* lex.yy.c Lalanguage