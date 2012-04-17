#!/bin/bash

__BASE_DIR__=$(pwd)

XORG_PREFIX=/usr
XORG_ETC=/etc
XORG_CONFIG="--prefix=$XORG_PREFIX \
	--sysconfdir=$XORG_ETC \
	--mandir=$XORG_PREFIX/share/man \
	--localstatedir=/var"
export XORG_PREFIX XORG_ETC XORG_CONFIG

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

util_macros()
{
	cd macros

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

proto()
{
	cd proto

	__PROTO_BASE_DIR__=$__BASE_DIR__/proto
	for package in $(ls)
	do
		cd $__PROTO_BASE_DIR__/$package
		./autogen.sh $XORG_CONFIG
		$MAKE_CLEAN
		make
		make install
		ldconfig
	done

	cd $__BASE_DIR__
}

makedepend()
{
	cd makedepend

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libXau()
{
	cd libXau
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libXdmcp()
{
	cd libXdmcp
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libpthread-stubs()
{
	cd pthread-stubs
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-proto()
{
	cd xcb/proto
	
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxcb()
{
	cd xcb/libxcb
	
	./autogen.sh $XORG_CONFIG --enable-xinput --enable-xkb
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libs()
{
	cd libs

	__LIBS_BASE_DIR__=$__BASE_DIR__/libs
	for package in $(ls)
	do
		cd $__LIBS_BASE_DIR__/$package
		./autogen.sh $XORG_CONFIG
		$MAKE_CLEAN
		make
		make install
		ldconfig
	done

	cd $__BASE_DIR__
}

xcb-util-common-m4()
{
	cd xcb/util-common-m4
	cd $__BASE_DIR__
}

xcb-util()
{
	cd xcb/util

	rm $__BASE_DIR__/xcb/util/m4 -rf
	ln -s $__BASE_DIR__/xcb/util-common-m4 $__BASE_DIR__/xcb/util/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-util-image()
{
	cd xcb/util-image

	rm $__BASE_DIR__/xcb/util-image/m4 -rf
	ln -s $__BASE_DIR__/xcb/util-common-m4 $__BASE_DIR__/xcb/util-image/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-util-keysyms()
{
	cd xcb/util-keysyms

	rm $__BASE_DIR__/xcb/util-keysyms/m4 -rf
	ln -s $__BASE_DIR__/xcb/util-common-m4 $__BASE_DIR__/xcb/util-keysyms/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-util-renderutil()
{
	cd xcb/util-renderutil

	rm $__BASE_DIR__/xcb/util-renderutil/m4 -rf
	ln -s $__BASE_DIR__/xcb/util-common-m4 $__BASE_DIR__/xcb/util-renderutil/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-util-wm()
{
	cd xcb/util-wm

	rm $__BASE_DIR__/xcb/util-wm/m4 -rf
	ln -s $__BASE_DIR__/xcb/util-common-m4 $__BASE_DIR__/xcb/util-wm/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

mesa-drm()
{
	cd mesa/drm
	
	./autogen.sh $XORG_CONFIG --disable-radeon --disable-nouveau
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__

}

mesa()
{
	cd mesa/mesa
	
	./autogen.sh $XORG_CONFIG \
		--enable-dri \
		--enable-xorg \
		--with-dri-drivers=i965 \
		--with-x
	$MAKE_CLEAN
	make
	make install
	ln -s -v ${XORG_PREFIX}/include/GL  /usr/include
	ln -s -v ${XORG_PREFIX}/include/EGL /usr/include
	ln -s -v ${XORG_PREFIX}/include/KHR /usr/include
	ldconfig

	cd $__BASE_DIR__
}

apps()
{
	cd apps

	__APPS_BASE_DIR__=$__BASE_DIR__/apps
	for package in $(ls)
	do
		cd $__APPS_BASE_DIR__/$package
		./autogen.sh $XORG_CONFIG \
			--with-xinitdir=$XORG_ETC/X11/app-defaults
		$MAKE_CLEAN
		make
		make install
		ldconfig
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
	
	./autogen.sh $XORG_CONFIG --with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xserver()
{
	cd xserver
	
	./autogen.sh $XORG_CONFIG \
		--with-module-dir=$XORG_PREFIX/lib/X11/modules \
		--with-xkb-output=/var/lib/xkb \
		--enable-install-setuid
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

driver()
{
	echo "/usr/lib/xorg/modules/drivers"  \
		> /etc/ld.so.conf.d/xorg_modules_drivers.conf

	cd driver

	__DRIVER_BASE_DIR__=$__BASE_DIR__/driver
	for package in $(ls)
	do
		cd $__DRIVER_BASE_DIR__/$package
		./autogen.sh $XORG_CONFIG
		$MAKE_CLEAN
		make
		make install
		ldconfig
	done

	cd $__BASE_DIR__
}

xterm()
{
	cd xterm

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

	cd $__BASE_DIR__
}

__test__()
{
	exit
}
#__test__

util_macros
proto
makedepend
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

cp $__BASE_DIR__/50-wacom.conf $XORG_ETC/X11/xorg.conf.d/

