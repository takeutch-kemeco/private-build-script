#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"

mpg123()
{
	cd $BASE_DIR/mpg123
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__test__()
{

	exit
}
$__test__

mpg123

