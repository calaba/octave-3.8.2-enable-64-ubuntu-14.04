#!/bin/sh

./1-compile-install-prereq.sh &> 1-compile-install-prereq.log

./2-compile-unpack-src.sh &> 2-compile-unpack-src.log

TIME="\nExecution Time of Libraries Compilation: %E \n"
time ./3-compile-64-libs.sh &> 3-compile-64-libs.log

TIME="\nExecution Time of Octave Compilation: %E \n"
time ./4-compile-64-octave.sh &> 4-compile-64-octave.log

./5-run_64bit_octave.sh 
