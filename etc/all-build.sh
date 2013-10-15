#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__libarchive()
{
	__wget http://www.libarchive.org/downloads/libarchive-3.1.2.tar.gz
	__dcd libarchive-3.1.2
	__bld-common
}

__cmake()
{
	__wget http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
	__dcd cmake-2.8.11.2
	./bootstrap
	__bld-common-simple --system-libs --mandir=/share/man --docdir=/share/doc/cmake-2.8.11.2
}

__talloc()
{
	__wget ftp://samba.org/pub/talloc/talloc-2.0.8.tar.gz
	__dcd talloc-2.0.8
	__bld_common
}

__popt()
{
	__wget http://rpm5.org/files/popt/popt-1.16.tar.gz
	__dcd popt-1.16
	__bld-common
}

__gc()
{
	__wget http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc-7.2d.tar.gz
	__dcd gc-7.2
	__bld-common --enable-cplusplus --docdir=/usr/share/doc/gc-7.2

	install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3
	ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3
}

__nettle()
{
	__wget ftp://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz
	__dcd nettle-2.7.1
	__bld-common

	chmod -v 755 /usr/lib/libhogweed.so.2.5 /usr/lib/libnettle.so.4.7
	install -v -m755 -d /usr/share/doc/nettle-2.7.1
	install -v -m644 nettle.html /usr/share/doc/nettle-2.7.1
}

__tetex() {
	echo
}

__tomoyo-tools()
{
	__cd tomoyo-tools
	__mk USRLIBDIR=/lib
	__mk USRLIBDIR=/lib install
}

__freeglut()
{
	__wget http://downloads.sourceforge.net/freeglut/freeglut-2.8.1.tar.gz
	__dcd freeglut-2.8.1
	__bld-common
}

__sudo()
{
	__wget ftp://ftp.twaren.net/Unix/Security/Sudo/sudo-1.8.7.tar.gz
	__dcd sudo-1.8.7
	__bld-common-simple --libexecdir=/usr/lib/sudo --docdir=/usr/share/doc/sudo --with-all-insults \
                            --with-env-editor --with-pam --without-sendmail

cat > /etc/pam.d/sudo << "EOF" &&
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF

	chmod 644 /etc/pam.d/sudo
}

__curl()
{
	__wget http://curl.haxx.se/download/curl-7.31.0.tar.bz2
	__dcd curl-7.31.0
	__bld-common --enable-threaded-resolver --with-ca-path=/etc/ssl/certs

	find docs \( -name "Makefile*" -o -name "*.1" -o -name "*.3" \) -exec rm {} \;
	install -v -d -m755 /usr/share/doc/curl-7.31.0
	cp -v -R docs/* /usr/share/doc/curl-7.31.0
}

__all()
{
#__rem(){
__livarchive
__cmake
__talloc
__popt
__gc
__nettle
__tetex
__tomoyo-tools
__freeglut
__sudo
__curl
}

$@

