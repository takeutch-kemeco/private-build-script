#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr
XORG_PREFIX=/usr

pixman()
{
	cd pixman

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libffi()
{
	cd libffi

	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pth()
{
	cd pth-2.0.7

	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

python27()
{
	cd Python-2.7.2

	./configure --prefix=$PREFIX --enable-shared
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

glib()
{
	cd glib

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libsigcpp()
{
	cd libsigc++2

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

glibmm()
{
	cd glibmm

	./autogen.sh --prefix=$PREFIX
#	make clean
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
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

expat()
{
	cd expat

	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxml2()
{
	cd libxml2

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

fontconfig()
{
	cd fontconfig

	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-docs \
		--without-add-fonts \
		--docdir=/usr/share/doc/fontconfig
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

freeglut()
{
	cd freeglut-2.8.0

	./configure  --prefix=$XORG_PREFIX
#	make clean
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
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libjpeg8()
{
	cd jpeg-8d

	./configure --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libtiff()
{
	cd tiff-4.0.0

	./configure --prefix=$PREFIX
#	make clean
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
		--enable-gl
#		--enable-drm=yes
#		--enable-gallium=yes
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

cairomm()
{
	cd cairomm

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pango()
{
	cd pango

	./autogen.sh --prefix=$PREFIX --sysconfdir=/etc
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pangomm()
{
	cd pangomm

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

atk()
{
	cd atk

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

atkmm()
{
	cd atkmm

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gdk-pixbuf()
{
	cd gdk-pixbuf

	./autogen.sh --prefix=$PREFIX
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gtk2()
{
	cd gtk+-2.24.8

	./configure --prefix=$PREFIX \
		--sysconfdir=/etc \
		--with-xinput=yes \
		--with-gdktarget=x11 \
		--with-x
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

gtk3()
{
	cd gtk+

	./autogen.sh --prefix=$PREFIX --sysconfdir=/etc
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

pixman
libffi
pth
python27
glib
libsigcpp
glibmm

freetype2
expat
libxml2
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

