#!/bin/sh

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

mkdir ${libs64src}
cd ${libs64src_archives}
./_extract_src_from_archives.sh
cd ${my_dir}

rm -Rf ${octave64src}
mkdir ${octave64src}
tar xvf ${libs64src_archives}/octave-3.8.2.tar.gz -C ${octave64src}/..


