#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make distclean && make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$MAKE_CLEAN
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

	$MAKE_CLEAN
	./autogen.sh
	PCRE_LIBS=-lpcre PCRE_CFLAGS=" " \
	LIBFFI_LIBS=-lffi LIBFFI_CFLAGS=" " \
	./configure --prefix=$PREFIX	\
		--sysconfdir=/etc 	\
		--with-pcre=system

	__mk
	__mk install
	ldconfig
}

__gobject-introspection()
{
	__cd $BASE_DIR/gobject-introspection

	$MAKE_CLEAN
	./autogen.sh
	./configure  --prefix=$PREFIX	\
		--disable-tests

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

	$MAKE_CLEAN
	./autogen.sh

	sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h

	./configure --prefix=$PREFIX

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

	$MAKE_CLEAN
	./configure --prefix=$PREFIX	\
		--enable-shared

	__mk
	__mk install
	ldconfig
}

__fontconfig()
{
	__cd $BASE_DIR/fontconfig

	$MAKE_CLEAN
	./autogen.sh --prefix=$PREFIX 	\
		--disable-docs 		\
		--without-add-fonts 	\
		--docdir=/usr/share/doc/fontconfig

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

__cairomm()
{
	__common $BASE_DIR/cairomm
}

__pangomm()
{
	__common $BASE_DIR/pangomm
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

	$MAKE_CLEAN
	./configure --prefix=$PREFIX 	\
		--sysconfdir=/etc	\
		--with-xinput=yes 	\
		--with-gdktarget=x11 	\
		--with-x

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

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=$PREFIX	\
		--sysconfdir=/etc	\
		--enable-x11-backend	\
		--enable-broadway-backend

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

#__rem(){
__libffi
__libsigc++2
__tk
__pth
__glib
__gobject-introspection
__libsigcpp
__mm-common
__glibmm

__freetype2
__expat

__fontconfig

__libpng
__libjpeg8
__libtiff

__cairomm
__pangomm
__atkmm
__gdk-pixbuf
__gtk2
__gtkmm2
__gtk3
__gtkmm

