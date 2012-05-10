#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

libgpg-error()
{
	cd $__BASE_DIR__/libgpg-error

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

libgcrypt()
{
	cd $__BASE_DIR__/libgcrypt

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

gmime()
{
	cd $__BASE_DIR__/gmime

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

libassuan()
{
	cd $__BASE_DIR__/libassuan

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

gpgme()
{
	cd $__BASE_DIR__/gpgme

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--with-gpg=/usr/bin/gpg2 \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

libksba()
{
	cd $__BASE_DIR__/libksba

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

openldap()
{
	cd $__BASE_DIR__/openldap

	if [ $? -eq 0 ]
	then
		./configure --prefix=$PREFIX \
			--sysconfdir=/etc \
			--enable-dynamic \
			--disable-debug \
			--disable-slapd
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}

gnupg()
{
	cd $__BASE_DIR__/gnupg

	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX \
			--disable-doc \
			--enable-maintainer-mode
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__	
}


test()
{
#	libgpg-error
#	libgcrypt
#	gmime
#	libassuan
#	gpgme
#	libksba
#	openldap
#	gnupg
	exit
}
#test

libgpg-error
libgcrypt
gmime
libassuan
gpgme
libksba
openldap
gnupg

