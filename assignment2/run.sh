#!/bin/bash

bison -d matfunc.y
#flex -o matfunc.lex.yy.c matfunc.lex
flex matfunc.lex
gcc *.c -o test -lm
./test testcase.txt
