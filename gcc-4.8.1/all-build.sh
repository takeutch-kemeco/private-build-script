#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ./__common-func.sh

__gmp()
{
	__wget ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.2.tar.xz
	__dcd gmp-5.1.2

	$DIST_CLEAN
	__cfg --prefix=/usr --enable-cxx

	$MAKE_CLEAN
	__mk
	__mk install

	mkdir -v /usr/share/doc/gmp
	cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp

	ldconfig 
}

__mpfr()
{
	__wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.xz
	__dcd mpfr-3.1.2

	$DIST_CLEAN
	__cfg --prefix=/usr			\
	      --enable-thread-safe		\
	      --docdir=/usr/share/doc/mpfr

	$MAKE_CLEAN
	__mk
	__mk install

	__mk html
	__mk install-html

	ldconfig
}

__mpc()
{
	__wget http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz
	__dcd mpc-1.0.1

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	make install
	ldconfig
}

__gcc()
{
	__wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-4.8.1/gcc-4.8.1.tar.bz2
	__dcd gcc-4.8.1

	__cdbt

	../gcc-4.8.1/configure 		\
		--prefix=/usr 		\
		--libexecdir=/usr/lib	\
	        --enable-shared    	\
	        --enable-threads=posix	\
	        --enable-__cxa_atexit 	\
		--enable-c99		\
		--enable-long-long	\
	        --enable-clocale=gnu  	\
	        --enable-languages=c,c++,fortran \
	        --disable-multilib    	\
		--disable-libstdcxx-pch	\
		--enable-cloog-backend=isl \
	        --disable-bootstrap   	\
	        --with-system-zlib

	__mk
	__mk install

	rm /usr/lib/libstdc++.so.6.0.18-gdb.py
	ldconfig
}

__gdb()
{
	__wget http://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.bz2
	__dcd gdb-7.6

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-werror

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#__rem(){
__gmp
__mpfr
__mpc
__gcc
__gdb
}

$@

