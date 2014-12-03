#!/bin/sh

# install check
# sudo apt-get install  bison flex cmake libqscintilla2-dev texlive

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

cd ${octave64src}

# copy modification of octave source code
cp -Rf ${libs64src_mods}/octave-src/* ./

#./configure CPPFLAGS="-I$SUITESPARSE/include -I$QHULL/include " LIBS="-L$SUITESPARSE/lib -lmetis -L$QHULL/lib -L$ARPACK/lib -larpack -L$LAPACK/lib -L$BLAS/lib -lblas -lgfortran -lm -lpthread" FFLAGS=-fdefault-integer-8 F77=gfortran --enable-64

# oct docu
# ./configure LIBS=${libs64} LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib" --enable-64

./configure --disable-doc --enable-64 LIBS="${libs64}" LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib"

# ./configure LIBS=${libs64} LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib" --enable-64 --disable-docs --enable-shared --enable-dl

# build and tets with thsi to check bounds --enable-bounds-check

make clean

make

# test compiled sources

make check
