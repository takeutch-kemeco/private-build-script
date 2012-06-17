#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

__libffi()
{
	cd libffi

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__pth()
{
	cd pth-2.0.7

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__glib()
{
	cd glib

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__gobject-introspection()
{
	cd gobject-introspection

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libsigcpp()
{
	cd libsigc++2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__mm-common()
{
	cd mm-common

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__glibmm()
{
	cd glibmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__freetype2()
{
	cd freetype2

	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__expat()
{
	cd expat

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libxml2()
{
	cd libxml2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__dbus()
{
	cd $__BASE_DIR__/dbus

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

	cd $__BASE_DIR__
}

__dbus-glib()
{
	cd $__BASE_DIR__/dbus-glib
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode
	$MAKE_INSTALL
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__fontconfig()
{
	cd fontconfig

	./autogen.sh --prefix=$PREFIX \
		--disable-docs \
		--without-add-fonts \
		--docdir=/usr/share/doc/fontconfig
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__freeglut()
{
	cd freeglut

	./configure  --prefix=$XORG_PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libpng()
{
	cd libpng

	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libjpeg8()
{
	cd jpeg-8d

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libtiff()
{
	cd tiff-4.0.0

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__cairo()
{
	cd cairo

	./autogen.sh --prefix=$PREFIX \
		--enable-tee \
		--enable-gl \
		--enable-xcb \
		--enable-gtk-doc
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__cairomm()
{
	cd cairomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__pango()
{
	cd pango

	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__pangomm()
{
	cd pangomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__atk()
{
	cd atk

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__atkmm()
{
	cd atkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__gdk-pixbuf()
{
	cd gdk-pixbuf

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__gtk2()
{
	cd gtk+-2.24

	./configure --prefix=$PREFIX \
		--with-xinput=yes \
		--with-gdktarget=x11 \
		--with-x
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__gtk3()
{
	cd gtk+

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__gtkmm()
{
	cd gtkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

__libsigc++2() {
	cd $__BASE_DIR__/libsigc++2
	./autogen.sh --prefix=$PREFIX
	make
	make install
	ldconfig
}

__libxml2() {
	cd $__BASE_DIR__/libxml2
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

