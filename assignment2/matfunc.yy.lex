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

    
 /************* End: add your definitions here */
%%
\n return *yytext;
 /* Start: add your rules here*/

REV yyval = "REV";return REV;
NEG yyval = "NEG";return NEG;
{number} yylval = (char*)malloc(sizeof(char)*MAXL);strcpy(yylval, yytext);return NUM;
. printf("%c",*yytext); 

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
