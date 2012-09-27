#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

qemu()
{
	__cd $BASE_DIR/qemu
	./configure --prefix=/usr 	\
		--disable-werror	\
		--disable-kvm		\
		--disable-xen

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__test__(){

	exit
}
#__test__

qemu

