#!/bin/bash

__BASE_DIR__=$(pwd)

util_macros()
{
	cd macros

	git pull

	cd $__BASE_DIR__
}

proto()
{
	cd proto

	__PROTO_BASE_DIR__=$__BASE_DIR__/proto
	for package in $(ls)
	do
		cd $__PROTO_BASE_DIR__/$package
		git pull
	done

	cd $__BASE_DIR__
}

fontutil()
{
	cd fontutil

	git pull

	cd $__BASE_DIR__
}

makedepend()
{
	cd makedepend

	git pull

	cd $__BASE_DIR__
}

libXau()
{
	cd libXau

	git pull

	cd $__BASE_DIR__
}

libXdmcp()
{
	cd libXdmcp

	git pull

	cd $__BASE_DIR__
}

pthread-stubs()
{
	cd pthread-stubs

	git pull

	cd $__BASE_DIR__
}

xcb-proto()
{
	cd xcb/proto

	git pull

	cd $__BASE_DIR__
}

libxcb()
{
	cd xcb/libxcb
	
	git pull

	cd $__BASE_DIR__
}

libs()
{
	cd libs

	__LIBS_BASE_DIR__=$__BASE_DIR__/libs
	for package in $(ls)
	do
		cd $__LIBS_BASE_DIR__/$package
		git pull
	done

	cd $__BASE_DIR__
}

xcb-util-common-m4()
{
	cd xcb/util-common-m4
	
	git pull

	cd $__BASE_DIR__
}

xcb-util()
{
	cd xcb/util
	
	git pull

	cd $__BASE_DIR__
}

xcb-util-image()
{
	cd xcb/util-image
	
	git pull

	cd $__BASE_DIR__
}

xcb-util-keysyms()
{
	cd xcb/util-keysyms
	
	git pull

	cd $__BASE_DIR__
}

xcb-util-renderutil()
{
	cd xcb/util-renderutil
	
	git pull

	cd $__BASE_DIR__
}

xcb-util-wm()
{
	cd xcb/util-wm
	
	git pull

	cd $__BASE_DIR__
}

mesa()
{
	cd mesa/mesa
	
	git pull

	cd $__BASE_DIR__
}

mesa-drm()
{
	cd mesa/drm
	
	git pull

	cd $__BASE_DIR__
}

apps()
{
	cd apps

	__APPS_BASE_DIR__=$__BASE_DIR__/apps
	for package in $(ls)
	do
		cd $__APPS_BASE_DIR__/$package
		git pull
	done

	cd $__BASE_DIR__
}

xcursor-themes()
{
	echo
}

fonts()
{
	echo
}

xkeyboard-config()
{
	cd xkeyboard-config
	
	git pull

	cd $__BASE_DIR__
}

xserver()
{
	cd xserver
	
	git pull

	cd $__BASE_DIR__
}

driver()
{
	cd driver

	__DRIVER_BASE_DIR__=$__BASE_DIR__/driver
	for package in $(ls)
	do
		cd $__DRIVER_BASE_DIR__/$package
		git pull
	done

	cd $__BASE_DIR__
}

xterm()
{
        #NULL
        echo
}

util_macros
proto
fontutil
makedepend
libXau
libXdmcp
pthread-stubs

xcb-proto
libxcb

libs

xcb-util
xcb-util-image
xcb-util-keysyms
xcb-util-renderutil
xcb-util-wm

mesa
mesa-drm

apps
xcursor-themes
fonts
xkeyboard-config
xserver
driver
xterm

