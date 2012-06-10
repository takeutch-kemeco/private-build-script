#!/bin/bash

__BASE_DIR__=$(pwd)

libffi()
{
	cd libffi
	git pull
	cd $__BASE_DIR__
}

python27()
{
	echo
}

pth()
{
	echo
}

glib()
{
	cd glib
	git pull
	cd $__BASE_DIR__
}

gobject-introspection()
{
	cd gobject-introspection
	git pull
	cd $__BASE_DIR__
}

libsigcpp()
{
	cd libsigc++2
	git pull
	cd $__BASE_DIR__
}

mm-common()
{
	cd mm-common
	git pull
	cd $__BASE_DIR__
}

glibmm()
{
	cd glibmm
	git pull
	cd $__BASE_DIR__
}

freetype2()
{
	cd freetype2
	git pull
	cd $__BASE_DIR__
}

expat()
{
	cd expat
	cvs update
	cd $__BASE_DIR__
}

libxml2()
{
	cd libxml2
	git pull
	cd $__BASE_DIR__
}

dbus()
{
	cd dbus
	git pull origin
	cd $__BASE_DIR__
}

dbus-glib()
{
	cd dbus-glib
	git pull
	cd $__BASE_DIR__
}

fontconfig()
{
	cd fontconfig
	git pull
	cd $__BASE_DIR__
}

freeglut()
{
	echo
}

libpng()
{
	cd libpng
	git pull
	cd $__BASE_DIR__
}

libjpeg8()
{
	echo
}

libtiff()
{
	echo
}

cairo()
{
	cd cairo
	git pull
	cd $__BASE_DIR__
}

cairomm()
{
	cd cairomm
	git pull
	cd $__BASE_DIR__
}

pango()
{
	cd pango
	git pull
	cd $__BASE_DIR__
}

pangomm()
{
	cd pangomm
	git pull
	cd $__BASE_DIR__
}

atk()
{
	cd atk
	git pull
	cd $__BASE_DIR__
}

atkmm()
{
	cd atkmm
	git pull
	cd $__BASE_DIR__
}

gdk-pixbuf()
{
	cd gdk-pixbuf
	git pull
	cd $__BASE_DIR__
}

gtk2()
{
	cd gtk+-2.24
	git pull
	cd $__BASE_DIR__
}

gtk3()
{
	cd gtk+
	git pull
	cd $__BASE_DIR__
}

gtkmm()
{
	cd gtkmm
	git pull
	cd $__BASE_DIR__
}

freeglut()
{
	cd freeglut
	svn update
	cd $__BASE_DIR__
}

pygtk()
{
	cd $__BASE_DIR__/pygtk
	git pull
}

pygobject()
{
	cd $__BASE_DIR__/pygobject
	git pull
}

py2cairo()
{
	cd $__BASE_DIR__/pygobject
	git pull
}

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

freeglut
pygtk
pygobject

