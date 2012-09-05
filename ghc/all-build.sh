#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

. ../common-func/__common-func.sh

__lapack()
{
	__cd $BASE_DIR/lapack

	cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .

	__mk
	__mk install

	__cd $BASE_DIR/lapack/SRC/CMakeFiles/lapack.dir
	gcc --shared -o liblapack.so *.o
	cp liblapack.so $PREFIX/lib/

	__cd $BASE_DIR/lapack/BLAS/SRC/CMakeFiles/blas.dir
	gcc --shared -o libblas.so *.o
	cp libblas.so $PREFIX/lib/

	ldconfig
}

__lapack

