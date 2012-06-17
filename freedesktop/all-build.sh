#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__pciutils() {
	cd $__BASE_DIR__/pciutils
	$MAKE_CLEAN
	make PREFIX=$PREFIX ZLIB=no
	make PREFIX=$PREFIX install
	make PREFIX=$PREFIX install-lib
	ldconfig
}

__usbutils() {
	cd $__BASE_DIR__/usbutils-005
	./autogen.sh --prefix=$PREFIX --enable-maintainer-mode
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__consolekit()
{
	cd $__BASE_DIR__/ConsoleKit
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__colord()
{
	cd $__BASE_DIR__/colord
	./autogen.sh --prefix=$PREFIX --enable-gtk --enable-sane --enable-gtk-doc
	$MAKE_CLEAN
	make CPPFLAGS="-Wall"
	make install
	ldconfig
}

__expat() {
	cd $__BASE_DIR__/expat
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__libva() {
	cd $__BASE_DIR__/libva
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__intel-driver()
{
	cd $__BASE_DIR__/intel-driver
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__polkit()
{
	cd $__BASE_DIR__/polkit
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__pyxdg()
{
	cd $__BASE_DIR__/pyxdg
	python setup.py install
}

__shared-mime-info()
{
	cd $__BASE_DIR__/shared-mime-info
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__telepathy-glib()
{
	cd $__BASE_DIR__/telepathy-glib
	./autogen.sh --prefix=$PREFIX --enable-gtk-doc --disable-fatal-warnings
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__telepathy-logger()
{
	cd $__BASE_DIR__/telepathy-logger
	./autogen.sh --prefix=$PREFIX --enable-gtk-doc --disable-fatal-warnings --enable-debug
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__udev()
{
	cd $__BASE_DIR__/udev
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

}

__upower()
{
	cd $__BASE_DIR__/upower
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

}

__xdg-utils()
{
	cd $__BASE_DIR__/xdg-utils
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__pkg-config()
{
	cd $__BASE_DIR__/pkg-config-0.26
	./configure --prefix=$PREFIX \
		--with-installed-popt \
		--with-internal-glib \
		--docdir=/usr/share/doc/pkg-config-0.26-internal-glib
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__desktop-file-utils() {
	cd $__BASE_DIR__/desktop-file-utils
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__test__() {

	exit
}
#__test__

__desktop-file-utils
__pkg-config
__pciutils
__usbutils
__consolekit
__colord
__expat
__libva
__intex-driver
__polkit
__pyxdg
__shared-mime-info
__telepathy-glib
__telepathy-logger
__udev
__upower
__xdg-utils

