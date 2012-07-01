#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

__cd()
{
	echo "------------------------------"
	echo $1
	echo "------------------------------"

	cd $1
	$DIST_CLEAN
}

for PACKAGE in $(ls -F | grep / | sed -e "s/$\///")
do
	__cd $BASE_DIR/$PACKAGE

	if [ $? -eq 0 ]
	then
		./autogen.sh --prefix=$PREFIX \
			--enable-maintainer-mode \
			--enable-debug=no \
			--enable-vala=yes --enable-introspection=yes
		$MAKE_CLEAN
		make
		make install
		ldconfig
	fi
done

