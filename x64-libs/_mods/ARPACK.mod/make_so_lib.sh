#!/bin/sh
mkdir tmp 
cd tmp 
ar x $1/lib/libarpack.a 
gcc -shared -o $1/lib/libarpack.so *.o -L$1/lib -llapack -lblas 
cd .. 
rm -Rf tmp 
