#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ./__common-func.sh

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib --enable-extra-warnings=no $@

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

__linux-fusion()
{
	__wget http://directfb.org/downloads/Core/linux-fusion/linux-fusion-9.0.0.tar.gz
	__dcd linux-fusion-9.0.0

	$MAKE_CLEAN
	__mk

	if [ $? -ne 0 ]
	then
		__err "カーネルソースのバージョンが rc の場合は、implicet-declaration エラーでビルド失敗するかもしれません。それが原因の場合はカーネルソースのバージョンをリリース版へ checkout してから行えばビルドが通るかもしれません。"
	fi

	__mk install
	ldconfig

	cat > /etc/udev/rules.d/40-one.rules << .
KERNEL=="one[0-9]*", NAME="one/%n", GROUP="video", MODE="0660"
.

}

__flux()
{
	__wget http://directfb.org/downloads/Core/flux/flux-1.4.3.tar.gz
	__dcd flux-1.4.3
	__bld-common
}

__direct-fb()
{
	__wget http://directfb.org/downloads/Core/DirectFB-1.6/DirectFB-1.6.3.tar.gz
	__dcd DirectFB-1.6.3
	__bld-common --enable-egl=no --enable-mesa --enable-jpeg --enable-zlib --enable-png --enable-gstreamer=no \
                     --with-smooth-scaling --enable-one	--with-gfxdrivers=i810,i830 --enable-fbdev --enable-voodoo
}

__fusion-sound()
{
	__wget http://directfb.org/downloads/Core/FusionSound/FusionSound-1.6.3.tar.gz
	__dcd FusionSound-1.6.3
	__bld-common --with-voodoo --enable-static --without-examples --enable-maintainer-mode --with-ffmpeg=no
}

__fusion-dale()
{
	__wget http://directfb.org/downloads/Libs/FusionDale-1.6.3.tar.gz
	__dcd FusionDale-1.6.3
	__bld-common
}

__sawman()
{
	__wget http://directfb.org/downloads/Extras/SaWMan-1.6.3.tar.gz
	__dcd SaWMan-1.6.3
	__bld-common
}

__all()
{
#__rem(){
	__linux-fusion
	__flux
	__direct-fb
	__fusion-sound
	__fusion-dale
	__sawman
}

$@

