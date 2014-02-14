#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"
DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__vala()
{
    __git-clone git://git.gnome.org/vala
    __common vala
}

__babl()
{
    __git-clone git://git.gnome.org/babl
    __common babl
}

__gegl()
{
    __git-clone git://git.gnome.org/gegl
    __cd gegl
    __bld-common PYTHON=/usr/bin/python2
}

__gssdp()
{
    __git-clone git://git.gnome.org/gssdp
    __common gssdp
}

__gnpnp-av()
{
    __git-clone git://git.gnome.org/gupnp-av
    __common gnpnp-av
}

__gnpnp-dlna()
{
    __git-clone git://git.gnome.org/gupnp-dlna
    __common gnpnp-dlna
}

__gnpnp-vala()
{
    __git-clone git://git.gnome.org/gupnp-vala
    __common gnpnp-vala
}

__gnpnp()
{
    __git-clone git://git.gnome.org/gupnp
    __common gnpnp
}

__exiv2()
{
    __svn-clone svn://dev.exiv2.org/svn/trunk exiv2
    __cd exiv2
    ./bootstrap.linux
    __mk configure
    __mk
    __mkinst
}

__gexiv2()
{
    __wget http://ftp.gnome.org/pub/gnome/sources/gexiv2/0.7/gexiv2-0.7.0.tar.xz
    __dcd gexiv2-0.7.0
    __bld-common
}

__gimp()
{
    __git-clone git://git.gnome.org/gimp
    __cd gimp
    __bld-common --without-script-fu --disable-python PYTHON=/usr/bin/python2
}

__all()
{
    __vala
    __gssdp
    __gupnp
    __gupnp-av
    __gupnp-dlna
    __gupnp-vala
    __babl
    __gegl
    __gexiv2
    __gimp
}

$@

