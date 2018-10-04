/*
 * Emilio Segovia, Krishna Pakalapati
 * CS152 Project Phase 1
 * Description: A lexical scanner for the MINI-L language
*/

%{
	int curLine = 1, curPos = 1;
%}

DIGIT		[0-9]
ALPHA		[a-zA-Z]
ALPHANUM	[{ALPHA}{DIGIT}]

%%
"function"	{printf("FUNCTION"); curPos += yyleng;}
"beginparams"	{printf("BEGIN_PARAMS"); curPos += yyleng;}
"endparams"	{printf("END_PARAMS"); curPos += yyleng;}
"beginlocals"	{printf("BEGIN_LOCALS"); curPos += yyleng;}
"endlocals"	{printf("END_LOCALS"); curPos += yyleng;}
"beginbody"	{printf("BEGIN_BODY"); curPos += yyleng;}
"endbody"	{printf("END_BODY"); curPos += yyleng;}
"integer"	{printf("INTEGER"); curPos += yyleng;}
"array"		{printf("ARRAY"); curPos += yylen
%%

main(int argc, char** argv)
{
	yyin = fopen(argv[1], "r");
	if (yyin != NULL) {
		yyin = stdin;
	}
	yylex();
	printf("done");
}
