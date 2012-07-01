#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

__cd()
{
	echo "------------------------------"
	echo $1
	echo "------------------------------"

	cd $1
	$DIST_CLEAN
}

__libffi()
{
	__cd $BASE_DIR/libffi

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	cp -f $BASE_DIR/libffi/i686-pc-linux-gnu/include/ffi.h $PREFIX/include/
	cp -f $BASE_DIR/libffi/i686-pc-linux-gnu/include/ffitarget.h $PREFIX/include/
	ldconfig
}

__pth()
{
	__cd $BASE_DIR/pth-2.0.7

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__glib()
{
	__cd $BASE_DIR/glib

	./autogen.sh
	PCRE_LIBS=-lpcre PCRE_CFLAGS=" " \
	LIBFFI_LIBS=-lffi LIBFFI_CFLAGS=" " \
	./configure --prefix=$PREFIX --sysconfdir=/etc --with-pcre=system

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gobject-introspection()
{
	__cd $BASE_DIR/gobject-introspection

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libsigcpp()
{
	__cd $BASE_DIR/libsigc++2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__mm-common()
{
	__cd $BASE_DIR/mm-common

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__glibmm()
{
	__cd $BASE_DIR/glibmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__freetype2()
{
	__cd $BASE_DIR/freetype2

	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__expat()
{
	__cd $BASE_DIR/expat

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libxml2()
{
	__cd $BASE_DIR/libxml2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__dbus()
{
	__cd $BASE_DIR/dbus

	groupadd -g 27 messagebus
	useradd -c "D-BUS Message Daemon User" \
		-d /dev/null \
		-u 27 \
		-g messagebus \
		-s /bin/false messagebus

	./autogen.sh --prefix=$PREFIX \
	./configure --prefix=$PREFIX \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--enable-maintainer-mode \
		--enable-embedded-tests=no \
		--enable-modular-tests=no \
		--enable-tests=no \
		--enable-installed-tests=no \
		--enable-stats \
		--with-dbus-user=messagebus \
		--enable-dnotify \
		--enable-x11-autolaunch \
		--with-x \
		--disable-Werror

#		--libexecdir=$PREFIX/lib/dbus-1.0 \

	$MAKE_CLEAN
	make
	make install
	ldconfig

	dbus-uuidgen --ensure
	make install-dbus
	ldconfig
}

__dbus-glib()
{
	__cd $BASE_DIR/dbus-glib
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode
	$MAKE_INSTALL
	make
	make install
	ldconfig
}

__fontconfig()
{
	__cd $BASE_DIR/fontconfig

	./autogen.sh --prefix=$PREFIX \
		--disable-docs \
		--without-add-fonts \
		--docdir=/usr/share/doc/fontconfig
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__freeglut()
{
	__cd $BASE_DIR/freeglut

	./configure  --prefix=$XORG_PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libpng()
{
	__cd $BASE_DIR/libpng

	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libjpeg8()
{
	__cd $BASE_DIR/jpeg-8d

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libtiff()
{
	__cd $BASE_DIR/tiff-4.0.0

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__cairo()
{
	__cd $BASE_DIR/cairo

	./autogen.sh --prefix=$PREFIX \
		--enable-tee \
		--enable-gl \
		--enable-xcb \
		--enable-gtk-doc
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__cairomm()
{
	__cd $BASE_DIR/cairomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__pango()
{
	__cd $BASE_DIR/pango

	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__pangomm()
{
	__cd $BASE_DIR/pangomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__atk()
{
	__cd $BASE_DIR/atk

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__atkmm()
{
	__cd $BASE_DIR/atkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gdk-pixbuf()
{
	__cd $BASE_DIR/gdk-pixbuf

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gtk2()
{
	__cd $BASE_DIR/gtk+-2.24

	./configure --prefix=$PREFIX \
		--with-xinput=yes \
		--with-gdktarget=x11 \
		--with-x
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gtk3()
{
	__cd $BASE_DIR/gtk+

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gtkmm()
{
	__cd $BASE_DIR/gtkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libsigc++2()
{
	__cd $BASE_DIR/libsigc++2

	./autogen.sh --prefix=$PREFIX
	make
	make install
	ldconfig
}

__libxml2()
{
	__cd $BASE_DIR/libxml2

	./autogen.sh --prefix=$PREFIX
	make
	make install
	ldconfig
}

__test__()
{

	exit
}
#__test__

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

__dbus
__dbus-glib

__fontconfig
__freeglut

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
__gtk3
__gtkmm

