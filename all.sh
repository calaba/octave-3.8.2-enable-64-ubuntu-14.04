#!/bin/sh

my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

echo "Installing required development tools & libraries ..."
./1-compile-install-prereq.sh > 1-compile-install-prereq.log 2>&1

cd ${octave64_gitroot}
echo "Unpacking source codes ..."
./2-compile-unpack-src.sh > 2-compile-unpack-src.log 2>&1

cd ${octave64_gitroot}
echo "Compiling required libraries with 64-bit indexing support ..."
TIME="\nExecution Time of Libraries Compilation: %E \n"
time ./3-compile-64-libs.sh > 3-compile-64-libs.log 2>&1

cd ${octave64_gitroot}
echo "Compiling Octave source code with 64-bit indexing support..."
TIME="\nExecution Time of Octave Compilation: %E \n"
time ./4-compile-64-octave.sh > 4-compile-64-octave.log 2>&1

cd ${octave64_gitroot}
read -p "Octave compilation & internal tests finished, press a key to run octave ..."
 
./5-run_64bit_octave.sh 

echo "Octave interactive test done."
echo "To install octave run: 'sudo make install' from ${octave64src} ..."
echo


