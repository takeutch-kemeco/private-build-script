#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

pixman()
{
	cd pixman

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libffi()
{
	cd libffi

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pth()
{
	cd pth-2.0.7

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

python27()
{
	cd Python-2.7.2

	./configure --prefix=$PREFIX \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

glib()
{
	cd glib

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gobject-introspection()
{
	cd gobject-introspection

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libsigcpp()
{
	cd libsigc++2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

mm-common()
{
	cd mm-common

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

glibmm()
{
	cd glibmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

freetype2()
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

expat()
{
	cd expat

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxml2()
{
	cd libxml2

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

dbus()
{
	cd $__BASE_DIR__/dbus

	groupadd -g 27 messagebus
	useradd -c "D-BUS Message Daemon User" \
		-d /dev/null \
		-u 27 \
		-g messagebus \
		-s /bin/false messagebus

	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc \
		--libexecdir=$PREFIX/lib/dbus-1.0 \
		--localstatedir=/var \
		--enable-maintainer-mode \
		--enable-embedded-tests=no \
		--enable-modular-tests=no \
		--enable-tests=no \
		--enable-installed-tests=no

	$MAKE_CLEAN
	make
	make install
	ldconfig

	dbus-uuidgen --ensure
	make install-dbus
	ldconfig

	cd $__BASE_DIR__
}

dbus-glib()
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

fontconfig()
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

freeglut()
{
	cd freeglut-2.8.0

	./configure  --prefix=$XORG_PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libpng()
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

libjpeg8()
{
	cd jpeg-8d

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libtiff()
{
	cd tiff-4.0.0

	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

cairo()
{
	cd cairo

	./autogen.sh --prefix=$PREFIX \
		--enable-tee \
		--enable-gl \
		--enable-drm=yes
#		--enable-gallium=yes
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

cairomm()
{
	cd cairomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pango()
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

pangomm()
{
	cd pangomm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

atk()
{
	cd atk

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

atkmm()
{
	cd atkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gdk-pixbuf()
{
	cd gdk-pixbuf

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gtk2()
{
	cd gtk+-2.0

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

gtk3()
{
	cd gtk+

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gtkmm()
{
	cd gtkmm

	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
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

pixman
libffi
pth
python27
glib
gobject-introspection
libsigcpp
mm-common
glibmm

freetype2
expat
libxml2

dbus
dbus-glib

fontconfig
freeglut

libpng
libjpeg8
libtiff

cairo
cairomm
pango
pangomm
atk
atkmm
gdk-pixbuf
gtk2
gtk3
gtkmm

