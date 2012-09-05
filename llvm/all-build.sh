#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="__mk clean"

#DIST_CLEAN=
DIST_CLEAN="__mk distclean"

. ../common-func/__common-func.sh

__llvm()
{
	__cd $BASE_DIR/llvm

	tar -xf ../clang-3.1.src.tar.gz -C tools &&
	mv tools/clang-3.1.src tools/clang

	CC=gcc \
	CXX=g++ \
	./configure --prefix=$PREFIX \
        	--libdir=$PREFIX/lib/llvm \
        	--sysconfdir=/etc \
        	--enable-shared \
        	--enable-libffi \
        	--enable-targets=all \
        	--disable-expensive-checks \
        	--disable-debug-runtime \
        	--disable-assertions \
        	--enable-optimized

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__llvm

