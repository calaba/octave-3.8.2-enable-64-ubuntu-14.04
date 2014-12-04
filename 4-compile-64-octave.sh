#!/bin/sh

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

# compile Octave src - 1st configure, then make and then make check

cd ${octave64src}

# copy modification of octave source code
cp -Rf ${libs64src_mods}/octave-src/* ./

# ./configure CPPFLAGS="-I$SUITESPARSE/include -I$QHULL/include " LIBS="-L$SUITESPARSE/lib -lmetis -L$QHULL/lib -L$ARPACK/lib -larpack -L$LAPACK/lib -L$BLAS/lib -lblas -lgfortran -lm -lpthread" FFLAGS=-fdefault-integer-8 F77=gfortran --enable-64
# ./configure LIBS=${libs64} LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib" --enable-64
# ./configure LIBS=${libs64} LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib" --enable-64 --disable-docs --enable-shared --enable-dl

./configure ${octave64_config_extra} --enable-64 LIBS="${libs64}" LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib"

# build 
make clean
make

# test compiled sources by executing internal chcecks
make check
