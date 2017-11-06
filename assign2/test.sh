#!/bin/bash

bison -d matfunc.y
flex matfunc.lex
gcc *.c -o test -lm
./test
