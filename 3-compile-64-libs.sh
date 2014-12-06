#!/bin/sh

#######################################################################################
### Initialization of the environment
#######################################################################################

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

# make lib directory - otherwise lib compilation creates lib file instead of files within lib directory
mkdir ${LD_LIBRARY_PATH}

# pre-compile 64bit indexing for libs
cd ${libs64src}

#######################################################################################
# BLAS
#######################################################################################
cp -Rf ${libs64src_mods}/BLAS.mod/* BLAS/
cd BLAS
# make clean
make
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
cd ..

#######################################################################################
# LAPACK
#######################################################################################
cp -Rf ${libs64src_mods}/LAPACK.mod/* LAPACK/
cp -f ./BLAS/blas_LINUX.a ./LAPACK/libblas.a
cd LAPACK
# make clean
make
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
cd ..

#######################################################################################
# BLAS & LAPACK - installation
#######################################################################################
#  copy BLAS & LAPACK to LIB directory
cp -f LAPACK/*.a ${prefix64}/lib

#######################################################################################
# ARPACK
#######################################################################################
cp -Rf ${libs64src_mods}/ARPACK.mod/* ARPACK/
cd ARPACK
make lib prefix64=${prefix64}
./make_so_lib.sh
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
# Installation - might not be enough for ./configure to see ARPACK !
cp -f libarpack.a ${prefix64}/lib
cp -f libarpack.so ${prefix64}/lib
cd ..

################################################################################$
# QRUPDATE
################################################################################$
cp -Rf ${libs64src_mods}/QRUPDATE.mod/* QRUPDATE/
cd QRUPDATE
make lib solib prefix64=${prefix64} libs64=${libs64}
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  make test prefix64=${prefix64} libs64=${libs64}
fi
# Installation
sudo make install prefix64=${prefix64} libs64=${libs64}
cd ..

#######################################################################################
# SUITESPARSE
#######################################################################################
cp -Rf ${libs64src_mods}/SUITESPARSE.mod/* SUITESPARSE/
cd SUITESPARSE
make
make library
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
# new version has already "make install" 
sudo make install 
cd ..

#######################################################################################
# QHULL
#######################################################################################
cp -Rf ${libs64src_mods}/QHULL.mod/* QHULL/
cd QHULL
make
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
# Installation
sudo make install
cd ..

#######################################################################################
#  GLPK
#######################################################################################
# no GLPK modifications
# cp -Rf ${libs64src_mods}/GLPK.mod/* GLPK/
cd GLPK
./configure prefix=${prefix64}
make
# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# add library compilation test here - if supported
  echo
fi
# Installation
sudo make install
cd ..

#######################################################################################
# end of libs
#######################################################################################
cd ../..

