// Authors: Emilio Segoiva, Krishna Pakalapati
// CS152, Phase 2

%{
    #include <heading.H>
%}

%union {
    // define types and names of the components of YYSTYPE, which is the type of yylval and of the semantic portion of parse-stack entries.
    
    // declarations of union members for lexical values of tokens
    int         junk;       // value for single-lexeme tokens
    string*     ident;      // points to identifiers' actual lexemes
    
    // declarations of union members lexical values of non-terminals,
    // which are pointers to translation records
    Program*    program;    // for the non-terminal "Program"
}

// Here is the start symbol fo the grammar.
%start                      Program

// Here we specify non-terminals symbols and which components of the union YYSTYPE their translation records will occupy.
//      _member_            _non-terminal_
%type   <program>           Program

// Here, in order of increasing precedende, are the names of tokens, their associativity, and which components of the union 
// YYSTYPE their lexical values will occupy

//_assoc_       _member_        _tokens_
%nonassoc       <junk>          LO

%% //end of symbol specifications

// Here are the grammar rules and their associated tree-building actions.

Program
    : MainClass     ClassDeclSeq
    
MainClass   :
CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']'ID ')' '{' stmt '}' '}'
{$$=new Mainclass ($1, $2, $3, $4, $5, $6);}

%% //end of rules

// Here are the definitions of yyerror, the function that reports lexical and parse errors.
int yyerror( strings s) {
    extern int yylineno;
    extern char* yytext;
    cerr << "ERROR: " + s + " at symbol " + yytext + " on line ";
    cerr << yylineno << endl;
    exit(1);
}

int yyerror(char* s) { return yyerror( string(s) ); }