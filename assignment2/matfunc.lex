%option noyywrap

%{
#define YYSTYPE char*
#include "matfunc.tab.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXL 5000
#include <ctype.h>
void RmWs(char* str);

%}

ws [ \t]+
digits [0-9]
number [\-]?(0|([1-9]+{digits}*))
 /************* Start: add your definitions here*/
matrix (\[ *( *\[ *( *-?[0-9]+ *, *)* *-?[0-9]+ *\] *, *)*( *\[ *( *-?[0-9]+ *, *)* *-?[0-9]+ *\] *) *\])
    
 /************* End: add your definitions here */
%%
\n return *yytext;
 /* Start: add your rules here*/

REV yylval = "REV";printf("%s",yytext);return REV;
NEG yylval = "NEG";printf("%s",yytext);return NEG;
(\[ *( *\[ *( *-?[0-9]+ *, *)* *-?[0-9]+ *\] *, *)*( *\[ *( *-?[0-9]+ *, *)* *-?[0-9]+ *\] *) *\]) (char*)malloc(sizeof(char)*MAXL);strcpy(yylval, yytext);printf("%s",yytext);return MAT;
[+\-*\/] printf("%c",*yytext); return *yytext;
. if(*yytext==' '||*yytext=='\t'){REJECT;}else{ printf("missed:%c",*yytext);}

 /* End: add your rules here*/
{ws}
%%

void RmWs(char* str){
  int i=0,j=0;
  char temp[strlen(str)+1];
  double x,y;
  strcpy(temp,str);
  while (temp[i]!='\0'){
        while (temp[i]==' '||temp[i]=='\t'){i++;}
        str[j]=temp[i];
        i++; j++;
  }
 str[j]='\0';
}

