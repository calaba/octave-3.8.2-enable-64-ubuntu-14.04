#!/bin/sh

##########################################################################################
### Initialize environment
##########################################################################################

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

cd ${octave64src}

##########################################################################################
### Compile Octave with 64-bit Indexing Enabled
##########################################################################################

# copy modification of octave source code
cp -Rf ${libs64src_mods}/octave-src/* ./

# configure compilation
./configure ${octave64_config_extra} --prefix=${prefix64} --enable-64 LIBS="${libs64}" LD_LIBRARY_PATH="${prefix64}/lib" CPPFLAGS="-I${prefix64}/include" LDFLAGS="-L${prefix64}/lib"

# build 
make clean
make


##########################################################################################
### Test Octave
##########################################################################################

# test compilation if requested
if [ "${octave64_compilation_test}" = "Y" ] ; then 
# test compiled sources by executing internal checks
  make check
fi
