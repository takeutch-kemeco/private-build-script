#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ../common-func/__common-func.sh

__sane-backends()
{
	groupadd -g 70 scanner

	__cd $BASE_DIR/sane-backends

	$DIST_CLEAN
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--with-group=scanner	\
            	--localstatedir=/var

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -m 644 -v tools/udev/libsane.rules /etc/udev/rules.d/65-scanner.rules
}

__sane-frontends()
{
	__cd $BASE_DIR/sane-frontends

	$DIST_CLEAN
	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m644 doc/sane.png xscanimage-icon-48x48-2.png /usr/share/sane

	ln -v -s ../../../../bin/xscanimage /usr/lib/gimp/2.0/plug-ins
}

__xsane()
{
	__cd $BASE_DIR/xsane

	sed -i -e 's/png_ptr->jmpbuf/png_jmpbuf(png_ptr)/' src/xsane-save.c

	$DIST_CLEAN
	./configure --prefix=$PREFIX

	$MAKE_CLEAN
	__mk
	__mkmake xsanedocdir=/usr/share/doc/xsane-0.998 install
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

