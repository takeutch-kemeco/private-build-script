#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__attr()
{
    __dep ""

    __git-clone git://git.savannah.nongnu.org/attr.git
    __cd attr
    __bld-common INSTALL_USER=root INSTALL_GROUP=root
}

__acl()
{
    __dep attr

    __git-clone git://git.savannah.nongnu.org/acl.git
    __cd acl
    __bld-common INSTALL_USER=root INSTALL_GROUP=root
}

__coreutils-git()
{
    __dep acl

    __git-clone git://git.savannah.gnu.org/coreutils.git
    __common coreutils
}

__coreutils-8.22()
{
    __dep acl

    __wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.22.tar.xz
    __dcd coreutils-8.22
    __bld-common
}

__coreutils()
{
    __coreutils-8.22
}

__gettext-0.18.3.2()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/gettext/gettext-0.18.3.2.tar.gz
    __dcd gettext-0.18.3.2
    __bld-common
}

__gettext()
{
    __gettext-0.18.3.2
}

__libcap()
{
    __dep attr linux-pam

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/morgan/libcap.git
    __cd libcap
    __mkinst prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
}

__libffi()
{
    __dep ""

    __git-clone https://github.com/atgreen/libffi.git
    __common libffi
}

__pcre-8.34()
{
    __dep ""

     __wget http://downloads.sourceforge.net/pcre/pcre-8.34.tar.bz2
     __dcd  pcre-8.34
     __bld-common --docdir=/usr/share/doc/pcre-8.34 --enable-unicode-properties \
                  --enable-pcre16 --enable-pcre32 \
                  --enable-pcregrep-libz --enable-pcregrep-libbz2 \
                  --enable-pcretest-libreadline
}

__pcre()
{
    __pcre-8.34
}

__python-2.7.6()
{
    __dep expat libffi
}

$@

