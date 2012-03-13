#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
__X11_LIB__=/usr/X11R6/lib

#__MAKE_CLEAN__=""
__MAKE_CLEAN__="make clean"

__DOCUMENT__="--enable-gtk-doc --enable-gtk-doc-html --enable-gtk-doc-pdf"

xfce4-dev-tools()
{
	cd $__BASE_DIR__/xfce4-dev-tools

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4util()
{
	cd $__BASE_DIR__/libxfce4util

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfconf()
{
	cd $__BASE_DIR__/xfconf

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

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

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4mcs()
{
	cd $__BASE_DIR__/libxfce4mcs

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce-mcs-manager()
{
	cd $__BASE_DIR__/xfce-mcs-manager

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make CFLAGS+="-D G_CONST_RETURN=const"
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce-mcs-plugins()
{
	cd $__BASE_DIR__/xfce-mcs-plugins

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4ui()
{
	cd $__BASE_DIR__/libxfce4ui

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxfce4menu()
{
	cd $__BASE_DIR__/libxfce4menu

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/thunar \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfwm4()
{
	cd $__BASE_DIR__/xfwm4

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfwm4-themes()
{
	cd $__BASE_DIR__/xfwm4-themes

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfdesktop \
		$__DOCUMENT__ \

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
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-settings()
{
	cd $__BASE_DIR__/xfce4-settings

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/xfce4 \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

tumbler()
{
	cd $__BASE_DIR__/tumbler

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		--libexecdir=$PREFIX/lib/tumbler \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-wavelan-plugin()
{
	cd $__BASE_DIR__/xfce4-wavelan-plugin

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-datetime-plugin()
{
	cd $__BASE_DIR__/xfce4-datetime-plugin

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-netload-plugin()
{
	cd $__BASE_DIR__/xfce4-netload-plugin

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-screenshooter()
{
	cd $__BASE_DIR__/xfce4-screenshooter

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-notifyd()
{
	cd $__BASE_DIR__/xfce4-notifyd

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-mixer()
{
	cd $__BASE_DIR__/xfce4-mixer

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-taskmanager()
{
	cd $__BASE_DIR__/xfce4-taskmanager

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-vala()
{
	cd $__BASE_DIR__/xfce4-vala

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-vala-plugin()
{
	cd $__BASE_DIR__/xfce4-vala-plugin

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-terminal()
{
	cd $__BASE_DIR__/xfce4-terminal

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

ristretto()
{
	cd $__BASE_DIR__/ristretto

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

parole()
{
	cd $__BASE_DIR__/parole

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc/xfce \
		$__DOCUMENT__ \

	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__test__()
{
	exit
}
#__test__

xfce4-dev-tools
libxfce4util
xfconf
libxfcegui4
libxfce4mcs
xfce-mcs-manager
xfce-mcs-plugins
libxfce4ui
libxfce4menu
exo
xfce4-panel
thunar
xfce4-session
xfwm4
xfwm4-themes
xfdesktop
xfce-utils
xfce4-settings
tumbler
xfce4-wavelan-plugin
xfce4-datetime-plugin
xfce4-netload-plugin
xfce4-notifyd
xfce4-mixer
xfce4-screenshooter
xfce4-taskmanager
xfce4-vala
xfce4-vala-plugin
xfce4-terminal
ristretto
parole

