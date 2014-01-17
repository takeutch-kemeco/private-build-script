#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__python33()
{
    __wget http://www.python.org/ftp/python/3.3.3/Python-3.3.3.tar.xz
    __dcd Python-3.3.3
### sed -i "s/ndbm_libs = \[\]/ndbm_libs = ['gdbm', 'gdbm_compat']/" setup.py
    __bld-common --enable-shared --with-system-expat --with-system-ffi
    sudo chmod -v 755 /usr/lib/libpython3.3m.so
    sudo chmod -v 755 /usr/lib/libpython3.so
    sudo ln -sf /usr/bin/python /usr/bin/python3
    sudo ldconfig

    __python33-doc()
    {
        __wget http://docs.python.org/ftp/python/doc/3.3.3/python-3.3.3-docs-html.tar.bz2
        sudo install -v -m755 -d /usr/share/doc/Python-3.3.3/html

	sudo tar -xvf --strip-components=1 --no-same-owner --no-same-permissions \
    	         -C /usr/share/doc/Python-3.3.3/html \
    	         ${SRC_DIR}/python-3.3.3-docs-html.tar.bz2

	grep PYTHONDOCS /etc/profile
	if [ $? -ne 0 ]
	then
cat >> /etc << .

export PYTHONDOCS=/usr/share/doc/Python-3.3.3/html

.
	fi
    }

    __python33-doc
}

__pycairo()
{
    __git-clone git://git.cairographics.org/git/pycairo
    __cd pycairo
    ./waf configure --prefix=/usr
    ./waf build
    sudo ./waf install
}

__pygobject3()
 {
    __git-clone git://git.gnome.org/pygobject
    __common pygobject
}

__pygtk3()
{
    __git-clone git://git.gnome.org/pygtk
    __cd pygtk
    __autogen
    __bld-common
}

__pyatspi2() {
    __git-clone git://git.gnome.org/pyatspi2
    __common pyatspi2
}

__all()
{
#	__rem() {
	__python33
        __pycairo
        __pygobject3
###     __pygtk3
        __pyatspi2
}

$@

