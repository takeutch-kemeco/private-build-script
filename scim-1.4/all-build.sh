#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__init-env()
{
	echo
}

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc $@

	$MAKE_CLEAN
	__mk
	__mk install
}

__common()
{
	__dcd $1
	__bld-common
}

__scim()
{
#	__wget http://downloads.sourceforge.net/project/scim/scim/1.4.14/scim-1.4.14.tar.gz
	__dcd scim-1.4.14
	__bld-common --with-gtk-version=2

	__scim-config-gtk()
	{
		IM_SCIM_PATH="\"\/usr\/lib\/gtk-2.0\/2.10.0\/immodules\/im-scim.so\""
		IM_SCIM_PARAM="\"scim\" \"SCIM Input Method\" \"gtk20\" \"\/usr\/share\/locale\" \"ja\""

		grep "im-scim.so" /etc/gtk-2.0/gtk.immodules
		if [ $? -ne 0 ]
		then
			echo -e "\nim-scim.so\nSCIM Input Method" >> /etc/gtk-2.0/gtk.immodules
		fi

		cp -v /etc/gtk-2.0/gtk.immodules{,.orig}
		sed 	-e "s/^.*im-scim.so.*$/${IM_SCIM_PATH}/g" 		\
		    	-e "s/^.*SCIM Input Method.*$/${IM_SCIM_PARAM}/g"	\
                       	/etc/gtk-2.0/gtk.immodules.orig > /etc/gtk-2.0/gtk.immodules
	}

	__scim-config-env()
	{
		grep XMODIFIERS /etc/profile
		if [ $? -ne 0 ]
		then
			echo "export XMODIFIERS=@im=SCIM" >> /etc/profile
		fi

		grep GTK_IM_MODULE /etc/profile
		if [ $? -ne 0 ]
		then
			echo "export GTK_IM_MODULE=\"scim\"" >> /etc/profile
		fi

		grep -e "scim *-d" /etc/profile
		if [ $? -ne 0 ]
		then
			echo "scim -d" >> /etc/profile
		fi
	}

	__scim-config-gtk
	__scim-config-env
}

__scim-anthy()
{
#	__wget http://jaist.dl.sourceforge.jp/scim-imengine/37309/scim-anthy-1.2.7.tar.gz
	__common scim-anthy-1.2.7
}

__anthy()
{
#	__wget http://jaist.dl.sourceforge.jp/anthy/37536/anthy-9100h.tar.gz
	__common anthy-9100h
}

__init-env

__all()
{
#	__rem() {
	__scim
	__anthy
	__scim-anthy
}

$@

