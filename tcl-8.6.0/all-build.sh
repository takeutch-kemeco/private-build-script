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
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__tcl()
{
	__wget http://downloads.sourceforge.net/tcl/tcl8.6.0-src.tar.gz
	__wget http://downloads.sourceforge.net/tcl/tcl8.6.0-html.tar.gz

	__decord tcl8.6.0-src
	__cd tcl8.6.0
	tar -xf ${SRC_DIR}/tcl8.6.0-html.tar.gz --strip-components=1

	cd unix

	$DIST_CLEAN
	__cfg --prefix=/usr 					\
              --mandir=/usr/share/man				\
              $([ $(uname -m) = x86_64 ] && echo --enable-64bit)

	$MAKE_CLEAN
	__mk
	sed -e "s@^\(TCL_SRC_DIR='\).*@\1/usr/include'@" \
    	    -e "/TCL_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    	    -i tclConfig.sh

	__mk install
	__mk install-private-headers
	ln -v -sf tclsh8.6 /usr/bin/tclsh
	chmod -v 755 /usr/lib/libtcl8.6.so

	ldconfig
}

__tk()
{
	__wget http://downloads.sourceforge.net/tcl/tk8.6.0-src.tar.gz
	__decord tk8.6.0-src
	__cd tk8.6.0/unix

	$DIST_CLEAN
	__cfg --prefix=/usr 					\
              --mandir=/usr/share/man 				\
              $([ $(uname -m) = x86_64 ] && echo --enable-64bit)

	$MAKE_CLEAN
	__mk
	sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
    	    -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
            -i tkConfig.sh

	__mk install
	__mk install-private-headers
	ln -v -sf wish8.6 /usr/bin/wish
	chmod -v 755 /usr/lib/libtk8.6.so

	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__all()
{
#__rem() {
	__tcl
	__tk
}

__init-env
$@

