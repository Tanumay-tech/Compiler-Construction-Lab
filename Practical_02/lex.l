%{
#include <stdio.h>
#include <string.h>

int comments = 0;
int keywords = 0;
int identifiers = 0;
int words = 0;
int lines = 0;
int spaces = 0;
%}

%%

"//".*                                                  { comments++; }
"/*"([^*]|(\*+[^*/]))*\*+"/"                            { comments++; }

"int"|"float"|"char"|"double"|"void"|"if"|"else"|"while"|"for"|"return"|"break"|"continue" { 
                                                            keywords++; 
                                                            words++; 
                                                        }

[a-zA-Z_][a-zA-Z0-9_]*                                  { 
                                                            identifiers++; 
                                                            words++; 
                                                        }

[ \t]+                                                  { spaces += yyleng; }
\n                                                      { lines++; }

[^ \t\n]+                                               { words++; }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *fp = fopen(argv[1], "r");
        if (fp) {
            yyin = fp;
        } else {
            printf("Error: Could not open file %s\n", argv[1]);
            return 1;
        }
    } else {
        printf("Please provide an input file name.\n");
        return 1;
    }

    yylex();

    printf("\n--- Lexical Analysis Report ---\n");
    printf("Comments    : %d\n", comments);
    printf("Keywords    : %d\n", keywords);
    printf("Identifiers : %d\n", identifiers);
    printf("Words       : %d\n", words);
    printf("Lines       : %d\n", lines);
    printf("Spaces      : %d\n", spaces);

    return 0;
}

int yywrap() {
    return 1;
}
