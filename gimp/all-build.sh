#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr/local

for PACKAGE in $(ls)
do
	cd $BASE_DIR/$PACKAGE
	make distclean
	./autogen.sh
	./configure --prefix=$PREFIX --disable-python
	make clean
	make
	make install
	ldconfig
done

