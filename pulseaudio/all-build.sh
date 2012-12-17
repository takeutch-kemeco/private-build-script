#!/bin/bash

BASE_DIR=$(pwd)

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libsndfile()
{
	__common $BASE_DIR/libsndfile
}

__pulseaudio()
{
	__cd $BASE_DIR/pulseaudio

	groupadd -g 58 pulse
	groupadd -g 59 pulse-access
	useradd -c "Pulseaudio User" -d /var/run/pulse -g pulse -s /bin/false -u 58 pulse
	usermod -a -G audio pulse

	find . -name "Makefile.in" | xargs sed -i "s|(libdir)/@PACKAGE@|(libdir)/pulse|"

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib	\
            	--with-module-dir=/usr/lib/pulse/modules

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
__libsndfile
__pulseaudio
}

$@

