#!/bin/bash

__BASE_DIR__=$(pwd)

__libffi()
{
	cd $__BASE_DIR__/libffi
	git pull
}

__python27()
{
	echo
}

__pth()
{
	echo
}

__glib()
{
	cd $__BASE_DIR__/glib
	git pull
}

__gobject-introspection()
{
	cd $__BASE_DIR__/gobject-introspection
	git pull
}

__libsigcpp()
{
	cd $__BASE_DIR__/libsigc++2
	git pull
}

__mm-common()
{
	cd $__BASE_DIR__/mm-common
	git pull
}

__glibmm()
{
	cd $__BASE_DIR__/glibmm
	git pull
}

__freetype2()
{
	cd $__BASE_DIR__/freetype2
	git pull
}

__expat()
{
	cd $__BASE_DIR__/expat
	cvs update
}

__libxml2()
{
	cd $__BASE_DIR__/libxml2
	git pull
}

__dbus()
{
	cd $__BASE_DIR__/dbus
	git pull origin
}

__dbus-glib()
{
	cd $__BASE_DIR__/dbus-glib
	git pull
}

__fontconfig()
{
	cd $__BASE_DIR__/fontconfig
	git pull
}

__freeglut()
{
	cd $__BASE_DIR__/freeglut
	svn update
}

__libpng()
{
	cd $__BASE_DIR__/libpng
	git pull
}

__libjpeg8()
{
	echo
}

__libtiff()
{
	cd $__BASE_DIR__/libffi
	git pull
}

__cairo()
{
	cd $__BASE_DIR__/cairo
	git pull
}

__cairomm()
{
	cd $__BASE_DIR__/cairomm
	git pull
}

__pango()
{
	cd $__BASE_DIR__/pango
	git pull
}

__pangomm()
{
	cd $__BASE_DIR__/pangomm
	git pull
}

__atk()
{
	cd $__BASE_DIR__/atk
	git pull
}

__atkmm()
{
	cd $__BASE_DIR__/atkmm
	git pull
}

__gdk-pixbuf()
{
	cd $__BASE_DIR__/gdk-pixbuf
	git pull
}

__gtk2()
{
	cd $__BASE_DIR__/gtk+-2.24
	git pull
}

__gtk3()
{
	cd $__BASE_DIR__/gtk+
	git pull
}

__gtkmm()
{
	cd $__BASE_DIR__/gtkmm
	git pull
}

__freeglut()
{
	cd $__BASE_DIR__/freeglut
	svn update
}

__pygtk()
{
	cd $__BASE_DIR__/pygtk
	git pull
}

__pygobject()
{
	cd $__BASE_DIR__/pygobject
	git pull
}

__py2cairo()
{
	cd $__BASE_DIR__/pygobject
	git pull
}

__libffi
###pth
###python27
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
###__libjpeg8
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

__freeglut
__pygtk
__pygobject

