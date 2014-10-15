#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__xfce-common()
{
    __cd $1
    __bld-common --enable-maintainer-mode --disable-debug
}

__vte()
{
    __xfce-common vte
}

__libxfce4util()
{
    __xfce-common libxfce4util
}

__xfconf()
{
    __xfce-common xfconf
}

__libxfce4ui()
{
    __xfce-common libxfce4ui
}

__exo()
{
    __xfce-common exo
}

__thunar()
{
    __xfce-common thunar
}

__garcon()
{
    __xfce-common garcon
}

__gtk-xfce-engine()
{
    __xfce-common gtk-xfce-engine
}

__thunar-volman()
{
    __xfce-common thunar-volman
}

__tumbler()
{
    __xfce-common tumbler
}

__xfce4-appfinder()
{
    __xfce-common xfce4-appfinder
}

__xfce4-dev-tools()
{
    __xfce-common xfce4-dev-tools
}

__xfce4-panel()
{
    __xfce-common xfce4-panel
}

__xfce4-power-manager()
{
    __xfce-common xfce4-power-manager
}

__xfce4-session()
{
    __xfce-common xfce4-session
}

__xfce4-settings()
{
    __xfce-common xfce4-settings
}

__xfdesktop()
{
    __xfce-common xfdesktop
}

__xfwm4()
{
    __xfce-common xfwm4
}

__xfce4-taskmanager()
{
    __xfce-common xfce4-taskmanager
}

__xfce4-terminal()
{
    __xfce-common xfce4-terminal
}

__ristretto()
{
    __xfce-common ristretto
}

__base-system()
{
### __vte
    __libxfce4util
    __xfconf
    __libxfce4ui
    __exo
    __thunar
    __garcon
    __gtk-xfce-engine
### __thunar-volman # required gudev
    __tumbler
    __xfce4-appfinder
### __xfce4-dev-tools
    __xfce4-panel
### __xfce4-power-manager # required libnotify
    __xfce4-session
    __xfce4-settings
    __xfdesktop
    __xfwm4
}

__extra-apps()
{
    __xfce4-taskmanager
    __xfce4-terminal
    __ristretto
}

__all()
{
    __base-system
    __extra-apps
}

__init-env
$@

