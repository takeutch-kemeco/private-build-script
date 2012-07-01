#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
#DIST_CLEAN=
DIST_CLEAN="make distclean"
#MAKE_CLEAN=
MAKE_CLEAN="make clean"
#CFLAGS=""

__cd()
{
	echo "------------------------------"
	echo $1
	echo "------------------------------"

	cd $1
	$DIST_CLEAN
}

build-zlib()
{
	__cd $BASE_DIR/zlib

	CFLAGS='-mstackrealign -fPIC -O4' ./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install

	mv -v $PREFIX/lib/libz.so.* /lib
	ln -sfv /lib/libz.so.1 $PREFIX/lib/libz.so
	ldconfig
}

build-mpfr()
{
	__cd $BASE_DIR/mpfr

	aclocal
	libtoolize
	automake -a -c -f
	autoconf
	./configure --prefix=$PREFIX --enable-thread-safe
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

build-gmp()
{
	__cd $BASE_DIR/gmp

	./.bootstrap
	./configure --prefix=$PREFIX --enable-cxx --enable-maintainer-mode ABI="32"
	$MAKE_CLEAN
	make
	make install
	ldconfig 
}

build-mpc()
{
	__cd $BASE_DIR/mpc

	aclocal --install -I m4
	libtoolize --force
	autoheader
	automake -acf
	autoconf

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

build-gcc()
{
	rm -rf $BASE_DIR/build-gcc
	mkdir -p $BASE_DIR/build-gcc

	__cd $BASE_DIR/build-gcc

	$BASE_DIR/gcc/configure \
		--prefix=$PREFIX \
		--libexecdir=$PREFIX/lib \
		--enable-shared \
		--enable-threads=posix \
		--enable-__cxa_atexit \
		--enable-clocale=gnu \
		--enable-languages=c,c++ \
		--disable-multilib \
		--disable-bootstrap \
		--with-system-zlib
#		--enable-lto

	make
	make install

	# ???
#	rm $PREFIX/lib/libstdc++.so.*-gdb.py

	ldconfig
	cd $BASE_DIR
}

build-gdb()
{
	__cd $BASE_DIR/gdb

	./configure --prefix=$PREFIX --disable-werror
	$MAKE_CLEAN
	make
	make install
	ldconfig
	cd $BASE_DIR
}

test()
{
build-gcc
	exit
}
test

build-zlib
build-gmp
build-mpfr
build-mpc
build-gcc
build-gdb

