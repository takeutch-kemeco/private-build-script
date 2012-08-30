#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

#MAKE_CLEAN=
MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

for PACKAGE in $(__lsdir)
do
	__mes $BASE_DIR/$PACKAGE
	__cd $BASE_DIR/$PACKAGE

	if [ $? -eq 0 ]
	then
		./autogen.sh --prefix=$PREFIX 	\
			--enable-maintainer-mode \
			--enable-debug=no 	\
			--enable-vala=yes 	\
			--enable-introspection=yes

		$MAKE_CLEAN
		__mk
		__mk install
		ldconfig
	fi
done

