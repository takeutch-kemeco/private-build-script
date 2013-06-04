#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}

MAKE_CLEAN="make clean"
DIST_CLEAN="make distclean"

. ./__common-func.sh

__wxWidgets()
{
	git clone git://github.com/wxWidgets/wxWidgets.git wxWidgets.git
	__cd wxWidgets.git
	git pull

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib \
	      --enable-stl --with-sdl --enable-compat26

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__wxmaxima()
{
	git clone git://github.com/andrejv/wxmaxima.git wxmaxima.git
	cd wxmaxima.git
	git pull

	./bootstrap

	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#__rem() {
	__wxWidgets
	__wxmaxima
}

$@

