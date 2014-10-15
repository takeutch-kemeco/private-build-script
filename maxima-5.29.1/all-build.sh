#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__libsigsegv()
{
	__wget ftp://ftp.gnu.org/pub/gnu/libsigsegv/libsigsegv-2.10.tar.gz
	__common libsigsegv-2.10
}

__clisp()
{
###	__wget ftp://ftp.gnu.org/pub/gnu/clisp/release/2.49/clisp-2.49.tar.bz2
###	__dcd clisp-2.49

	hg clone http://clisp.hg.sourceforge.net/hgweb/clisp/clisp/
	__cd clisp

	$DIST_CLEAN
	mkdir b
	cd b
	FORCE_UNSAFE_CONFIGURE=1 ../configure --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__maxima()
{
	__wget http://downloads.sourceforge.net/project/maxima/Maxima-source/5.34.1-source/maxima-5.34.1.tar.gz
	__common maxima-5.34.1
}

__all()
{
#	__rem() {
	__libsigsegv
	__clisp
	__maxima
}

$@

