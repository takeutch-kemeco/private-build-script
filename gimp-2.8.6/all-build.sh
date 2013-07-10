#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

. ./__common-func.sh

__bld-common()
{
	$MAKE_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc $@ 

	__mk
	__mk install
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__babl()
{
	__wget ftp://ftp.gimp.org/pub/babl/0.1/babl-0.1.10.tar.bz2
	__decord babl-0.1.10
	__common babl-0.1.10
}

__gegl()
{
	__wget ftp://ftp.gimp.org/pub/gegl/0.2/gegl-0.2.0.tar.bz2
	__dcd gegl-0.2.0
	__bld-common --without-libavformat --disable-docs
}

__gimp()
{
	__wget ftp://ftp.gimp.org/pub/gimp/v2.8/gimp-2.8.6.tar.bz2
	__dcd gimp-2.8.6

	patch -p1 < ../log_value_mode-gimp-2.8.6.patch

	__bld-common --disable-python
}

__all() {
#rem() {
	__babl
	__gegl
	__gimp
}

$@

