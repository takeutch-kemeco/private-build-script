#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

. ../common-func/__common-func-2.sh

DIST_CLEAN=""
#DIST_CLEAN="make distclean"

MAKE_CLEAN=""
#MAKE_CLEAN="make clean"

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
    __wget http://www.ring.gr.jp/pub/graphics/gimp/v2.8/gimp-2.8.10.tar.bz2
    __dcd gimp-2.8.10
    patch -p1 < ${BASE_DIR}/log_value_mode-gimp-2.8.10.patch
    __bld-common --without-alsa --without-gvfs --without-libjpeg PYTHON=/usr/bin/python2
}

__all() {
    __babl
    __gegl
    __gimp
}

$@

