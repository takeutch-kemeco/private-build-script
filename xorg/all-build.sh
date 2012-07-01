#!/bin/bash

BASE_DIR=$(pwd)

XORG_PREFIX=/usr
XORG_ETC=/etc
XORG_CONFIG="--prefix=$XORG_PREFIX \
	--sysconfdir=$XORG_ETC \
	--mandir=$XORG_PREFIX/share/man \
	--localstatedir=/var"
export XORG_PREFIX XORG_ETC XORG_CONFIG

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

__cd()
{
	echo "------------------------------"
	echo $1
	echo "------------------------------"

	cd $1
	$DIST_CLEAN
}

util_macros()
{
	__cd $BASE_DIR/macros

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

proto()
{
	__cd $BASE_DIR/proto

	__PROTO_BASE_DIR__=$BASE_DIR/proto
	for package in $(ls)
	do
		__cd $__PROTO_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG
			$MAKE_CLEAN
			make
			make install
			ldconfig
		fi
	done
}

makedepend()
{
	__cd $BASE_DIR/makedepend

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

fontutil()
{
	__cd $BASE_DIR/fontutil

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

libXau()
{
	__cd $BASE_DIR/libXau
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

libXdmcp()
{
	__cd $BASE_DIR/libXdmcp
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

libpthread-stubs()
{
	__cd $BASE_DIR/pthread-stubs
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xcb-proto()
{
	__cd $BASE_DIR/xcb/proto
	
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

libxcb()
{
	__cd $BASE_DIR/xcb/libxcb
	
	./autogen.sh $XORG_CONFIG --enable-xinput --enable-xkb --with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

libs()
{
	__cd $BASE_DIR/libs

	__LIBS_BASE_DIR__=$BASE_DIR/libs
	for package in $(ls)
	do
		__cd $__LIBS_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG
			$MAKE_CLEAN
			make
			make install
			ldconfig
		fi
	done
}

xcb-util-common-m4()
{
	__cd $BASE_DIR/xcb/util-common-m4
}

xcb-util()
{
	__cd $BASE_DIR/xcb/util

	rm $BASE_DIR/xcb/util/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xcb-util-image()
{
	__cd $BASE_DIR/xcb/util-image

	rm $BASE_DIR/xcb/util-image/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-image/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xcb-util-keysyms()
{
	__cd $BASE_DIR/xcb/util-keysyms

	rm $BASE_DIR/xcb/util-keysyms/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-keysyms/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xcb-util-renderutil()
{
	__cd $BASE_DIR/xcb/util-renderutil

	rm $BASE_DIR/xcb/util-renderutil/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-renderutil/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xcb-util-wm()
{
	__cd $BASE_DIR/xcb/util-wm

	rm $BASE_DIR/xcb/util-wm/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-wm/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

mesa-drm()
{
	__cd $BASE_DIR/mesa/drm
	
	./autogen.sh $XORG_CONFIG --disable-radeon --disable-nouveau --enable-udev
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

mesa()
{
	__cd $BASE_DIR/mesa/mesa

	./autogen.sh $XORG_CONFIG \
		--enable-xorg \
		--with-dri-drivers=i965 \
		--with-x \
		--with-gallium-drivers=i915 \
		--enable-gallium-egl \
		--enable-gles1 \
		--enable-gles2 \
		--enable-glx \
		--enable-shared-glapi \
		--enable-dri

	$MAKE_CLEAN
	make
	make install
	ln -s -v ${XORG_PREFIX}/include/GL  /usr/include
	ln -s -v ${XORG_PREFIX}/include/EGL /usr/include
	ln -s -v ${XORG_PREFIX}/include/KHR /usr/include
	ldconfig
}

apps()
{
	__cd $BASE_DIR/apps

	__APPS_BASE_DIR__=$BASE_DIR/apps
	for package in $(ls)
	do
		__cd $__APPS_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG \
				--with-xinitdir=$XORG_ETC/X11/app-defaults
			$MAKE_CLEAN
			make
			make install
			ldconfig
		fi
	done
}

xhost()
{
	__cd $BASE_DIR/apps/xhost

	./autogen.sh $XORG_CONFIG \
		--with-xinitdir=$XORG_ETC/X11/app-defaults
	$MAKE_CLEAN
	make
	make install
	ldconfig
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
	__cd $BASE_DIR/xkeyboard-config
	
	./autogen.sh $XORG_CONFIG \
		--with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

xserver()
{
	__cd $BASE_DIR/xserver
	
	./autogen.sh $XORG_CONFIG \
		--with-module-dir=$XORG_PREFIX/lib/X11/modules \
		--with-xkb-output=/var/lib/xkb \
		--enable-install-setuid
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

driver()
{
	echo "/usr/lib/xorg/modules/drivers"  \
		> /etc/ld.so.conf.d/xorg_modules_drivers.conf

	__cd $BASE_DIR/driver

	__DRIVER_BASE_DIR__=$BASE_DIR/driver
	for package in $(ls)
	do
		__cd $__DRIVER_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG
			$MAKE_CLEAN
			make
			make install
			ldconfig
		fi
	done
}

xterm()
{
	__cd $BASE_DIR/xterm

	sed -i '/v0/,+1s/new:/new:kb=^?:/' termcap &&
	echo -e '\tkbs=\\177,' >>terminfo &&
	TERMINFO=$XORG_PREFIX/lib/terminfo ./configure $XORG_CONFIG \
		--enable-luit --enable-wide-chars \
		--with-app-defaults=/etc/X11/app-defaults &&
	make
	make install
	make install-ti

cat >> $XORG_ETC/X11/app-defaults/XTerm << "EOF"

*VT100*locale: true
*VT100*faceName: courier 
*VT100*faceSize: 12
*backarrowKeyIsErase: true
*ptyInitialErase: true

*VT100*foreground: #ffffff
*VT100*background: #112233

*VT100*color0: #112233
*VT100*color1: #ffbbbb
*VT100*color2: #bbffbb
*VT100*color3: #ffffbb
*VT100*color4: #bbbbff
*VT100*color5: #ffbbff
*VT100*color6: #bbffff
*VT100*color7: #ffffff
*VT100*color8: #112233
*VT100*color9: #cc8888
*VT100*color10: #88cc88
*VT100*color11: #cccc88
*VT100*color12: #8888cc
*VT100*color13: #cc88cc
*VT100*color14: #88cccc
*VT100*color15: #cccccc

EOF
}

__test__()
{
mesa
	exit
}
__test__

util_macros
proto
makedepend
fontutil
libXau
libXdmcp
libpthread-stubs

xcb-proto
libxcb

libs

xcb-util-common-m4
xcb-util
xcb-util-image
xcb-util-keysyms
xcb-util-renderutil
xcb-util-wm

mesa-drm
mesa

apps
xcursor-themes
fonts
xkeyboard-config
xserver
driver
xterm

cp $BASE_DIR/50-wacom.conf $XORG_ETC/X11/xorg.conf.d/

