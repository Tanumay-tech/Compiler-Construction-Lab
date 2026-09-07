%{
#include <stdio.h>
#include <stdlib.h>
int yyerror(char *s);
int yylex();
%}

%token NUM
%token CHAR

%%
E : E '+' T | T ;
T : T '*' F | F ;
F : '(' E ')' | NUM ;
%%

int yyerror(char *s) {
    printf("Invalid Expression! !\n");
    exit(0);
}

int main() {
    printf("Enter an Expression: ");
    yyparse();
    printf("Valid Expression\n");
    return 0;
}
