#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. __common-func.sh

__bld-common()
{
	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr --enable-gtk-doc=no --enable-xinput --with-x $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__clutter()
{
	__common clutter
}

__clutter-box2d()
{
	__common clutter-box2d
}

__clutter-bullet()
{
	__common clutter-bullet
}

__clutter-gst()
{
	__common clutter-gst
}

__clutter-gstreamermm()
{
	__common clutter-gstreamermm
}

__clutter-gtk()
{
	__common clutter-gtk
}

__cluttermm()
{
	__common cluttermm
}

__cogl()
{
	__cd cogl
	__bld-common				\
  		--enable-debug=no		\
		--enable-cairo=yes		\
  		--enable-maintainer-flags=yes	\
		--disable-glibtest		\
		--enable-glib=yes		\
		--enable-cogl-pango=yes		\
		--enable-gdk-pixbuf=yes		\
		--enable-examples-install=no	\
		--enable-gles1=yes		\
		--enable-gles2=yes		\
		--enable-gl=yes			\
		--enable-cogl-gles2=yes		\
		--enable-glx=yes		\
		--enable-wgl=no			\
		--enable-sdl=yes		\
		--enable-sdl2=no		\
		--enable-xlib-egl-platform=yes	\
		--enable-introspection=yes
}

__mx()
{
	__common mx
}

__pyclutter()
{
	__common pyclutter
}

__toys()
{
	__common toys
}

__bullet()
{
	__cd bullet

	$DIST_CLEAN
	cmake -DCMAKE_INSTALL_PREFIX=/usr . -G "Unix Makefiles"

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#__rem(){
__mx
__cogl
__clutter
__clutter-box2d
__clutter-gtk
__cluttermm
__clutter-gst
###__clutter-gstreamermm

###__pyclutter
__bullet
__clutter-bullet
}

$@

