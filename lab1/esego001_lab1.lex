/* Author: Emilio Segovia */

%{
	#include <iostream>
	int currLine = 1, currPos = 1, intCt = 0, opCt = 0, parCt = 0, eqCt = 0, decCt = 0;
%}

letter		[a-zA-z]
digit		[0-9]
number		{digit}+
identifier 	{letter}({letter}|{digit}|[_](letter|digit))*
decimal		{digit}*[.]{digit}+

%%

"-"			{printf("MINUS\n"); currPos += yyleng; opCt++;}
"+"			{printf("PLUS\n"); currPos += yyleng; opCt++;}
"*"			{printf("MULT\n"); currPos += yyleng; opCt++;}
"/"			{printf("DIV\n"); currPos += yyleng; opCt++;}
"="			{printf("EQUAL\n"); currPos += yyleng; eqCt++;}
"("			{printf("L_PAREN\n"); currPos += yyleng; parCt++;}
")"			{printf("R_PAREN\n"); currPos += yyleng; parCt++;}

({number}|{decimal})[eE][+-]?{digit}+	{printf("SCIENTIFIC %s\n", yytext); currPos += yyleng; decCt++;}
{decimal}	{printf("DECIMAL %s\n", yytext); currPos += yyleng; decCt++;}
{number}		{printf("NUMBER %s\n", yytext); currPos += yyleng; intCt++;}
[ \t]+			{currPos += yyleng;}
"\n"			{currLine++; currPos = 1;}
.			{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
	FILE *fh;
	if (argc == 2 && (fh = fopen(argv[1], "r")));
		yyin = fh;
	yylex();

	printf("\nCounts:\n");
	printf("Integers: %d\n", intCt);
	printf("Decimals: %d\n", decCt);
	printf("Operators: %d\n", opCt);
	printf("Parenthesis: %d\n", parCt);
	printf("Equal Signs: %d\n", eqCt);

	return 0;
}
