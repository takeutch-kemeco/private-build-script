#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__git-clean()
{
	git clone . b
	cp b/* . -rf
	rm b -rf
	git checkout master
	git pull
}

__dbus()
{
	__cd dbus
	__git-clean

	git checkout origin/dbus-1.6
	git checkout -b 1.6
	git checkout 1.6

	groupadd -g 27 messagebus
	useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 27 -g messagebus -s /bin/false messagebus

	$DIST_CLEAN
	./autogen.sh
#	cmake -DCMAKE_INSTALL_PREFIX=/prefix
	__cfg --prefix=/usr				\
              --sysconfdir=/etc 			\
              --localstatedir=/var 			\
              --libexecdir=/usr/lib/dbus-1.0 		\
              --with-console-auth-dir=/run/console/ 	\
              --without-systemdsystemunitdir 		\
              --disable-systemd 			\
              --disable-static				\
              --disable-Werror				\
	      --disable-tests

	$MAKE_CLEAN
#	__mk
#	__mk install
	make
	make install
	ldconfig

	dbus-uuidgen --ensure

cat > /etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF
}

__dbus-glib()
{
	__cd dbus-glib
	__git-clean

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr	             \
              --sysconfdir=/etc	             \
              --libexecdir=/usr/lib/dbus-1.0 \
	      --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#__rem(){
        __dbus
        __dbus-glib
}

$@
