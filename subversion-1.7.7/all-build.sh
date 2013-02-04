#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__init-env()
{
	echo
}

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__sqlite3()
{
	__wget http://sqlite.org/sqlite-autoconf-3071502.tar.gz
	__wget http://sqlite.org/sqlite-doc-3071502.zip
	__dcd sqlite-autoconf-3071502

	unzip -q ${SRC_DIR}/sqlite-doc-3071502.zip

	$DIST_CLEAN
	./configure --prefix=/usr \
        	CFLAGS="-g -O2 -DSQLITE_ENABLE_FTS3=1 \
            		-DSQLITE_ENABLE_COLUMN_METADATA=1     \
            		-DSQLITE_ENABLE_UNLOCK_NOTIFY=1       \
            		-DSQLITE_SECURE_DELETE=1"

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/doc/sqlite-3.7.15.2
	cp -v -R sqlite-doc-3071502/* /usr/share/doc/sqlite-3.7.15.2
}

__subversion()
{
	__wget http://archive.apache.org/dist/subversion/subversion-1.7.7.tar.bz2
	__dcd subversion-1.7.7

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	install -v -m755 -d /usr/share/doc/subversion-1.7.7
	cp      -v -R       doc/* /usr/share/doc/subversion-1.7.7

	ldconfig
}

__apr()
{
	__wget ftp://ftp.mirrorservice.org/sites/ftp.apache.org/apr/apr-1.4.6.tar.bz2
	__dcd apr-1.4.6
	__bld-common --with-installbuilddir=/usr/share/apr-1/build
}

__openssl()
{
	__wget http://www.openssl.org/source/openssl-1.0.1c.tar.gz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.1c-fix_manpages-1.patch
	__dcd openssl-1.0.1c

	patch -Np1 -i ${SRC_DIR}/openssl-1.0.1c-fix_manpages-1.patch

	$DIST_CLEAN
	./config --prefix=/usr zlib-dynamic --openssldir=/etc/ssl shared

	$MAKE_CLEAN
	__mk -j1
	sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
	__mk -j1 MANDIR=/usr/share/man install
	install -v -d -m755 /usr/share/doc/openssl-1.0.1c
	cp -v -r doc/*      /usr/share/doc/openssl-1.0.1c

	ldconfig
}

__apr-util()
{
	__wget ftp://ftp.mirrorservice.org/sites/ftp.apache.org/apr/apr-util-1.5.1.tar.bz2
	__dcd apr-util-1.5.1
	__bld-common --with-apr=/usr --with-gdbm=/usr --with-openssl=/usr --with-crypto
}

__neon()
{
	__wget http://www.webdav.org/neon/neon-0.29.6.tar.gz
	__dcd neon-0.29.6
	__bld-common --enable-shared --with-ssl=openssl --with-libxml2 --with-expat
}

__package-apr()
{
#__rem() {
	__apr
	__openssl
	__apr-util
}

__all()
{
#__rem() {
	__sqlite3
	__package-apr
	__neon
	__subversion
}

__init-env
$@

