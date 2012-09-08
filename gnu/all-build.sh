#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	./autogen.sh
	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libunistring() {
	__common $BASE_DIR/libunistring
}
__guile()
{
	__common $BASE_DIR/guile
}

__gnutls() {
	__common $BASE_DIR/gnutls
}

### memo ###
# configure.ac の doc 項目を削除して autoconf した configureを使えばエラーが出ない。
# (tex環境が万全でない場合)
# だが、エラーが出てもマニュアルもビルドに失敗してるだけなので、make install は通る。気にしなくていい。
__gperf() {
	__common $BASE_DIR/gperf
}

__ed() {
	__common $BASE_DIR/ed
}

__attr() {
	__common $BASE_DIR/attr

	__mk install install-dev

### 自分でリンクを張る必要があるが、安全にやる方法が思いつかない（別OS上からやるしかない）
#	cp -f $BASE_DIR/attr/libattr/.libs/libattr.so $PREFIX/lib/libattr.so.1.1.1
#	ln -sf $PREFIX/lib/libattr.so.1.1.1 $PREFIX/lib/libattr.so.1
#	ln -sf $PREFIX/lib/libattr.so.1 $PREFIX/lib/libattr.so
#	chmod -v 0755 $PREFIX/lib/libattr.so.*

	ldconfig
}

__acl() {
	__common $BASE_DIR/acl

	__mk install install-dev install-lib
	chmod -v 0755 $PREFIX/lib/libacl.so.*
	rm $PREFIX/lib/libacl.so
	ln -s libacl.so.1 $PREFIX/lib/libacl.so
	install -v -m644 doc/*.txt $PREFIX/share/doc/acl-2

	ldconfig
}

__indent() {
	__common $BASE_DIR/indent
}

__test__()
{
	exit
}
#__test__

#__rem(){
__libunistring
__guile
__gnutls
__ed
__gperf
__acl
__attr
__indent

