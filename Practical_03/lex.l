%{
#include <stdio.h>
int count_a = 0;
int count_exp = 0;
%}

EXP       [0-9]*\.?[0-9]+[eE][+-]?[0-9]+
WORD_A    [aA][a-zA-Z]*
WORD      [a-zA-Z]+

%%

{EXP}       { count_exp++; }
{WORD_A}    { count_a++; }
{WORD}      { }
.|\n        { }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter your text:\n");

    yylex();

    printf("\n--- Results ---\n");
    printf("Words starting with 'a' or 'A' : %d\n", count_a);
    printf("Exponential numbers            : %d\n", count_exp);

    return 0;
}
