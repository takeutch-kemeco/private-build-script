#!/bin/bash

__BASE_DIR__=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

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

	groupadd -fg 28 polkitd
	useradd -c "PolicyKit Daemon Owner" \
		-d /etc/polkit-1 \
		-u 28 \
		-g polkitd \
		-s /bin/false polkitd

	./autogen.sh --prefix=$PREFIX \
            	--sysconfdir=/etc \
            	--localstatedir=/var \
            	--libexecdir=$PREFIX/lib/polkit-1 \
            	--with-authfw=shadow \
            	--disable-static
	$MAKE_CLEAN
	make
	make install
	ldconfig

cat > /etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF
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

__desktop-file-utils() {
	cd $__BASE_DIR__/desktop-file-utils
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	update-desktop-database $PREFIX/share/applications

### memo ###
### /etc/bashrc ###
# XDG_DATA_DIRS=/usr/share
# XDG_CONFIG_DIRS=/etc/xdg
# export XDG_DATA_DIRS XDG_CONFIG_DIRS
}

__liboil() {
	cd $__BASE_DIR__/liboil
	./autogen.sh
	./configure --prefix=/usr
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
__liboil

