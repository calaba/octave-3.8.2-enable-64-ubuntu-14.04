#!/bin/sh

# it creates (overwrites) .so libraries in current directory from .a libraries

top=$(pwd)
for f in *.a; do
	mkdir tmp
	cd tmp
	ar vx ../$f
	gcc -shared -o ../${f%%.a}.so *.o
	cd $top
	rm -rf tmp
done
