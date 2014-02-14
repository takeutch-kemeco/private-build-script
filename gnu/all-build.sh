#!/bin/bash

BASE_DIR=$(pwd)

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__patch()
{
    __cd patch
    ./bootstrup
    __bld-common
}

__libunistring()
{
    __common libunistring
}

__guile()
{
    __common guile
}

__libidn()
{
    __common libidn
}

__gnutls()
{
    __common gnutls
}

### memo ###
# configure.ac の doc 項目を削除して autoconf した configureを使えばエラーが出ない。
# (tex環境が万全でない場合)
# だが、エラーが出てもマニュアルもビルドに失敗してるだけなので、make install は通る。気にしなくていい。
__gperf() {
    __cd gperf
    cp configure.ac configure.ac.old

echo "diff --git a/configure.ac b/configure.ac
index 5fb4099..0315a6a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,7 +27,7 @@ AC_PROG_MAKE_SET
 AC_OBJEXT
 AC_EXEEXT
 
-AC_CONFIG_SUBDIRS([lib src tests doc])
+AC_CONFIG_SUBDIRS([lib src tests])
 
 dnl This piece of sed script replaces every line containing '@subdir@'
 dnl by several consecutive lines, each referencing one subdir.
@@ -44,8 +44,6 @@ g
 s/@subdir@/tests/
 p
 g
-s/@subdir@/doc/
-p
 d
 }
 '" > configure.ac.patch

    patch < configure.ac.patch

    __bld-common
    rm configure.ac
    cp configure.ac.old configure.ac
}

__ed()
{
	__common ed
}

__attr()
{
	__cd attr

	$DIST_CLEAN
	./autogen.sh
	INSTALL_USER=root  \
	INSTALL_GROUP=root \
	./configure --prefix=/usr	\
		--libdir=/lib		\
		--libexecdir=/usr/lib

	__mk
	sudo make install install-dev install-lib
	sudo ldconfig
}

__acl()
{
	__cd acl

	$DIST_CLEAN
	./autogen.sh
	INSTALL_USER=root  \
	INSTALL_GROUP=root \
	./configure --prefix=/usr	\
		--libdir=/lib		\
		--libexecdir=/usr/lib

	__mk
	sudo make install install-dev install-lib

	sudo chmod -v 0755 /lib/libacl.so.1.1.0
	sudo rm -v /lib/libacl.{a,la,so}
	sudo ln -sfv ../../lib/libacl.so.1 /usr/lib/libacl.so
	sudo sed -i "s|libdir='/lib'|libdir='/usr/lib'|" /usr/lib/libacl.la
	sudo install -v -m644 doc/*.txt /usr/share/doc/acl

	sudo ldconfig
}

__indent()
{
	__common indent
}

__expect()
{
	__cd expect
        __bld-common --with-tcl=/usr/lib --with-tclinclude=/usr/include --enable-shared
}

__dejagnu()
{
	__common dejagnu
}

__wget()
{
	__cd wget
        __bld-common --with-ssl=openssl --with-openssl --disable-ipv6
}

__all()
{
#__rem(){
    __patch
    __libunistring
    __guile
    __libidn
    __gnutls
    __ed
    __gperf
    __attr
    __acl
    __indent
    __expect
    __dejagnu
    __wget
}

$@

