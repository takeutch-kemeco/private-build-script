#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ./__common-func.sh

__llvm()
{
	__wget http://llvm.org/releases/3.2/llvm-3.2.src.tar.gz
	__wget http://llvm.org/releases/3.2/clang-3.2.src.tar.gz
	__wget http://llvm.org/releases/3.2/compiler-rt-3.2.src.tar.gz

	__dcd llvm-3.2.src
	tar -xf ${SRC_DIR}/clang-3.2.src.tar.gz -C tools
	tar -xf ${SRC_DIR}/compiler-rt-3.2.src.tar.gz -C projects

	mv tools/clang-3.2.src tools/clang
	mv projects/compiler-rt-3.2.src projects/compiler-rt

	sed -e "s@../lib/libprofile_rt.a@../lib/llvm/libprofile_rt.a@g" -i tools/clang/lib/Driver/Tools.cpp

	$DIST_CLEAN
	CC=gcc \
	CXX=g++ \
	./configure --prefix=/usr \
        	--libdir=/usr/lib/llvm \
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
	make -C docs -f Makefile.sphinx man
	__mk install

#	chmod -v 644 /usr/lib/llvm/*.a
#	echo /usr/lib/llvm >> /etc/ld.so.conf
	ldconfig

	install -m644 docs/_build/man/* /usr/share/man/man1
}

__all()
{
#__rem() {
	__llvm
}

$@

