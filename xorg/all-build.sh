#!/bin/bash

BASE_DIR=$(pwd)

XORG_PREFIX=/usr
XORG_ETC=/etc
XORG_CONFIG="--prefix=$XORG_PREFIX \
	--sysconfdir=$XORG_ETC \
	--mandir=$XORG_PREFIX/share/man \
	--localstatedir=/var"
export XORG_PREFIX XORG_ETC XORG_CONFIG

#MAKE_CLEAN=
MAKE_CLEAN="__mk clean"

#DIST_CLEAN=
DIST_CLEAN="__mk distclean"

. ../common-func/__common-func.sh

__util_macros()
{
	__cd $BASE_DIR/macros

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__proto()
{
	__cd $BASE_DIR/proto

	__PROTO_BASE_DIR__=$BASE_DIR/proto
	for package in $(__lsdir)
	do
		__cd $__PROTO_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG
			$MAKE_CLEAN
			__mk
			__mk install
			ldconfig
		fi
	done
}

__makedepend()
{
	__cd $BASE_DIR/makedepend

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__fontutil()
{
	__cd $BASE_DIR/fontutil

	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libXau()
{
	__cd $BASE_DIR/libXau
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libXdmcp()
{
	__cd $BASE_DIR/libXdmcp
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libpthread-stubs()
{
	__cd $BASE_DIR/pthread-stubs
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-proto()
{
	__cd $BASE_DIR/xcb/proto
	
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxcb()
{
	__cd $BASE_DIR/xcb/libxcb
	
	./autogen.sh $XORG_CONFIG --enable-xinput --enable-xkb --with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxkbcommon()
{
	__cd $BASE_DIR/libs/libxkbcommon

	./autogen.sh $XORG_CONFIG --with-xkb-config-root=/usr/share/X11/xkb
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libs()
{
	__cd $BASE_DIR/libs

	__LIBS_BASE_DIR__=$BASE_DIR/libs
	for package in $(__lsdir)
	do
		if [ $package = "libxkbcommon" ]
		then
			__libxkbcommon
		else
			__cd $__LIBS_BASE_DIR__/$package
			if [ $? -eq 0 ]
			then
				./autogen.sh $XORG_CONFIG
				$MAKE_CLEAN
				__mk
				__mk install
				ldconfig
			fi
		fi
	done
}

__xcb-util-common-m4()
{
	__cd $BASE_DIR/xcb/util-common-m4
}

__xcb-util()
{
	__cd $BASE_DIR/xcb/util

	rm $BASE_DIR/xcb/util/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-util-image()
{
	__cd $BASE_DIR/xcb/util-image

	rm $BASE_DIR/xcb/util-image/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-image/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-util-keysyms()
{
	__cd $BASE_DIR/xcb/util-keysyms

	rm $BASE_DIR/xcb/util-keysyms/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-keysyms/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-util-renderutil()
{
	__cd $BASE_DIR/xcb/util-renderutil

	rm $BASE_DIR/xcb/util-renderutil/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-renderutil/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-util-wm()
{
	__cd $BASE_DIR/xcb/util-wm

	rm $BASE_DIR/xcb/util-wm/m4 -rf
	ln -s $BASE_DIR/xcb/util-common-m4 $BASE_DIR/xcb/util-wm/m4
	
	./autogen.sh $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__mesa-drm()
{
	__cd $BASE_DIR/mesa/drm
	
	./autogen.sh $XORG_CONFIG --disable-radeon --disable-nouveau --enable-udev
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__mesa()
{
	__cd $BASE_DIR/mesa/mesa

	./autogen.sh
	./configure $XORG_CONFIG	\
		--enable-texture-float 	\
		--enable-gles1 		\
		--enable-gles2 		\
		--enable-xa 		\
		--enable-shared-glapi 	\
		--enable-shared-dricore \
		--enable-glx-tls 	\
		--with-gallium-drivers=i915 \
		--with-dri-drivers=i965 \
		--enable-dri 		\
		--with-x 		\
		--enable-gallium-egl 	\
		--enable-glx 		\

#		--enable-xorg		\

	$MAKE_CLEAN
	__mk
	__mk install

	for GLHEADER in EGL GL GLES GLES2 KHR xa_composite.h xa_context.h xa_tracker.h
	do
		ln -sfv ${XORG_PREFIX}/include/${GLHEADER} /usr/include/${GLHEADER}
	done

	ldconfig
}

__data()
{
	__cd $BASE_DIR/data

	__SUB_BASE_DIR__=$BASE_DIR/data
	for package in $(__lsdir)
	do
		__cd $__SUB_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG \
				--with-xinitdir=$XORG_ETC/X11/app-defaults \
				--disable-selective-werror

			$MAKE_CLEAN
			__mk
			__mk install
			ldconfig
		fi
	done
}


__apps()
{
	__cd $BASE_DIR/apps

	__SUB_BASE_DIR__=$BASE_DIR/apps
	for package in $(__lsdir)
	do
		__cd $__SUB_BASE_DIR__/$package
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

__xhost()
{
	__cd $BASE_DIR/apps/xhost

	./autogen.sh $XORG_CONFIG \
		--with-xinitdir=$XORG_ETC/X11/app-defaults
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcursor-themes()
{
	__SUB_BASE_DIR__=$BASE_DIR/xcursor-themes
	SRC=$__SUB_BASE_DIR__
	__dcd xcursor-themes-1.0.3
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__fonts()
{
	__cd $BASE_DIR/fonts

	__SUB_BASE_DIR__=$BASE_DIR/fonts
	SRC=$__SUB_BASE_DIR__
	for __package in $(__lsdir)
	do
		package=$(echo $__package | sed -e "s/\.tar\..*$//g")
		__dcd $__SUB_BASE_DIR__/$package

		if [ $? -eq 0 ]
		then
			./configure $XORG_CONFIG
			$MAKE_CLEAN
			__mk
			__mk install
			ldconfig
		fi
	done
}

__xkeyboard-config()
{
	__cd $BASE_DIR/xkeyboard-config
	
	./autogen.sh $XORG_CONFIG \
		--with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xserver()
{
	__cd $BASE_DIR/xserver
	
	./autogen.sh $XORG_CONFIG \
		--with-module-dir=$XORG_PREFIX/lib/X11/modules \
		--with-xkb-output=/var/lib/xkb \
		--enable-install-setuid
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__driver()
{
	echo "/usr/lib/xorg/modules/drivers"  \
		> /etc/ld.so.conf.d/xorg_modules_drivers.conf

	__cd $BASE_DIR/driver

	__DRIVER_BASE_DIR__=$BASE_DIR/driver
	for package in $(__lsdir)
	do
		__cd $__DRIVER_BASE_DIR__/$package
		if [ $? -eq 0 ]
		then
			./autogen.sh $XORG_CONFIG
			$MAKE_CLEAN
			__mk
			__mk install
			ldconfig
		fi
	done
}

__twm()
{
	__cd $BASE_DIR/twm

	sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in
	./autogen.sh $XORG_CONFIG
	__mk
	__mk install
	ldconfig
}

__xterm()
{
	__cd $BASE_DIR/xterm

	sed -i '/v0/,+1s/new:/new:kb=^?:/' termcap &&
	echo -e '\tkbs=\\177,' >>terminfo &&
	TERMINFO=$XORG_PREFIX/lib/terminfo ./configure $XORG_CONFIG \
		--enable-luit --enable-wide-chars \
		--with-app-defaults=/etc/X11/app-defaults &&
	__mk
	__mk install
	__mk install-ti

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

__rem(){
__util_macros
__proto
__makedepend
__fontutil
__libXau
__libXdmcp
__libpthread-stubs

__xcb-proto
__libxcb

__libs

__xcb-util-common-m4
__xcb-util
__xcb-util-image
__xcb-util-keysyms
__xcb-util-renderutil
__xcb-util-wm

__mesa-drm
__mesa

}
__data
__apps
__xcursor-themes
__fonts
__xkeyboard-config
__xserver
__driver
__twm
__xterm

cp $BASE_DIR/50-wacom.conf $XORG_ETC/X11/xorg.conf.d/

