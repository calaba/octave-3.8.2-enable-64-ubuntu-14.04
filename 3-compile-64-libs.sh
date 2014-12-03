#!/bin/sh

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

# make lib directory - otherwise lib compilation creates lib file instead of files within lib directory
mkdir ${LD_LIBRARY_PATH}

# pre-compile 64bit indexing for libs
cd ${libs64src}

# BLAS
cp -Rf ${libs64src_mods}/BLAS.mod/* BLAS/
cd BLAS
# make clean
make
cd ..

# LAPACK
cp -Rf ${libs64src_mods}/LAPACK.mod/* LAPACK/
cp -f ./BLAS/blas_LINUX.a ./LAPACK/libblas.a
cd LAPACK
# make clean
make
cd ..

# copy BLAS & LAPACK to LIB directory
cp -f LAPACK/*.a ${prefix64}/lib

# ARPACK
cp -Rf ${libs64src_mods}/ARPACK.mod/* ARPACK/
cd ARPACK
make lib
./make_so_lib.sh
cp -f libarpack.a ${prefix64}/lib
cp -f libarpack.so ${prefix64}/lib
cd ..

# QRUPDATE
cp -Rf ${libs64src_mods}/QRUPDATE.mod/* QRUPDATE/
cd QRUPDATE
make solib
sudo make install
cd ..

# SUITESPARSE
cp -Rf ${libs64src_mods}/SUITESPARSE.mod/* SUITESPARSE/
cd SUITESPARSE
make
make library
# new version has already "make install" 
sudo make install 
cd ..

# QHULL
cp -Rf ${libs64src_mods}/QHULL.mod/* QHULL/
cd QHULL
make
sudo make install
cd ..

#  GLPK
# no GLPK modifications
# cp -Rf ${libs64src_mods}/GLPK.mod/* GLPK/
cd GLPK
./configure prefix=${prefix64}
make
sudo make install
cd ..

# end of libs
cd ../..


