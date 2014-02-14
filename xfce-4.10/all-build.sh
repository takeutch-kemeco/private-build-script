#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

XFCE_URL="http://archive.xfce.org/xfce/4.10/src"

. ../common-func/__common-func-2.sh

__perl-module-common()
{
    perl Makefile.PL
    __mk
    __mkinst
}

__lsb-init-functions()
{
    mkdir -p /lib/lsb
    cp -f $SRC_DIR/init-functions /lib/lsb/
}

__which()
{
    __wget ftp://ftp.gnu.org/gnu/which/which-2.20.tar.gz
    __dcd which-2.20
    __bld-common
}

__perl-module-uri()
{
    __wget http://www.cpan.org/authors/id/G/GA/GAAS/URI-1.60.tar.gz
    __dcd URI-1.60
    __perl-module-common
}

__libffi()
{
    echo
}

__pcre()
{
    echo
}

__pkg-config()
{
    echo
}

__glib()
{
    echo
}

__dbus()
{
    echo
}

__blfs-bootscripts-dbus()
{
    echo
}

__dbus-glib()
{
    echo
}

__gobject-introspection()
{
    echo
}

__atk()
{
    echo
}

__cairo()
{
    echo
}

__libjpeg-8d()
{
    echo
}

__libtiff()
{
    echo
}

__libexif()
{
    __wget http://downloads.sourceforge.net/libexif/libexif-0.6.21.tar.bz2
    __dcd libexif-0.6.21
    __bld-common
}

__gdk-pixbuf()
{
    echo
}

__harfbuzz()
{
    echo
}

__pango()
{
    echo
}

__hicolor-icon-theme()
{
    __wget http://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.12.tar.gz  
    __dcd hicolor-icon-theme-0.12
    __bld-common
}

__gtk+2()
{
    echo
}

__perl-module-xml-simple()
{
    __wget http://cpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.20.tar.gz
    __dcd XML-Simple-2.20
    __perl-module-common 
}

__icon-naming-utils()
{
    __wget http://tango.freedesktop.org/releases/icon-naming-utils-0.8.90.tar.bz2
    __dcd icon-naming-utils-0.8.90
    __bld-common --libexecdir=/usr/lib/icon-naming-utils
}

__gtk-engines()
{
    echo
}

__gnome-themes()
{
    echo
}

__gnome-icon-theme()
{
    echo
}

__gnome-icon-theme-extras()
{
    echo
}

__gnome-icon-theme-symbolic()
{
    echo
}

__libwnck()
{
    __wget ftp://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
    __dcd libwnck-2.30.7

    $DIST_CLEAN
    __cfg --prefix=/usr --disable-static --program-suffix=-1

    $MAKE_CLEAN
    __mk GETTEXT_PACKAGE=libwnck-1
    sudo make GETTEXT_PACKAGE=libwnck-1 install
    ldconfig
}

__libnotify()
{
    __wget ftp://ftp.gnome.org/pub/gnome/sources/libnotify/0.5/libnotify-0.5.2.tar.bz2
    __dcd libnotify-0.5.2
    __bld-common
}

__vte()
{
    __wget ftp://ftp.gnome.org/pub/gnome/sources/vte/0.28/vte-0.28.2.tar.xz
    __dcd vte-0.28.2
    __bld-common --enable-introspection
}

__libxfce4util()
{
    __wget $XFCE_URL/libxfce4util-4.10.0.tar.bz2
    __dcd libxfce4util-4.10.0
    __bld-common
}

__xfconf()
{
    __wget $XFCE_URL/xfconf-4.10.0.tar.bz2
    __dcd xfconf-4.10.0
    __bld-common
}

__libxfce4ui()
{
    __wget $XFCE_URL/libxfce4ui-4.10.0.tar.bz2
    __dcd libxfce4ui-4.10.0
    __bld-common
}

__exo()
{
    __wget $XFCE_URL/exo-0.8.0.tar.bz2
    __dcd exo-0.8.0
    __bld-common
}

