#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__nspr()
{
	__wget http://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.3/src/nspr-4.10.3.tar.gz
	__dcd nspr-4.10.3

	cd mozilla/nsprpub
	cd nspr
        sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in
        sed -i 's#$(LIBRARY) ##' config/rules.mk

        ./configure --prefix=/usr --with-mozilla --with-pthreads \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
        __mk
	__mkinst
}

__nss()
{
	__wget http://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_15_4_RTM/src/nss-3.15.4.tar.gz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/nss-3.15.4-standalone-1.patch
	__dcd nss-3.15.4

	patch -Np1 -i ../nss-3.15.4-standalone-1.patch
	cd nss

        patch -Np1 -i ../nss-3.15.4-standalone-1.patch &&
        cd nss &&
        make BUILD_OPT=1                      \
          NSPR_INCLUDE_DIR=/usr/include/nspr  \
          USE_SYSTEM_ZLIB=1                   \
          ZLIB_LIBS=-lz                       \
          $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
          $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1)

        cd ../dist                                                       &&
        install -v -m755 Linux*/lib/*.so              /usr/lib           &&
        install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib           &&
        install -v -m755 -d                           /usr/include/nss   &&
        cp -v -RL {public,private}/nss/*              /usr/include/nss   &&
        chmod -v 644                                  /usr/include/nss/* &&
        install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin &&
        install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig
}

__all()
{
#	__rem() {
	__nspr
	__nss
}

$@

