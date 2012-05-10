#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"

mpg123()
{
	cd $BASE_DIR/mpg123

	if [ $? -eq 0 ]
	then
		aclocal --force -I m4
		libtoolize --force
		autoheader
		automake -acf
		autoconf

		./configure --prefix=$PREFIX
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi

	cd $BASE_DIR
}

__test__()
{

	exit
}
$__test__

mpg123

