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
    __bld-common \
        --disable-docs \
        --without-cairo \
        --without-pango \
        --without-pangocairo \
        --without-gdk-pixbuf \
        --without-lensfun \
        --without-libjpeg \
        --without-libpng \
        --without-librsvg \
        --without-openexr \
        --without-sdl \
        --without-libopenraw \
        --without-jasper \
        --without-graphviz \
        --without-lua \
        --without-libavformat \
        --without-libv4l \
        --without-libspiro \
        --without-exiv2 \
        --without-umfpack
}

__gimp()
{
    __wget http://www.ring.gr.jp/pub/graphics/gimp/v2.8/gimp-2.8.10.tar.bz2
    __dcd gimp-2.8.10
    patch -p1 < ${BASE_DIR}/log_value_mode-gimp-2.8.10.patch
    __bld-common \
        --with-x \
        --with-shm=auto \
        --without-libtiff \
        --without-libjpeg \
        --without-bzip2 \
        --without-gs \
        --without-libpng \
        --without-libmng \
        --without-libexif \
        --without-aa \
        --without-libxpm \
        --without-webkit \
        --without-librsvg \
        --without-print \
        --without-poppler \
        --without-cairo-pdf \
        --without-gvfs \
        --without-libcurl \
        --without-wmf \
        --without-libjasper \
        --without-xmc \
        --without-alsa \
        --without-linux-input \
        --without-dbus \
        --without-gudev \
        --without-script-fu \
        --without-mac-twain \
        --without-xvfb-run \
        PYTHON=/usr/bin/python2
}

__all() {
    __babl
    __gegl
    __gimp
}

$@

