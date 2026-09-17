%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER

%%

line:
    expr '\n'       { printf("Result = %d\n", $1); exit(0); }
  | '\n'            { exit(0); }
  ;

expr:
    expr expr '+'   { $$ = $1 + $2; }
  | expr expr '-'   { $$ = $1 - $2; }
  | expr expr '*'   { $$ = $1 * $2; }
  | expr expr '/'   { 
                      if ($2 == 0) {
                          printf("Error: Division by zero\n");
                          exit(1);
                      } else {
                          $$ = $1 / $2;
                      }
                    }
  | NUMBER          { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    printf("Invalid Postfix Expression!\n");
}

int main(void) {
    printf("Enter Postfix Expression (e.g. 5 3 4 * +):\n");
    yyparse();
    return 0;
}
