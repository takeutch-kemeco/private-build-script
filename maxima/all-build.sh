#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__wxWidgets()
{
	__cd $BASE_DIR/wxWidgets

	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib \
		--enable-stl --with-sdl --enable-compat26

	__mk
	__mk install
	ldconfig
}

__wxWidgets

