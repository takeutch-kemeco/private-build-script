#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__sane-backends()
{
	groupadd -g 70 scanner

	__cd $BASE_DIR/sane-backends

	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--with-group=scanner	\
            	--localstatedir=/var

	__mk
	__mk install
	ldconfig

	install -m 644 -v tools/udev/libsane.rules /etc/udev/rules.d/65-scanner.rules
}

__sane-frontends()
{
	__cd $BASE_DIR/sane-frontends

	./configure --prefix=$PREFIX

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

	./configure --prefix=$PREFIX

	__mk
	__mkmake xsanedocdir=/usr/share/doc/xsane-0.998 install
	ldconfig

	ln -v -s ../../doc/xsane-0.998 /usr/share/sane/xsane/doc 
	ln -v -s firefox /usr/bin/netscape

	ln -v -s /usr/bin/xsane /usr/lib/gimp/2.0/plug-ins/
}

#__rem(){
__sane-backends
__sane-frontends
__xsane

