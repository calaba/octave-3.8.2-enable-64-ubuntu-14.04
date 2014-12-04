#!/bin/sh

# include main compilation parameters
my_dir="$(dirname "$0")"
. "$my_dir/compile-params.in"

# install required libs in order to be able to compile 64 bit indexing octave (experimental)
sudo apt-get update

# required libs
sudo apt-get -y install libqscintilla2-dev libpcre3 libpcre3-dev libfreetype6-dev
sudo apt-get -y install libreadline6 libreadline6-dev

# required libs - we should build and use our own
# sudo apt-get install libblas-dev liblapack-dev libqhull-dev libglpk-dev libqrupdate-dev libsuitesparse-dev libarpack2 libarpack2-dev

# java - also needs to set JAVA_HOME for configure script
sudo apt-get -y install default-jre openjdk-7-jdk
sudo apt-get -y install libxft-dev libgl2ps-dev

# libs if not present - WARNING is issued in Octave configure
sudo apt-get -y install gnuplot libhdf5-dev libfftw3-3 curl fontconfig
sudo apt-get -y install texinfo libfftw3-dev
sudo apt-get -y install libcurl4-gnutls-dev
sudo apt-get -y install libfltk1.3-dev
sudo apt-get -y install libfontconfig libfontconfig-dev

# libs - if not present - some functions are not enabled and make check skips some tests
sudo apt-get -y install libgraphicsmagick++1-dev llvm

# required compilation tools
sudo apt-get -y install pkg-config tcl-dev bison flex g++ gfortran cmake gperf 

# to be able to compile documentation
if [ "${octave64_config_extra}" =~ "--disable-docs" ]; then
    echo "Skipping installation of texlive, documentation won't be compiled ... "
else
    sudo apt-get -y install texlive
fi
