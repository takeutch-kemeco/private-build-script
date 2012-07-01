#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__libunistring() {
	cd $__BASE_DIR__/libunistring
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}
__guile()
{
	cd $__BASE_DIR__/guile
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gnutls() {
	cd $__BASE_DIR__/gnutls
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

### memo ###
# configure.ac の doc 項目を削除して autoconf した configureを使えばエラーが出ない。
# (tex環境が万全でない場合)
# だが、エラーが出てもマニュアルもビルドに失敗してるだけなので、make install は通る。気にしなくていい。
__gperf() {
	cd $__BASE_DIR__/gperf
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__ed() {
	cd $__BASE_DIR__/ed
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__attr() {
	cd $__BASE_DIR__/attr
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make

	make install install-dev

### 自分でリンクを張る必要があるが、安全にやる方法が思いつかない（別OS上からやるしかない）
#	cp -f $__BASE_DIR__/attr/libattr/.libs/libattr.so $PREFIX/lib/libattr.so.1.1.1
#	ln -sf $PREFIX/lib/libattr.so.1.1.1 $PREFIX/lib/libattr.so.1
#	ln -sf $PREFIX/lib/libattr.so.1 $PREFIX/lib/libattr.so
#	chmod -v 0755 $PREFIX/lib/libattr.so.*

	ldconfig
}

__acl() {
	cd $__BASE_DIR__/acl
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make

	make install install-dev install-lib
	chmod -v 0755 $PREFIX/lib/libacl.so.*
	rm $PREFIX/lib/libacl.so
	ln -s libacl.so.1 $PREFIX/lib/libacl.so
	install -v -m644 doc/*.txt $PREFIX/share/doc/acl-2

	ldconfig
}

__indent() {
	cd $__BASE_DIR__/indent
	./configure --prefix=/usr
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__test__()
{

	exit
}
#__test__

__libunistring
__guile
__gnutls
__ed
__gperf
__acl
#__attr
__indent

