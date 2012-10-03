#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
__X11_LIB__=/usr/X11/lib

MAKE_CLEAN=
#MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

__xfce4-dev-tools()
{
	__cd $BASE_DIR/xfce4-dev-tools

	./autogen.sh --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__vte()
{
	__cd $BASE_DIR/vte

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--enable-vala=yes 	\
		--enable-introspection=yes

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxfce4util()
{
	__cd $BASE_DIR/libxfce4util

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfconf()
{
	__cd $BASE_DIR/xfconf

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxfce4ui()
{
	__cd $BASE_DIR/libxfce4ui

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__exo()
{
	__cd $BASE_DIR/exo

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc 	\
		--do__cdir=/usr/share/doc/exo

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__garcon()
{
	__cd $BASE_DIR/garcon

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gtk-xfce-engine()
{
       __cd $BASE_DIR/gtk-xfce-engine

        ./autogen.sh --prefix=$PREFIX 	\
                --enable-maintainer-mode \
                --enable-debug=no

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__libwnck()
{
       __cd $BASE_DIR/libwnck

        ./autogen.sh --prefix=$PREFIX 	\
                --enable-maintainer-mode \
                --enable-debug=no 	\
		--program-suffix=-1

        $MAKE_CLEAN
	__mk GETTEXT_PACKAGE=libwnck-1
        __mk install
        ldconfig
}

__libglade()
{
        __cd $BASE_DIR/libglade

        ./autogen.sh --prefix=$PREFIX 	\
                --enable-maintainer-mode \
                --enable-debug=no

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__libxfcegui4()
{
	__cd $BASE_DIR/libxfcegui4

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__thunar()
{
	__cd $BASE_DIR/thunar

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__thunar-volman()
{
	__cd $BASE_DIR/thunar-volman

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__tumbler()
{
	__cd $BASE_DIR/tumbler

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-appfinder()
{
        __cd $BASE_DIR/xfce4-appfinder

        ./autogen.sh --prefix=$PREFIX 	\
                --enable-maintainer-mode \
                --enable-debug=no

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__xfce4-panel()
{
	__cd $BASE_DIR/xfce4-panel

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc 	\
		--do__cdir=/usr/share/doc/xfce4-panel

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-power-manager()
{
	__cd $BASE_DIR/xfce4-power-manager

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-session()
{
	__cd $BASE_DIR/xfce4-session

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc 	\
		--do__cdir=/usr/share/doc/xfce4-session

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-settings()
{
	__cd $BASE_DIR/xfce4-settings

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfdesktop()
{
	__cd $BASE_DIR/xfdesktop

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfwm4()
{
	__cd $BASE_DIR/xfwm4

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__terminal()
{
	__cd $BASE_DIR/terminal

	./autogen.sh --prefix=$PREFIX 	\
		--enable-maintainer-mode \
		--enable-debug=no 	\
		--do__cdir=/usr/share/doc/terminal

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

#__rem(){
__xfce4-dev-tools
__vte
__libxfce4util
__xfconf
__libxfce4ui
__exo
__garcon
__gtk-xfce-engine
__libglade
__libxfcegui4
__thunar
__thunar-volman
__tumbler
__xfce4-appfinder
__xfce4-panel
__xfce4-power-manager
__xfce4-session
__xfce4-settings
__xfdesktop
__xfwm4
__terminal

