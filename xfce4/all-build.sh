#!/bin/bash

BASE_DIR=$(pwd)
__X11_LIB__=/usr/X11/lib

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh --prefix=/usr			\
		--sysconfdir=/etc			\
		--enable-maintainer-mode 		\
		--enable-debug=no			\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-dev-tools()
{
	__common $BASE_DIR/xfce4-dev-tools
}

__vte()
{
	__cd $BASE_DIR/vte

	$DIST_CLEAN
	./autogen.sh --prefix=/usr 			\
		--enable-maintainer-mode 		\
		--enable-debug=no 			\
		--enable-vala=yes 			\
		--enable-introspection=yes		\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxfce4util()
{
	__common $BASE_DIR/libxfce4util
}

__xfconf()
{
	__common $BASE_DIR/xfconf
}

__libxfce4ui()
{
	__common $BASE_DIR/libxfce4ui
}

__exo()
{
	__cd $BASE_DIR/exo

	$DIST_CLEAN
	./autogen.sh --prefix=/usr			\
		--enable-maintainer-mode 		\
		--enable-debug=no 			\
		--sysconfdir=/etc 			\
		--docdir=/usr/share/doc/exo		\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__garcon()
{
	__common $BASE_DIR/garcon
}

__gtk-xfce-engine()
{
       __common $BASE_DIR/gtk-xfce-engine
}

__libwnck()
{
       __cd $BASE_DIR/libwnck

	$DIST_CLEAN
        ./autogen.sh --prefix=/usr			\
                --enable-maintainer-mode 		\
                --enable-debug=no 			\
		--program-suffix=-1			\

        $MAKE_CLEAN
	__mk GETTEXT_PACKAGE=libwnck-1
        __mk install
        ldconfig
}

__libglade()
{
        __common $BASE_DIR/libglade
}

__libxfcegui4()
{
	__common $BASE_DIR/libxfcegui4
}

__thunar()
{
	__common $BASE_DIR/thunar
}

__thunar-volman()
{
	__common $BASE_DIR/thunar-volman
}

__tumbler()
{
	__common $BASE_DIR/tumbler
}

__xfce4-appfinder()
{
        __common $BASE_DIR/xfce4-appfinder
}

__xfce4-panel()
{
	__cd $BASE_DIR/xfce4-panel

	$DIST_CLEAN
	./autogen.sh --prefix=/usr 			\
		--enable-maintainer-mode 		\
		--enable-debug=no 			\
		--sysconfdir=/etc 			\
		--docdir=/usr/share/doc/xfce4-panel	\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-power-manager()
{
	__common $BASE_DIR/xfce4-power-manager
}

__xfce4-session()
{
	__cd $BASE_DIR/xfce4-session

	$DIST_CLEAN
	./autogen.sh --prefix=/usr 			\
		--enable-maintainer-mode 		\
		--enable-debug=no 			\
		--sysconfdir=/etc 			\
		--docdir=/usr/share/doc/xfce4-session	\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xfce4-settings()
{
	__common $BASE_DIR/xfce4-settings
}

__xfdesktop()
{
	__common $BASE_DIR/xfdesktop
}

__xfwm4()
{
	__common $BASE_DIR/xfwm4
}

__terminal()
{
	__cd $BASE_DIR/terminal

	$DIST_CLEAN
	./autogen.sh --prefix=/usr 			\
		--enable-maintainer-mode 		\
		--enable-debug=no 			\
		--docdir=/usr/share/doc/terminal	\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
__rem(){
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
}
__xfce4-power-manager
__xfce4-session
__xfce4-settings
__xfdesktop
__xfwm4
__terminal
}

$@

