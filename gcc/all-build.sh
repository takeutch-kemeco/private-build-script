#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

build-zlib()
{
	cd zlib-1.2.5
	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	cd $BASE_DIR
}

build-mpfr()
{
	cd mpfr
	aclocal
	libtoolize
	automake -a -c -f
	autoconf
	./configure --prefix=$PREFIX --enable-thread-safe
#	make clean
	make
	make install
	ldconfig
	cd $BASE_DIR
}

build-gmp()
{
	cd gmp
	./.bootstrap
	./configure --prefix=$PREFIX --enable-cxx --enable-maintainer-mode
#	make clean
	make
	make install
	ldconfig 
	cd $BASE_DIR
}

build-mpc()
{
	cd mpc
	aclocal
	libtoolize
	autoheader
	automake -a -c -f
	autoconf
	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig
	cd $BASE_DIR
}

build-gcc()
{
	mkdir -p build-gcc
	cd build-gcc
	../gcc/configure \
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
#	make clean
	make
	make install

	# ???
	rm $PREFIX/lib/libstdc++.so.6.0.17-gdb.py

	ldconfig
	cd $BASE_DIR
}

build-zlib
build-gmp
build-mpfr
build-mpc
build-gcc

