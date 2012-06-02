#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__git()
{
	cd $BASE_DIR/git
	$MAKE_CLEAN
	make prefix=$PREFIX
	make prefix=$PREFIX install
	ldconfig

	cd $BASE_DIR
}

__gitg()
{
	cd $BASE_DIR/gitg
	./autogen.sh --prefix=$PREFIX --enable-glade-catalog=auto
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__hg()
{
	cd $BASE_DIR/hg
	python setup.py install

	cd $BASE_DIR
}

__apr1()
{
	cd $BASE_DIR/apr1
	./configure --prefix=$PREFIX \
		--with-installbuilddir=$PREFIX/lib/apr-1
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__apr1-util()
{
	cd $BASE_DIR/apr1-util
	./configure --prefix=$PREFIX \
		--with-apr=$PREFIX/bin/apr-1-config
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__apr2()
{
	cd $BASE_DIR/apr2
	./buildconf
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__serf()
{
	cd $BASE_DIR/serf
	./buildconf
	./configure --prefix=$PREFIX \
		--with-apr=$PREFIX/bin/apr-2-config
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__sqlite3()
{
	cd $BASE_DIR/sqlite3
	./configure --prefix=$PREFIX \
		--enable-threadsafe \
		--enable-threads-override-locks \
		--enable-load-extension
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}


__svn()
{
	cd $BASE_DIR/svn
	./autogen.sh
	./configure --prefix=$PREFIX --with-serf=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gdbm()
{
	cd $BASE_DIR/gdbm
	./bootstrup
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make BINOWN=root BINGRP=root install
	ldconfig

	cd $BASE_DIR
}

__diffutils()
{
	echo
}

__cvs()
{
	cd $BASE_DIR/ccvs
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__bzr()
{
	cd $BASE_DIR/bzr
	python setup.py install
	ldconfig

	cd $BASE_DIR
}

__git
__gitg

__hg

__apr1
__apr1-util
__apr2
__serf

__sqlite3

__gdbm

__diffutils
__cvs

__bzr

