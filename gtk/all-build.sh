#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="__mk clean"

DIST_CLEAN=
#DIST_CLEAN="__mk distclean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	./autogen.sh
	./configure --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__libffi()
{
	__common $BASE_DIR/libffi

	cp -f $BASE_DIR/libffi/i686-pc-linux-gnu/include/ffi.h $PREFIX/include/
	cp -f $BASE_DIR/libffi/i686-pc-linux-gnu/include/ffitarget.h $PREFIX/include/
	ldconfig
}

__pth()
{
	__common $BASE_DIR/pth
}

__glib()
{
	__cd $BASE_DIR/glib

	./autogen.sh
	PCRE_LIBS=-lpcre PCRE_CFLAGS=" " \
	LIBFFI_LIBS=-lffi LIBFFI_CFLAGS=" " \
	./configure --prefix=$PREFIX	\
		--sysconfdir=/etc 	\
		--with-pcre=system

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gobject-introspection()
{
	__cd $BASE_DIR/gobject-introspection

	./autogen.sh
	./configure  --prefix=$PREFIX	\
		--disable-tests

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libsigcpp()
{
	__common $BASE_DIR/libsigc++2
}

__mm-common()
{
	__common $BASE_DIR/mm-common
}

__glibmm()
{
	__common $BASE_DIR/glibmm
}

__freetype2()
{
	__cd $BASE_DIR/freetype2

	./autogen.sh

	sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h

	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__expat()
{
	cmake .
	aclocal --force
	libtoolize
	autoheader
	automake -acf
	autoconf

	__cd $BASE_DIR/expat

	./configure --prefix=$PREFIX	\
		--enable-shared

	__mk
	__mk install
	ldconfig
}

__libxml2()
{
	__common $BASE_DIR/libxml2
}

__fontconfig()
{
	__cd $BASE_DIR/fontconfig

	./autogen.sh --prefix=$PREFIX 	\
		--disable-docs 		\
		--without-add-fonts 	\
		--docdir=/usr/share/doc/fontconfig

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libpng()
{
	__common $BASE_DIR/libpng
}

__libjpeg8()
{
	__common $BASE_DIR/jpeg-8d
}

__libtiff()
{
	__common $BASE_DIR/tiff
}

__cairo()
{
	__cd $BASE_DIR/cairo

	./autogen.sh --prefix=$PREFIX 	\
		--enable-tee 		\
		--enable-gl 		\
		--enable-xcb 		\
		--enable-gtk-doc	\
		--enable-xcb-drm	\
		--enable-glsv2		\
		--enable-xml

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__cairomm()
{
	__common $BASE_DIR/cairomm
}

__pango()
{
	__common $BASE_DIR/pango
}

__pangomm()
{
	__common $BASE_DIR/pangomm
}

__atk()
{
	__common $BASE_DIR/atk
}

__atkmm()
{
	__common $BASE_DIR/atkmm
}

__gdk-pixbuf()
{
	__common $BASE_DIR/gdk-pixbuf
}

__gtk2()
{
	__cd $BASE_DIR/gtk+-2.24

	./configure --prefix=$PREFIX 	\
		--sysconfdir=/etc	\
		--with-xinput=yes 	\
		--with-gdktarget=x11 	\
		--with-x

	$MAKE_CLEAN
	__mk
	__mk install

	ls /etc/gtk-2.0/gtk.immodules
	if [ $? -ne 0 ]
	then
		gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
	fi

	ls /etc/gtk-2.0/gtkrc
	if [ $? -ne 0 ]
	then
cat > /etc/gtk-2.0/gtkrc << "EOF"
include "/usr/share/themes/Clearlooks/gtk-2.0/gtkrc"
gtk-icon-theme-name = "Mist"
EOF
	fi

	ldconfig
}

__gtk3()
{
	__cd $BASE_DIR/gtk+

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--sysconfdir=/etc	\
		--enable-x11-backend	\
		--enable-broadway-backend

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gtkmm()
{
	__common $BASE_DIR/gtkmm
}

__gtkmm2()
{
	__common $BASE_DIR/gtkmm-2.24
}

__libsigc++2()
{
	__common $BASE_DIR/libsigc++2
}

__libxml2()
{
	__common $BASE_DIR/libxml2
}

__test__()
{
	exit
}
#__test__

#__rem(){
__libffi
__libsigc++2
__libxml2
__tk
__pth
__glib
__gobject-introspection
__libsigcpp
__mm-common
__glibmm

__freetype2
__expat
__libxml2

__fontconfig

__libpng
__libjpeg8
__libtiff

__cairo
__cairomm
__pango
__pangomm
__atk
__atkmm
__gdk-pixbuf
__gtk2
__gtkmm2
__gtk3
__gtkmm

