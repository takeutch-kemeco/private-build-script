#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"

qemu()
{
	cd $BASE_DIR/qemu
	./configure --prefix=/usr \
		--disable-werror
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__test__(){

	exit
}
#__test__

qemu

