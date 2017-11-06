#!/bin/bash

#cd ../../mnt/c/Users/dipsy/Desktop/course/COMP3031/assign2

bison -d matfunc.y
flex matfunc.lex
gcc *.c -o test -lm
./test testcase.txt
