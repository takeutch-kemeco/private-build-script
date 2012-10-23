#!/bin/bash

BASE_DIR=$(pwd)

MAKE_CLEAN=
MAKE_CLEAN="make distclean && make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__gdl()
{
	__common $BASE_DIR/gdl
}

__libgda()
{
	__cd $BASE_DIR/libgda

	./autogen.sh
	./configure --prefix=/usr	\
            	--sysconfdir=/etc 	\
            	--enable-system-sqlite

	__mk
	__mk install
	ldconfig
}

__anjuta()
{
	__common $BASE_DIR/anjuta
}

#__rem() {
__gdl
__libgda
__anjuta

