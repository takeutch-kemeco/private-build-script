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

__python33()
{
	__wget http://www.python.org/ftp/python/3.3.0/Python-3.3.0.tar.xz
	__wget http://docs.python.org/ftp/python/doc/3.3.0/python-3.3.0-docs-html.tar.bz2
	__dcd Python-3.3.0

	sed -i "s/ndbm_libs = \[\]/ndbm_libs = ['gdbm', 'gdbm_compat']/" setup.py
	__cfg --prefix=/usr		\
              --enable-shared     	\
              --with-system-expat	\
              --with-system-ffi

	__mk

	__mk install
	chmod -v 755 /usr/lib/libpython3.3m.so
	chmod -v 755 /usr/lib/libpython3.so
	ldconfig

	install -v -m755 -d /usr/share/doc/Python-3.3.0/html

	tar --strip-components=1 			\
    	    --no-same-owner 				\
    	    --no-same-permissions 			\
    	    -C /usr/share/doc/Python-3.3.0/html 	\
    	    -xvf ${SRC_DIR}/python-3.3.0-docs-html.tar.bz2

	grep PYTHONDOCS /etc/profile
	if [ $? -ne 0 ]
	then
cat >> /etc << .

export PYTHONDOCS=/usr/share/doc/Python-3.3.0/html

.
	fi
}

__all()
{
#	__rem() {
	__python33
}

__init-env
$@

