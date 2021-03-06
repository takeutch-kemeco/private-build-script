#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__init-env()
{
	echo
}

__geany()
{
	__cd geany

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
# __rem() {
	__geany
}

__init-env
$@

