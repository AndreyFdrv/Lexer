%{
#include<stdio.h>
#include<string.h>
int colno=1;
%}

%%
[\n] {colno=1;}
[ ] {colno=colno+1;}
[\t] {colno=colno+1;} 
[s][k][i][p] {printf("KW_Skip(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[:][=] {printf("Assignment(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[\;] {printf("Colon(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[w][r][i][t][e] {printf("KW_Write(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[r][e][a][d] {printf("KW_Read(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[w][h][i][l][e] {printf("KW_While(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[d][o] {printf("KW_Do(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[i][f] {printf("KW_If(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[t][h][e][n] {printf("KW_Then(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[e][l][s][e] {printf("KW_Else(%d, %d, %d); ", yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[a-zA-Z_][a-zA-Z_0-9]* {yytext [yyleng] = (char) 0;
printf("Var(\"%s\", %d, %d, %d); ", yytext, yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
([+|\-|*|/|%|>|<])|([=|\!][=])|([>|<][=])|([&][&])|([\|][\|]) {yytext [yyleng] = (char) 0; 
printf("Op(\"%s\", %d, %d, %d); ", yytext, yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
[1-9][0-9]* {yytext [yyleng] = (char) 0;
printf("Num(\"%s\", %d, %d, %d); ", yytext, yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
([\(])|([\)]) {yytext [yyleng] = (char) 0;
printf("Parenthesis(\"%s\", %d, %d, %d); ", yytext, yylineno, colno, colno-1+yyleng);
colno=colno+yyleng;}
%%

main(int argc,char *argv[])
{

yyin=fopen(argv[1],"r");

yylex();

}

