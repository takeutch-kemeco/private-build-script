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
	./configure --prefix=$PREFIX 	\
		--enable-maintainer-mode

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libgpg-error()
{
	__common $BASE_DIR/libgpg-error
}

__libgcrypt()
{
	__common $BASE_DIR/libgcrypt
}

__gmime()
{
	__common $BASE_DIR/gmime
}

__libassuan()
{
	__common $BASE_DIR/libassuan
}

__gpgme()
{
	__cd $BASE_DIR/gpgme

	./autogen.sh
	./configure --prefix=$PREFIX 	\
		--with-gpg=/usr/bin/gpg2 \
		--enable-maintainer-mode

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libksba()
{
	__common $BASE_DIR/libksba
}

__openldap()
{
	__cd $BASE_DIR/openldap

	./autogen.sh
	./configure --prefix=$PREFIX 	\
		--sysconfdir=/etc 	\
		--enable-dynamic 	\
		--disable-debug 	\
		--disable-slapd

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gnupg()
{
	__cd $BASE_DIR/gnupg

	./autogen.sh
	./configure --prefix=$PREFIX 	\
		--libexecdir=/usr/lib	\
		--disable-doc 		\
		--enable-maintainer-mode

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

#__rem() {
__libgpg-error
__libgcrypt
__gmime
__libassuan
__gpgme
__libksba
__openldap
__gnupg

