#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__pmk()
{
    python2 setup.py clean	
    python2 setup.py build $@
    if [ $? -ne 0 ]
    then
	__err
    fi
}

__pmkinst()
{
    sudo python2 setup.py install --prefix=/usr $@
}

__python27()
{
    __wget https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
    __dcd Python-2.7.6
    __bld-common --enable-shared --with-system-ffi
}

__pyxml()
{
    __wget -c ftp://mirror.ovh.net/gentoo-distfiles/distfiles/PyXML-0.8.4.tar.gz
    __dcd PyXML-0.8.4
    __pmk
    __pmkinst
    sudo install -v -m644 doc/man/xmlproc_*.1 /usr/share/man/man1
    sudo install -v -m755 -d /usr/share/doc/PyXML-0.8.4
    sudo cp -v -R doc demo test /usr/share/doc/PyXML-0.8.4
    sudo install -v -m644 README* /usr/share/doc/PyXML-0.8.4
}

__py2cairo() {
    __git-clone git://git.cairographics.org/git/py2cairo
    __cd py2cairo
    ./waf configure --prefix=/usr
    ./waf build
    sudo ./waf install
}

__pygobject2() {
    __wget http://ftp.gnome.org/pub/GNOME/sources/pygobject/2.28/pygobject-2.28.6.tar.xz
    __dcd pygobject-2.28.6
    __patch ${BASE_DIR}/pygobject-2.28.6-introspection-1.patch
    __bld-common
}

__numpy() {
    __git-clone git://github.com/numpy/numpy.git numpy
    __cd numpy
    __pmk
    __pmkinst
}

__sphinx()
{
    __hg-clone https://bitbucket.org/birkenfeld/sphinx
    __cd sphinx
    __pmk
    __pmkinst
}

__cython()
{
    __wget http://cython.org/release/Cython-0.19.2.tar.gz
    __dcd Cython-0.19.2
    __pmk
    __pmkinst
}

__atlas()
{
    ### __wget atlas3.11.17.tar.bz2
    __decord atlas3.11.17
    __cdbt
    ${BASE_DIR}/ATLAS/configure --prefix=/usr
    __mk
    __mkinst
}

__scipy() {
    __git-clone git://github.com/scipy/scipy.git scipy
    __cd scipy
    __pmk
    __pmkinst
}

__pygtk2() {
    __wget ftp://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2
    __common pygtk-2.24.0
}

__pygtksourceview() {
    __wget http://ftp.gnome.org/pub/gnome/sources/pygtksourceview/2.10/pygtksourceview-2.10.1.tar.bz2
    __dcd pygtksourceview-2.10.1
    __bld-common
}

__pyxdg() {
    __git-clone git://anongit.freedesktop.org/xdg/pyxdg
    __cd pyxdg
    __pmk
    __pmkinst
}

__ipython() {
    __wget http://archive.ipython.org/release/1.1.0/ipython-1.1.0.tar.gz
    __dcd ipython-1.1.0
    __pmk
    __pmkinst
}

__matplotlib() {
    __git-clone git://github.com/matplotlib/matplotlib.git
    __cd matplotlib
    __pmk
    __pmkinst
}

__all()
{
__python27
__pyxml
__py2cairo
__pygobject2
__numpy
__sphinx
__cython
###__atlas
###__scipy
__matplotlib
__pygtk2
__pygtksourceview
__pyxdg
__ipython
}

$@

