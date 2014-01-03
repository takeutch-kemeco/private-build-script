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
        patch -p1 < ../scim-1.4.14-gtk-immodule-default-setting.patch
	__bld-common --with-gtk-version=2

        gtk-query-immodules-2.0 --update-cache

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
	__dcd anthy-9100h
        patch -p1 < ../anthy-9100h-emacs23-input.patch
        __bld-common
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

