#!/bin/sh
./1-compile-install-prereq.sh >& 1-compile-install-prereq.log
./2-compile-unpack-src.sh >& 2-compile-unpack-src.log
./3-compile-64-libs.sh >& 3-compile-64-libs.log
./4-compile-64-octave.sh >& 4-compile-64-octave.log
./5-run_64bit_octave.sh 
