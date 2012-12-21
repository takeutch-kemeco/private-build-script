#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__patch()
{
	__cd $BASE_DIR/patch
	./bootstrup

	__common $BASE_DIR/patch
}

__libunistring()
{
	__common $BASE_DIR/libunistring
}

__guile()
{
	__common $BASE_DIR/guile
}

__libidn()
{
	__common $BASE_DIR/libidn
}

__gnutls()
{
	__common $BASE_DIR/gnutls
}

### memo ###
# configure.ac の doc 項目を削除して autoconf した configureを使えばエラーが出ない。
# (tex環境が万全でない場合)
# だが、エラーが出てもマニュアルもビルドに失敗してるだけなので、make install は通る。気にしなくていい。
__gperf() {
	__cd $BASE_DIR/gperf
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

	__common $BASE_DIR/gperf

	__cd $BASE_DIR/gperf
	rm configure.ac
	cp configure.ac.old configure.ac
}

__ed()
{
	__common $BASE_DIR/ed
}

__attr()
{
	__cd $BASE_DIR/attr

	$DIST_CLEAN
	./autogen.sh
	INSTALL_USER=root  \
	INSTALL_GROUP=root \
	./configure --prefix=/usr	\
		--libdir=/lib		\
		--libexecdir=/usr/lib

	__mk
	__mk install install-dev install-lib
	ldconfig
}

__acl()
{
	__common $BASE_DIR/acl

	$DIST_CLEAN
	./autogen.sh
	INSTALL_USER=root  \
	INSTALL_GROUP=root \
	./configure --prefix=$PREFIX	\
		--libdir=/lib		\
		--libexecdir=/usr/lib

	__mk
	__mk install install-dev install-lib

	make install install-dev install-lib
	chmod -v 0755 /lib/libacl.so.1.1.0
	rm -v /lib/libacl.{a,la,so}
	ln -sfv ../../lib/libacl.so.1 /usr/lib/libacl.so
	sed -i "s|libdir='/lib'|libdir='/usr/lib'|" /usr/lib/libacl.la
	install -v -m644 doc/*.txt /usr/share/doc/acl

	ldconfig
}

__indent()
{
	__common $BASE_DIR/indent
}

__expect()
{
	__cd $BASE_DIR/expect

	$DIST_CLEAN
	./configure --prefix=/usr	\
            	--with-tcl=/usr/lib \
            	--with-tclinclude=/usr/include \
            	--enable-shared

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__dejagnu()
{
	__common $BASE_DIR/dejagnu
}

__wget()
{
	__common $BASE_DIR/wget
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

