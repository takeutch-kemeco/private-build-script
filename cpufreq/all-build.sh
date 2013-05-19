#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__pciutils()
{
	git clone git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
	__cd pciutils

	$MAKE_CLEAN
	make PREFIX=/usr
	make PREFIX=/usr install

	install -v -m 755 -d /usr/include/pci
	install -v -m 644 lib/libpci.a /usr/lib
	install -v -m 644 lib/*.h /usr/include/pci
	ldconfig
}

__all()
{
#	__rem() {
	__pciutils
}

$@

