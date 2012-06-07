#!/bin/bash

PREFIX=/usr
__BASE_DIR__=$(pwd)
__MAKE_CLEAN__=
#__MAKE_CLEAN__="make clean"

for __PACKAGE__ in $(ls)
do
	cd $__BASE_DIR__/$__PACKAGE__

	if [ $? -eq 0 ]
	then
		./autogen.sh --prefix=$PREFIX \
			--enable-maintainer-mode \
			--enable-debug=no \
			--enable-vala=yes --enable-introspection=yes
		$__MAKE_CLEAN__
		make
		make install
		ldconfig
	fi

	cd $__BASE_DIR__
done
