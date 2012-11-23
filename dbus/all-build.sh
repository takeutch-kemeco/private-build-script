#!/bin/bash

BASE_DIR=$(pwd)

MAKE_CLEAN=
#MAKE_CLEAN="make distclean && make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__dbus()
{
	__cd $BASE_DIR/dbus

	groupadd -g 27 messagebus &&
	useradd -c "D-Bus Message Daemon User" -d /var/run/dbus \
		-u 27 -g messagebus -s /bin/false messagebus

	./autogen.sh
	./configure --prefix=/usr	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/dbus-1.0 \
            	--with-console-auth-dir=/run/console/ \
            	--without-systemdsystemunitdir \
            	--disable-systemd 	\
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__dbus-glib()
{
	__cd $BASE_DIR/dbus-glib

	./autogen.sh
	./configure --prefix=/usr	\
            	--sysconfdir=/etc	\
            	--libexecdir=/usr/lib/dbus-1.0 \
		--disable-static

	__mk
	__mk install
}

#__rem(){
__dbus
__dbus-glib

