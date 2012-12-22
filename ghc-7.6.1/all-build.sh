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
	__cfg --prefix=/usr --sysconfdir=/etc

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__freeglut()
{
	__wget http://downloads.sourceforge.net/freeglut/freeglut-2.8.0.tar.gz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/freeglut-2.8.0-remove_smooth_opengl3_demo-1.patch

	__dcd freeglut-2.8.0
	patch -Np1 -i $SRC_DIR/freeglut-2.8.0-remove_smooth_opengl3_demo-1.patch

	__bld-common
}

__cabal-install()
{
	__wget http://hackage.haskell.org/packages/archive/cabal-install/1.16.0.2/cabal-install-1.16.0.2.tar.gz
	__dcd cabal-install-1.16.0.2
	sh ./bootstrap.sh

	cabal update
}

__ghc()
{
	__wget http://www.haskell.org/ghc/dist/7.6.1/ghc-7.6.1-src.tar.bz2

	__decord ghc-7.6.1-src
	__cd ghc-7.6.1

	__cfg --prefix=/usr --sysconfdir=/etc
	__mk
	__mk install
}

__all()
{
#	__rem() {
	__freeglut
	__cabal-install
	__ghc
}

__init-env
$@

