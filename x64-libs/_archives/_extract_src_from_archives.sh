#!/bin/sh

my_dir=`pwd`

echo "Copying ARPACK ...\n"
rm -Rf ${my_dir}/../src/ARPACK
mkdir ${my_dir}/../src/ARPACK
cp -Rf ./ARPACK/ARPACK/* ../src/ARPACK

echo "Copying BLAS ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/BLAS
tar xvf ${my_dir}/blas*.tgz -C ${my_dir}/../src/
#mv ${my_dir}/../src/BLAS ${my_dir}/../src/BLAS

echo "Copying LAPACK ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/LAPACK
tar xvf ${my_dir}/lapack*.tgz -C ${my_dir}/../src/
mv ${my_dir}/../src/lapack-3.5.0 ${my_dir}/../src/LAPACK

echo "Copying GLPK ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/GLPK
tar xvf ${my_dir}/glpk*.tar.gz -C ${my_dir}/../src/
mv ${my_dir}/../src/glpk-4.55 ${my_dir}/../src/GLPK

echo "Copying SuiteSparse ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/SUITESPARSE
tar xvf ${my_dir}/SuiteSparse*.tar.gz -C ${my_dir}/../src/
mv ${my_dir}/../src/SuiteSparse ${my_dir}/../src/SUITESPARSE

echo "Copying Metis 4.0.3 under SuiteSparse as subdirectiry 'metis-4.0.1' ..."
cd ${my_dir}
rm -Rf ${my_dir}/../src/SUITESPARSE/metis-4.0.1
tar xvf ${my_dir}/metis-4.0.3.tar.gz -C ${my_dir}/../src/SUITESPARSE
mv ${my_dir}/../src/SUITESPARSE/metis-4.0.3 ${my_dir}/../src/SUITESPARSE/metis-4.0.1

echo "Copying QHULL ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/QHULL
tar xvf ${my_dir}/qhull*.tgz -C ${my_dir}/../src/
mv ${my_dir}/../src/qhull-2012.1 ${my_dir}/../src/QHULL

echo "Copying QRUPDATE ...\n"
cd ${my_dir}
rm -Rf ${my_dir}/../src/QRUPDATE
tar xvf ${my_dir}/qrupdate*.tar.gz -C ${my_dir}/../src/
mv ${my_dir}/../src/qrupdate-1.1.2 ${my_dir}/../src/QRUPDATE







