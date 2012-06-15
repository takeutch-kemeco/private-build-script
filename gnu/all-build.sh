#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__libunistring() {
	cd $__BASE_DIR__/libunistring
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}
__guile()
{
	cd $__BASE_DIR__/guile
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gnutls() {
	cd $__BASE_DIR__/gnutls
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__test__() {
	exit
}
#__test__

__libunistring
__guile
__gnutls

