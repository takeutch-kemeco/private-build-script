#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

git()
{
	cd $BASE_DIR/git
	$MAKE_CLEAN
	make prefix=$PREFIX
	make prefix=$PREFIX install
	ldconfig

	cd $BASE_DIR
}

gitg()
{
	cd $BASE_DIR/gitg
	./autogen.sh --prefix=$PREFIX --enable-glade-catalog=auto
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

hg()
{
	cd $BASE_DIR/hg
	python setup.py install

	cd $BASE_DIR	
}

apr1()
{
	cd $BASE_DIR/apr-1.4.6
	./configure --prefix=$PREFIX \
		--with-installbuilddir=$PREFIX/lib/apr-1
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

apr1-util()
{
	cd $BASE_DIR/apr-util-1.4.1
	./configure --prefix=$PREFIX \
		--with-apr=$PREFIX/bin/apr-1-config
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

apr2()
{
	cd $BASE_DIR/apr
	./buildconf
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

serf()
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

sqlite3()
{
	cd $BASE_DIR/sqlite-autoconf-3071000
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


svn()
{
	cd $BASE_DIR/subversion-1.7.2
	./configure --prefix=$PREFIX --with-serf=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gdbm()
{
	cd $BASE_DIR/gdbm-1.10
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make BINOWN=root BINGRP=root install
	ldconfig

	cd $BASE_DIR
}

diffutils()
{
	cd $BASE_DIR/diffutils
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

cvs()
{
	cd $BASE_DIR/ccvs
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

git
gitg

hg

#apr1
#apr1-util
###apr2
#serf
#sqlite3
svn

###gdbm
diffutils
cvs

