#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
#MAKE_CLEAN=
MAKE_CLEAN="make clean"
CFLAGS=""

build-zlib()
{
	cd $BASE_DIR/zlib
	CFLAGS='-mstackrealign -fPIC -O2' ./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install

	mv -v $PREFIX/lib/libz.so.* /lib
	ln -sfv /lib/libz.so.1 $PREFIX/lib/libz.so
	ldconfig

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
	./configure --prefix=$PREFIX --enable-cxx --enable-maintainer-mode ABI="32"
	$MAKE_CLEAN
	make
	make install
	ldconfig 
	cd $BASE_DIR
}

build-mpc()
{
	cd $BASE_DIR/mpc
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
	cd $BASE_DIR
}

build-gcc()
{
	rm -rf $BASE_DIR/build-gcc
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
		--without-system-zlib \
		--enable-lto

	make
	make install

	# ???
	rm $PREFIX/lib/libstdc++.so.*-gdb.py

	ldconfig
	cd $BASE_DIR
}

build-gdb()
{
	cd $BASE_DIR/gdb
	./configure --prefix=$PREFIX --disable-werror
	$MAKE_CLEAN
	make
	make install
	ldconfig
	cd $BASE_DIR
}

test() {
	exit
}
#test

build-zlib
build-gmp
build-mpfr
build-mpc
build-gcc
build-gdb

