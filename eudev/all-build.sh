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

__eudev()
{
	__cd eudev.git
	git pull

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr		\
	      --exec-prefix=		\
	      --sysconfdir=/etc		\
	      --enable-libkmod		\
	      --with-rootprefix=	\
	      --with-rootlibdir=/lib	\
	      --enable-legacylib

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#	__rem() {
	__eudev
}

__init-env
$@

