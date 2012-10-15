#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

PREFIX=/usr

DIST_CLEAN=
#DIST_CLEAN="make distclean"
MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__mpfr()
{
	__cd $BASE_DIR/mpfr

	$DIST_CLEAN
	$MAKE_CLEAN

	aclocal --force
	libtoolize --force
	automake -acf
	autoconf
	
	./configure --prefix=$PREFIX	\
		--enable-thread-safe	\
		--docdir=/usr/share/doc/mpfr

	__mk
	__mk install

	__mk html
	__mk install-html

	ldconfig
}

__gmp()
{
	__cd $BASE_DIR/gmp

	$DIST_CLEAN
	$MAKE_CLEAN

	./.bootstrap
	ABI="32" ./configure --prefix=$PREFIX \
		--enable-cxx		\
		--enable-mpbsd		\
		--enable-maintainer-mode

	__mk
	__mk install

	mkdir -v /usr/share/doc/gmp
	cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp

	ldconfig 
}

__mpc()
{
	__cd $BASE_DIR/mpc

	$DIST_CLEAN
	$MAKE_CLEAN

	aclocal --force -I m4
	libtoolize --force
	autoheader
	automake -acf
	autoconf

	./configure --prefix=$PREFIX

	__mk
	make install
	ldconfig
}

__gcc()
{
	__cdbt

	../gcc/autogen.sh
	../gcc/configure --prefix=$PREFIX \
		--libexecdir=/usr/lib	\
	        --enable-shared    	\
	        --enable-threads=posix	\
	        --enable-__cxa_atexit 	\
	        --enable-clocale=gnu  	\
	        --enable-languages=c,c++,fortran \
	        --disable-multilib    	\
	        --disable-bootstrap   	\
	        --with-system-zlib

	__mk
	__mk install
	ldconfig
}

__gdb()
{
	__cd $BASE_DIR/gdb

	$DIST_CLEAN
	$MAKE_CLEAN

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--disable-werror

	__mk
	__mk install
	ldconfig
}

#__rem(){
__gmp
__mpfr
__mpc
__gcc
__gdb

