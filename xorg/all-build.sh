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

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__util_macros()
{
	__cd $BASE_DIR/macros

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
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
			$DIST_CLEAN
			./autogen.sh
			./configure $XORG_CONFIG
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

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__fontutil()
{
	__cd $BASE_DIR/fontutil

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libXau()
{
	__cd $BASE_DIR/libXau
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libXdmcp()
{
	__cd $BASE_DIR/libXdmcp
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libpthread-stubs()
{
	__cd $BASE_DIR/pthread-stubs
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xcb-proto()
{
	__cd $BASE_DIR/xcb/proto
	
	$DIST_CLEAN
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG --enable-xinput --enable-xkb --with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxkbcommon()
{
	__cd $BASE_DIR/libs/libxkbcommon

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG --with-xkb-config-root=/usr/share/X11/xkb
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libs()
{
	__common $BASE_DIR/libs/libFS
        __common $BASE_DIR/libs/libXaw
        __common $BASE_DIR/libs/libXfixes
        __common $BASE_DIR/libs/libXmu
        __common $BASE_DIR/libs/libXt
        __common $BASE_DIR/libs/libXxf86vm
        __common $BASE_DIR/libs/libxkbfile
        __common $BASE_DIR/libs/libICE
        __common $BASE_DIR/libs/libXcomposite
        __common $BASE_DIR/libs/libXfont
        __common $BASE_DIR/libs/libXp
        __common $BASE_DIR/libs/libXtst
        __common $BASE_DIR/libs/libdmx
        __common $BASE_DIR/libs/libxkbui
        __common $BASE_DIR/libs/libSM
        __common $BASE_DIR/libs/libXcursor
        __common $BASE_DIR/libs/libXfontcache
        __common $BASE_DIR/libs/libXpm
        __common $BASE_DIR/libs/libXv
        __common $BASE_DIR/libs/libfontenc
        __common $BASE_DIR/libs/libxtrans
        __common $BASE_DIR/libs/libX11
        __common $BASE_DIR/libs/libXdamage
        __common $BASE_DIR/libs/libXft
        __common $BASE_DIR/libs/libXrandr
        __common $BASE_DIR/libs/libXvMC
        __common $BASE_DIR/libs/liblbxutil
        __common $BASE_DIR/libs/pixman
        __common $BASE_DIR/libs/libXRes
        __common $BASE_DIR/libs/libXevie
        __common $BASE_DIR/libs/libXi
        __common $BASE_DIR/libs/libXrender
        __common $BASE_DIR/libs/libXxf86dga
        __common $BASE_DIR/libs/libpciaccess
        __common $BASE_DIR/libs/libXScrnSaver
        __common $BASE_DIR/libs/libXext
        __common $BASE_DIR/libs/libXinerama
        __common $BASE_DIR/libs/libXxf86misc
        __libxkbcommon
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__mesa-drm()
{
	__cd $BASE_DIR/mesa/drm
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG --disable-radeon --disable-nouveau --enable-udev
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__mesa()
{
	__cd $BASE_DIR/mesa/mesa

	$DIST_CLEAN
	./autogen.sh
	./configure				\
		--prefix=/usr                	\
            	--sysconfdir=/etc              	\
            	--enable-texture-float         	\
            	--enable-gles1                 	\
            	--enable-gles2                 	\
            	--enable-openvg                	\
		--enable-osmesa			\
            	--enable-xa                    	\
            	--enable-gbm                   	\
            	--enable-gallium-egl           	\
            	--enable-gallium-gbm           	\
            	--enable-glx-tls               	\
            	--with-egl-platforms="drm,x11" 	\
            	--with-gallium-drivers="i915"	\
		--with-dri-drivers="i965"	\

	$MAKE_CLEAN
	__mk
	__mk -C xdemos DEMOS_PREFIX=/usr

	for GLHEADER in EGL GL GLES GLES2 KHR xa_composite.h xa_context.h xa_tracker.h
	do
		ln -sfv ${XORG_PREFIX}/include/${GLHEADER} /usr/include/${GLHEADER}
	done

	__mk install
	ldconfig

	__mk -C xdemos DEMOS_PREFIX=/usr install

	install -v -dm755 /usr/share/doc/MesaLib
	cp -rfv docs/* /usr/share/doc/MesaLib

	__mesa-glu()
	{
		__cd $BASE_DIR/mesa/glu

		$DIST_CLEAN
		./autogen.sh
		./configure --prefix=/usr --disable-static

		$MAKE_CLEAN
		__mk
		__mk install
		ldconfig
	}

	__mesa-glu
}

__xcursorgen()
{
	__common $BASE_DIR/apps/xcursorgen
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
			$DIST_CLEAN
			./autogen.sh
			./configure $XORG_CONFIG \
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
			$DIST_CLEAN
			./autogen.sh
			./configure $XORG_CONFIG \
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

	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG \
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
	$DIST_CLEAN
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
			$DIST_CLEAN
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
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG \
		--with-xkb-rules-symlink=xorg
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xserver()
{
	__cd $BASE_DIR/xserver
	
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG \
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
			$DIST_CLEAN
			./autogen.sh
			./configure $XORG_CONFIG
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
	$DIST_CLEAN
	./autogen.sh
	./configure $XORG_CONFIG
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xterm()
{
	__cd $BASE_DIR/xterm

	$DIST_CLEAN
	sed -i '/v0/,+1s/new:/new:kb=^?:/' termcap &&
	echo -e '\tkbs=\\177,' >>terminfo &&
	TERMINFO=$XORG_PREFIX/lib/terminfo ./configure $XORG_CONFIG \
		--enable-luit --enable-wide-chars \
		--with-app-defaults=/etc/X11/app-defaults
	$MAKE_CLEAN
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

__xorg-docs()
{
	__common $BASE_DIR/xorg-docs
}

__xcursor-themes()
{
	__common $BASE_DIR/xcursor-themes
}

__xkeyboard-config()
{
	__cd $BASE_DIR/xkeyboard-config

	./configure $XORG_CONFIG --with-xkb-rules-symlink=xorg

	__mk
	__mk install
}

__all()
{
#__rem(){
__xorg-docs
__xcursor-themes
__xkeyboard-config

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

__xcursorgen
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
}

$@

