#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	./autogen.sh
	./configure --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__pciutils() {
	cd $BASE_DIR/pciutils
	$MAKE_CLEAN
	__mk PREFIX=$PREFIX ZLIB=no
	__mk PREFIX=$PREFIX install
	__mk PREFIX=$PREFIX install-lib
	ldconfig
}

__usbutils() {
	cd $BASE_DIR/usbutils-005
	./autogen.sh --prefix=$PREFIX --enable-maintainer-mode
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gusb()
{
	__common $BASE_DIR/gusb
}

__consolekit()
{
	__common $BASE_DIR/ConsoleKit
}

__colord()
{
	cd $BASE_DIR/colord
	./autogen.sh --prefix=$PREFIX --enable-gtk --enable-sane --enable-gtk-doc
	$MAKE_CLEAN
	__mk CPPFLAGS="-Wall"
	__mk install
	ldconfig
}

__expat() {
	cd $BASE_DIR/expat
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libva() {
	cd $BASE_DIR/libva
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__intel-driver()
{
	cd $BASE_DIR/intel-driver

	./autogen.sh --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install

	grep "/usr/lib/dri" /etc/ld.so.conf
	if [ $? -ne 0 ]
	then
		echo "/usr/lib/dri" >> /etc/ld.so.conf
	fi

	ldconfig
}

__polkit()
{
	cd $BASE_DIR/polkit

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
	__mk
	__mk install
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
	cd $BASE_DIR/pyxdg
	python setup.py install
}

__shared-mime-info()
{
	cd $BASE_DIR/shared-mime-info
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__telepathy-glib()
{
	cd $BASE_DIR/telepathy-glib
	./autogen.sh --prefix=$PREFIX --enable-gtk-doc --disable-fatal-warnings
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__telepathy-logger()
{
	cd $BASE_DIR/telepathy-logger
	./autogen.sh --prefix=$PREFIX --enable-gtk-doc --disable-fatal-warnings --enable-debug
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__upower()
{
	cd $BASE_DIR/upower
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

}

__xdg-utils()
{
	cd $BASE_DIR/xdg-utils
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__desktop-file-utils() {
	cd $BASE_DIR/desktop-file-utils
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	update-desktop-database $PREFIX/share/applications

### memo ###
### /etc/bashrc ###
# XDG_DATA_DIRS=/usr/share
# XDG_CONFIG_DIRS=/etc/xdg
# export XDG_DATA_DIRS XDG_CONFIG_DIRS
}

__liboil() {
	cd $BASE_DIR/liboil
	./autogen.sh
	./configure --prefix=/usr
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__default-icon-theme()
{
	__common $BASE_DIR/default-icon-theme
}

__tango-icon-theme()
{
	__common $BASE_DIR/tango-icon-theme
}

#__rem(){
__desktop-file-utils
__pciutils
__usbutils
__gusb
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
__upower
__xdg-utils
__liboil
__default-icon-theme
__tango-icon-theme

