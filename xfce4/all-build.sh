#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__init-env()
{
	echo
}

__git-clean()
{
	git clone . b
	cp b/* . -rf
	rm b -rf
	git checkout master
	git pull
}

__bld-common()
{
	__git-clean

	cp configure.ac.in{,.orig}
	sed -e "s/-Wall/ /g" configure.ac.in.orig | sed -e "s/-Werror/ /g" > configure.ac.in

	$DIST_CLEAN
	CFLAGS="-O4 -D_FORTIFY_SOURCE=0 -D__OPTIMIZE__" CXXFLAGS="-O4"		\
	./autogen.sh --prefix=/usr		\
	      	     --sysconfdir=/etc		\
	             --enable-maintainer-mode	\
		     $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__vte()
{
	__cd vte
	__git-clean

	$DIST_CLEAN
	./autogen.sh --prefix=/usr 			\
	             --sysconfdir=/etc			\
	             --libexecdir=/usr/lib/vte-2.90	\
	             --enable-introspection=yes

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxfce4util()
{
	__common libxfce4util
}

__xfconf()
{
	__common xfconf
}

__libxfce4ui()
{
	__common libxfce4ui
}

__exo()
{
	__common exo
}

__thunar()
{
	__common thunar
}

__garcon()
{
	__common garcon
}

__thunar-volman()
{
	__common thunar-volman
}

__tumbler()
{
	__common tumbler
}

__xfce4-appfinder()
{
        __common xfce4-appfinder
}

__xfce4-dev-tools()
{
	__common xfce4-dev-tools
}

__xfce4-panel()
{
	__common xfce4-panel
}

__xfce4-power-manager()
{
	__common xfce4-power-manager
}

__xfce4-session()
{
	__common xfce4-session
}

__xfce4-settings()
{
	__common xfce4-settings
}

__xfdesktop()
{
	__common xfdesktop
}

__xfwm4()
{
	__common xfwm4
}

__xfce4-taskmanager()
{
	__common xfce4-taskmanager
}

__terminal()
{
	__common terminal
}

__ristretto()
{
	__common ristretto
}

__base-system()
{
#	__rem() {
	__vte
	__libxfce4util
	__xfconf
	__libxfce4ui
	__exo
	__thunar
	__garcon
	__gtk-xfce-engine
###	__thunar-volman # required gudev
	__tumbler
	__xfce4-appfinder
	__xfce4-dev-tools
	__xfce4-panel
###	__xfce4-power-manager # required libnotify
	__xfce4-session
	__xfce4-settings
	__xfdesktop
	__xfwm4
}

__extra-apps()
{
#	__rem() {
	__xfce4-taskmanager
	__terminal
	__ristretto
}

__all()
{
#	__rem() {
	__base-system
	__extra-apps
}

__init-env
$@

