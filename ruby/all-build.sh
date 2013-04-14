#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-shared

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__ruby()
{
	__common ruby
}

__all()
{
#	__rem() {
	__ruby
}

$@

