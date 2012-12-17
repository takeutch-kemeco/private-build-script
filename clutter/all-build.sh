#!/bin/bash

BASE_DIR=$(pwd)

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
		--enable-gtk-doc	\
		--enable-xinput		\
		--with-x		\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__clutter()
{
	__common $BASE_DIR/clutter
}

__clutter-box2d()
{
	__common $BASE_DIR/clutter-box2d
}

__clutter-bullet()
{
	__common $BASE_DIR/clutter-bullet
}

__clutter-gst()
{
	__common $BASE_DIR/clutter-gst
}

__clutter-gstreamermm()
{
	__common $BASE_DIR/clutter-gstreamermm
}

__clutter-gtk()
{
	__common $BASE_DIR/clutter-gtk
}

__cluttermm()
{
	__common $BASE_DIR/cluttermm
}

__cogl()
{
	__common $BASE_DIR/cogl
}

__mx()
{
	__common $BASE_DIR/mx
}

__pyclutter()
{
	__common $BASE_DIR/pyclutter
}

__toys()
{
	__common $BASE_DIR/toys
}

__bullet()
{
	__cd $BASE_DIR/bullet

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

