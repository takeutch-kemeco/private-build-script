#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
__X11_LIB__=/usr/X11R6/lib

__MAKE_CLEAN__=""
#__MAKE_CLEAN__="make clean"

xfce4-dev-tools()
{
	cd $__BASE_DIR__/xfce4-dev-tools

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4util()
{
	cd $__BASE_DIR__/libxfce4util

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfconf()
{
	cd $__BASE_DIR__/xfconf

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfcegui4()
{
#	cd $__X11_LIB__
#	ld --whole-archive -share -o libXinerama.so.1 libXinerama.a
#	ln -s libXinerama.so.1 libXinerama.so

	cd $__BASE_DIR__/libxfcegui4

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4mcs()
{
	cd $__BASE_DIR__/libxfce4mcs

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce-mcs-manager()
{
	cd $__BASE_DIR__/xfce-mcs-manager

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make CFLAGS+="-D G_CONST_RETURN=const"
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce-mcs-plugins()
{
	cd $__BASE_DIR__/xfce-mcs-plugins

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

exo()
{
	cd $__BASE_DIR__/exo

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-panel()
{
	cd $__BASE_DIR__/xfce4-panel

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

thunar()
{
	cd $__BASE_DIR__/thunar

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/thunar
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-session()
{
	cd $__BASE_DIR__/xfce4-session

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfwm4()
{
	cd $__BASE_DIR__/xfwm4

	./autogen.sh --prefix=$PREFIX --enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfdesktop()
{
	cd $__BASE_DIR__/xfdesktop

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfdesktop
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce-utils()
{
	cd $__BASE_DIR__/xfce-utils

	./autogen.sh --prefix=$PREFIX \
		--enable-debug=no \
		--sysconfdir=/etc/xfce
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-dev-tools
libxfce4util
xfconf
libxfcegui4
libxfce4mcs
xfce-mcs-manager
xfce-mcs-plugins
exo
xfce4-panel
thunar
xfce4-session
xfwm4
xfdesktop
xfce-utils

