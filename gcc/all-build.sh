#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
MAKE_CLEAN=
#MAKE_CLEAN="make clean"

build-zlib()
{
	cd $BASE_DIR/zlib-1.2.5
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	cd $BASE_DIR
}

build-mpfr()
{
	cd $BASE_DIR/mpfr
	aclocal
	libtoolize
	automake -a -c -f
	autoconf
	./configure --prefix=$PREFIX --enable-thread-safe
	$MAKE_CLEAN
	make
	make install
	ldconfig
	cd $BASE_DIR
}

build-gmp()
{
	cd $BASE_DIR/gmp
	./.bootstrap
	./configure --prefix=$PREFIX --enable-cxx --enable-maintainer-mode
	$MAKE_CLEAN
	make
	make install
	ldconfig 
	cd $BASE_DIR
}

build-mpc()
{
	cd $BASE_DIR/mpc
	aclocal
	libtoolize
	autoheader
	automake -a -c -f
	autoconf
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
	cd $BASE_DIR
}

build-gcc()
{
	mkdir -p $BASE_DIR/build-gcc
	cd $BASE_DIR/build-gcc
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
	$MAKE_CLEAN
	make
	make install

	# ???
###	rm $PREFIX/lib/libstdc++.so.*-gdb.py

	ldconfig
	cd $BASE_DIR
}

build-gdb()
{
	cd $BASE_DIR/gdb
	../configure --prefix=$PREFIX --disable-werror
	$MAKE_CLEAN
	make
	make install
	ldconfig
	cd $BASE_DIR
}

build-zlib
build-gmp
build-mpfr
build-mpc
build-gcc
build-gdb

