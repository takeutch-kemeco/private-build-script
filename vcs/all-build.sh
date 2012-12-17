#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__git()
{
	__cd $BASE_DIR/git

	$MAKE_CLEAN
	__mk prefix=$PREFIX
	__mk prefix=$PREFIX install
	ldconfig
}

__gitg()
{
	__cd $BASE_DIR/gitg

	./autogen.sh --prefix=$PREFIX	\
		--enable-glade-catalog=auto

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__hg()
{
	__cd $BASE_DIR/hg

	python setup.py install
}

__apr1()
{
	__cd $BASE_DIR/apr1

	./configure --prefix=$PREFIX	\
		--with-installbuilddir=$PREFIX/lib/apr-1 \
		--disable-static 	\
		--with-devrandom=/dev/random

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__apr1-util()
{
	__cd $BASE_DIR/apr1-util

	./configure --prefix=$PREFIX 	\
		--with-apr=$PREFIX/bin/apr-1-config \
		--with-gdbm=$PREFIX	\
		--with-berkeley-db=$PREFIX \
		--with-openssl=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__neon()
{
	__cd $BASE_DIR/neon

	./configure --prefix=$PREFIX	\
		--enable-shared		\
		--disable-static 	\
		--with-ssl=openssl	\
		--with-libxml2		\
		--with-expat

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__apr2()
{
	__cd $BASE_DIR/apr2

	./buildconf
	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__serf()
{
	__cd $BASE_DIR/serf

	./buildconf
	./configure --prefix=$PREFIX 	\
		--with-apr=$PREFIX/bin/apr-2-config

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__sqlite3()
{
	__cd $BASE_DIR/sqlite3

	./configure --prefix=$PREFIX 	\
		--enable-threadsafe 	\
		--enable-dynamic-extensions

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}


__svn()
{
	__cd $BASE_DIR/svn

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--with-serf=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gdbm()
{
	__cd $BASE_DIR/gdbm

	./bootstrup
	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk BINOWN=root BINGRP=root install
	ldconfig
}

__diffutils()
{
	echo
}

__cvs()
{
	__cd $BASE_DIR/ccvs

	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__bzr()
{
	__cd $BASE_DIR/bzr

	python setup.py install
	ldconfig
}

__all()
{
#__rem(){
__git
__gitg

__hg

__apr1
__apr1-util
__neon
__apr2
###__serf

__sqlite3

__gdbm

__svn

__diffutils
__cvs

__bzr
}

$@

