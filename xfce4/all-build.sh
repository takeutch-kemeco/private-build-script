#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
__X11_LIB__=/usr/X11/lib

__MAKE_CLEAN__=
#__MAKE_CLEAN__="make clean"

vte()
{
	cd $__BASE_DIR__/vte

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--enable-vala=yes \
		--enable-introspection=yes
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
		--enable-debug=no
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
		--enable-debug=no
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
		--sysconfdir=/etc
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
		--sysconfdir=/etc \
		--docdir=/usr/share/doc/exo-0.8.0
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

garcon()
{
	cd $__BASE_DIR__/garcon

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gtk-xfce-engine()
{
       cd $__BASE_DIR__/gtk-xfce-engine

        ./autogen.sh --prefix=$PREFIX \
                --enable-maintainer-mode \
                --enable-debug=no
        $__MAKE_CLEAN__
        make
        make install
        ldconfig

        cd $__BASE_DIR__
}

libwnck()
{
       cd $__BASE_DIR__/libwnck

        ./autogen.sh --prefix=$PREFIX \
                --enable-maintainer-mode \
                --enable-debug=no \
		--program-suffix=-1
        $__MAKE_CLEAN__
	make GETTEXT_PACKAGE=libwnck-1
        make install
        ldconfig

        cd $__BASE_DIR__

}

libglade()
{
        cd $__BASE_DIR__/libglade

        ./autogen.sh --prefix=$PREFIX \
                --enable-maintainer-mode \
                --enable-debug=no
        $__MAKE_CLEAN__
        make
        make install
        ldconfig

        cd $__BASE_DIR__
}

libxfcegui4()
{
	cd $__BASE_DIR__/libxfcegui4

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no
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
		--sysconfdir=/etc
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

thunar-volman()
{
	cd $__BASE_DIR__/thunar-volman

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no
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
		--enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-appfinder()
{
        cd $__BASE_DIR__/xfce4-appfinder

        ./autogen.sh --prefix=$PREFIX \
                --enable-maintainer-mode \
                --enable-debug=no
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
		--sysconfdir=/etc \
		--docdir=/usr/share/doc/xfce4-panel-4.10.0
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xfce4-power-manager()
{
	cd $__BASE_DIR__/xfce4-power-manager

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--sysconfdir=/etc
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
		--sysconfdir=/etc \
		--docdir=/usr/share/doc/xfce4-session-4.10.0
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
		--sysconfdir=/etc
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
		--enable-debug=no
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
		--enable-debug=no
	$__MAKE_CLEAN__
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

# 4.10のterminalは出来が悪いので4.8のターミナルを使う
terminal()
{
	cd $__BASE_DIR__/terminal

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--enable-debug=no \
		--docdir=/usr/share/doc/terminal-0.4.8
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

vte
libxfce4util
xfconf
libxfce4ui
exo
garcon
gtk-xfce-engine
libwnck
libglade
libxfcegui4
thunar
thunar-volman
tumbler
xfce4-appfinder
xfce4-panel
xfce4-power-manager
xfce4-session
xfce4-settings
xfdesktop
xfwm4
terminal

