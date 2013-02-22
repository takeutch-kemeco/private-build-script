#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__sane-backends()
{
	__wget ftp://ftp2.sane-project.org/pub/sane/sane-backends-1.0.23.tar.gz
	__dcd sane-backends-1.0.23

	groupadd -g 70 scanner

	$DIST_CLEAN
	__cfg --prefix=/usr					\
              --sysconfdir=/etc					\
	      --localstatedir=/var				\
	      --with-docdir=/usr/share/doc/sane-backend-1.0.23	\
              --with-group=scanner

	$MAKE_CLEAN
	__mk
	__mk install

	install -m 644 -v tools/udev/libsane.rules /etc/udev/rules.d/65-scanner.rules
	chgrp -v scanner /var/lock/sane

	ldconfig
}

__sane-frontends()
{
	__wget ftp://ftp2.sane-project.org/pub/sane/sane-frontends-1.0.14.tar.gz
	__dcd sane-frontends-1.0.14

	sed -i -e "/SANE_CAP_ALWAYS_SETTABLE/d" src/gtkglue.c

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk install
	install -v -m644 doc/sane.png xscanimage-icon-48x48-2.png /usr/share/sane

	ln -v -s ../../../../bin/xscanimage /usr/lib/gimp/2.0/plug-ins

	ldconfig
}

__xsane()
{
	__wget http://www.xsane.org/download/xsane-0.998.tar.gz
	__dcd xsane-0.998

	sed -i -e 's/netscape/xdg-open/'                   src/xsane.h
	sed -i -e 's/png_ptr->jmpbuf/png_jmpbuf(png_ptr)/' src/xsane-save.c

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk xsanedocdir=/usr/share/doc/xsane-0.998 install
	ldconfig

	ln -v -s ../../doc/xsane-0.998 /usr/share/sane/xsane/doc 
	ln -v -s firefox /usr/bin/netscape

	ln -v -s /usr/bin/xsane /usr/lib/gimp/2.0/plug-ins/
}

__all()
{
#__rem(){
__sane-backends
__sane-frontends
__xsane
}

$@

