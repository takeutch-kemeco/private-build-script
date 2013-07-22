#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__ruby()
{
	__cd ruby
	__bld-common --localstatedir=/var --enable-shared
}

__all()
{
#	__rem() {
	__ruby
}

$@

