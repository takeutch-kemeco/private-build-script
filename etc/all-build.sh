#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__pcre() {
	cd $__BASE_DIR__/pcre
	./configure --prefix=$PREFIX \
		--libdir=/lib \
		--docdir=$PREFIX/share/doc/pcre-8 \
		--enable-utf8 \
		--enable-unicode-properties \
		--enable-pcregrep-libz \
		--enable-pcregrep-libbz2
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__popt() {
	cd $__BASE_DIR__/popt
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gc() {
	cd $__BASE_DIR__/gc
	./autogen.sh
	./configure --prefix=$PREFIX \
		--enable-cplusplus
	$MAKE_CLEAN
	make
	make install
	ldconfig

	install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3 &&
	ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3 
}

__nettle() {
	cd $__BASE_DIR__/nettle
	./configure --prefix=$PREFIX \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__tetex() {
	cd $__BASE_DIR__/tetex
}

__test__() {
###__tetex
	exit
}
#__test__

__pcre
__popt
__gc
__nettle

