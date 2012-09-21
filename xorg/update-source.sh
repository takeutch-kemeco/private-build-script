#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__common()
{
	__cd $1
	git pull
}

__util_macros()
{
	__common $BASE_DIR/macros
}

__proto()
{
	PROTO_BASE_DIR=$BASE_DIR/proto
	__cd $PROTO_BASE_DIR

	for package in $(__lsdir)
	do
		__common $PROTO_BASE_DIR/$package
	done
}

__fontutil()
{
	__common $BASE_DIR/fontutil
}

__makedepend()
{
	__common $BASE_DIR/makedepend
}

__libXau()
{
	__common $BASE_DIR/libXau
}

__libXdmcp()
{
	__common $BASE_DIR/ libXdmcp
}

__pthread-stubs()
{
	__common $BASE_DIR/pthread-stubs
}

__xcb-proto()
{
	__common $BASE_DIR/xcb/proto
}

__libxcb()
{
	__common $BASE_DIR/xcb/libxcb
}

__libs()
{
	LIBS_BASE_DIR=$BASE_DIR/libs
	__cd $LIBS_BASE_DIR

	for package in $(__lsdir)
	do
		__common $LIBS_BASE_DIR/$package
	done
}

__xcb-util-common-m4()
{
	__common $BASE_DIR/xcb/util-common-m4
}

__xcb-util()
{
	__common $BASE_DIR/xcb/util
}

__xcb-util-image()
{
	__common $BASE_DIR/xcb/util-image
}

__xcb-util-keysyms()
{
	__common $BASE_DIR/xcb/util-keysyms
}

__xcb-util-renderutil()
{
	__common $BASE_DIR/xcb/util-renderutil
}

__xcb-util-wm()
{
	__common $BASE_DIR/xcb/util-wm
}

__mesa()
{
	__common $BASE_DIR/mesa/mesa
}

__mesa-drm()
{
	__common $BASE_DIR/mesa/drm
}

__apps()
{
	APPS_BASE_DIR=$BASE_DIR/apps
	__cd $APPS_BASE_DIR

	for package in $(__lsdir)
	do
		__common $APPS_BASE_DIR/$package
	done
}

__xcursor-themes()
{
	echo
}

__fonts()
{
	echo
}

__xkeyboard-config()
{
	__common $BASE_DIR/xkeyboard-config
}

__xserver()
{
	__common $BASE_DIR/xserver
}

__driver()
{
	DRIVER_BASE_DIR=$BASE_DIR/driver
	cd $DRIVER_BASE_DIR

	for package in $(__lsdir)
	do
		__common $DRIVER_BASE_DIR/$package
	done
}

__xterm()
{
        #NULL
        echo
}

__util_macros
__proto
__fontutil
__makedepend
__libXau
__libXdmcp
__pthread-stubs

__xcb-proto
__libxcb

__libs

__xcb-util
__xcb-util-image
__xcb-util-keysyms
__xcb-util-renderutil
__xcb-util-wm

__mesa
__mesa-drm

__apps
__xcursor-themes
__fonts
__xkeyboard-config
__xserver
__driver
__xterm

