#!/bin/bash

__BASE_DIR__=$(pwd)

XORG_PREFIX=/usr
XORG_ETC=/etc
XORG_CONFIG="--prefix=$XORG_PREFIX \
	--sysconfdir=$XORG_ETC \
	--mandir=$XORG_PREFIX/share/man \
	--localstatedir=/var"
export XORG_PREFIX XORG_ETC XORG_CONFIG

util_macros()
{
	cd macros

	./autogen.sh $XORG_CONFIG
#	make clean
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
#		make clean
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
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libXau()
{
	cd libXau
	
	./autogen.sh $XORG_CONFIG
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libXdmcp()
{
	cd libXdmcp
	
	./autogen.sh $XORG_CONFIG
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libpthread-stubs()
{
	cd pthread-stubs
	
	./autogen.sh $XORG_CONFIG
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

xcb-proto()
{
	cd xcb/proto
	
	./autogen.sh $XORG_CONFIG
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

libxcb()
{
	cd xcb/libxcb
	
	./autogen.sh $XORG_CONFIG --enable-xinput --enable-xkb
#	make clean
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
#		make clean
		make
		make install
		ldconfig
	done

	cd $__BASE_DIR__
}

###err
xcb-util()
{
	cd xcb/util
	
	./autogen.sh $XORG_CONFIG
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

mesa()
{
	cd mesa/mesa
	
	./autogen.sh $XORG_CONFIG --enable-xcb
#	make clean
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
		./autogen.sh $XORG_CONFIG
#		make clean
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
#	make clean
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
#	make clean
	make
	make install
	ldconfig

	cd $__BASE_DIR__
}

driver()
{
	cd driver

	__DRIVER_BASE_DIR__=$__BASE_DIR__/driver
	for package in $(ls)
	do
		cd $__DRIVER_BASE_DIR__/$package
		./autogen.sh $XORG_CONFIG
#		make clean
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

util_macros
proto
makedepend
libXau
libXdmcp
libpthread-stubs
xcb-proto
libxcb
libs
xcb-util
mesa
apps
xcursor-themes
fonts
xkeyboard-config
xserver
driver
xterm

cp 50-wacom.conf $XORG_ETC/X11