__thunar()
{
    __wget $XFCE_URL/Thunar-1.4.0.tar.bz2
    __dcd Thunar-1.4.0
    __bld-common
}

__garcon()
{
    __wget $XFCE_URL/garcon-0.2.0.tar.bz2
    __dcd garcon-0.2.0
    __bld-common
}

__gtk-xfce-engine()
{
    __wget $XFCE_URL/gtk-xfce-engine-3.0.0.tar.bz2
    __dcd gtk-xfce-engine-3.0.0
    __bld-common
}

__thunar-volman()
{
    __wget $XFCE_URL/thunar-volman-0.8.0.tar.bz2
    __dcd thunar-volman-0.8.0
    __bld-common
}

__tumbler()
{
    __wget $XFCE_URL/tumbler-0.1.25.tar.bz2
    __dcd tumbler-0.1.25
    __bld-common
}

__xfce4-appfinder()
{
    __wget $XFCE_URL/xfce4-appfinder-4.10.0.tar.bz2
    __dcd xfce4-appfinder-4.10.0
    __bld-common
}

__xfce4-dev-tools()
{
    __wget $XFCE_URL/xfce4-dev-tools-4.10.0.tar.bz2
    __dcd xfce4-dev-tools-4.10.0
    __bld-common
}

__xfce4-panel()
{
    __wget $XFCE_URL/xfce4-panel-4.10.0.tar.bz2
    __dcd xfce4-panel-4.10.0
    __bld-common
}

__xfce4-power-manager()
{
    __wget $XFCE_URL/xfce4-power-manager-1.2.0.tar.bz2
    __dcd xfce4-power-manager-1.2.0
    __bld-common
}

__xfce4-session()
{
    __wget $XFCE_URL/xfce4-session-4.10.0.tar.bz2
    __dcd xfce4-session-4.10.0
    __bld-common
}

__xfce4-settings()
{
    __wget $XFCE_URL/xfce4-settings-4.10.0.tar.bz2
    __dcd xfce4-settings-4.10.0
    __bld-common
}

__xfdesktop()
{
    __wget $XFCE_URL/xfdesktop-4.10.0.tar.bz2
    __dcd xfdesktop-4.10.0
    __bld-common
}

__xfwm4()
{
    __wget $XFCE_URL/xfwm4-4.10.0.tar.bz2
    __dcd xfwm4-4.10.0
    __bld-common
}

__xfce4-taskmanager()
{
    __wget http://archive.xfce.org/src/apps/xfce4-taskmanager/1.0/xfce4-taskmanager-1.0.0.tar.bz2
    __dcd xfce4-taskmanager-1.0.0
    __bld-common
}

__Terminal()
{
    __wget http://archive.xfce.org/src/apps/terminal/0.4/Terminal-0.4.8.tar.bz2
    __dcd Terminal-0.4.8
    __bld-common
}

__ristretto()
{
    __wget http://archive.xfce.org/src/apps/ristretto/0.6/ristretto-0.6.3.tar.bz2
    __dcd ristretto-0.6.3
    __bld-common
}

__all-required()
{
    __lsb-init-functions
    __which
    __perl-module-uri
    __libffi
    __pcre
    __pkg-config
    __glib
    __dbus
    __blfs-bootscripts-dbus
    __dbus-glib
    __gobject-introspection
    __atk
    __cairo
    __libjpeg-8d
    __libtiff
    __libexif
    __gdk-pixbuf
    __harfbuzz
    __pango
    __hicolor-icon-theme
    __gtk+2
    __perl-module-xml-simple
    __icon-naming-utils
    __gtk-engines
    __gnome-themes
    __gnome-icon-theme
    __gnome-icon-theme-extras
    __gnome-icon-theme-symbolic
    __libwnck
    __libnotify
    __vte
}

__base-system()
{
    __all-required

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
    __xfce4-dev-tools
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
    __Terminal
    __ristretto
}

__all()
{
    __all-required
    __base-system
    __extra-apps
}

$@
