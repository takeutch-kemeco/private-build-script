#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

. ./__common-func.sh

DIST_CLEAN=""
#DIST_CLEAN="make distclean"

#MAKE_CLEAN=""
MAKE_CLEAN="make clean"

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc $@ 

	$MAKE_CLEAN
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
	__bld-common --without-libavformat --without-libv4l --disable-docs --without-libjpeg
}

__gimp()
{
	__wget ftp://ftp.gimp.org/pub/gimp/v2.8/gimp-2.8.6.tar.bz2
	__dcd gimp-2.8.6
	patch -p1 < ../log_value_mode-gimp-2.8.6.patch
	__bld-common --disable-python --without-alsa --without-gvfs --without-libjpeg
}

__all() {
#rem() {
	__babl
	__gegl
	__gimp
}

$@

