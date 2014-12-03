#!/bin/sh

# include main compilation parameters
# export prefix64=/usr/local
# export LD_LIBRARY_PATH=${prefix64}/lib

my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

${octave64src}/run-octave


