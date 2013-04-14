#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__bld-common()
{
	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib --enable-extra-warnings=no $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__linux-fusion()
{
	__cd linux-fusion

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__direct-fb()
{
	__cd DirectFB

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr			\
	      --sysconfdir=/etc			\
	      --localstatedir=/var		\
	      --libexecdir=/usr/lib		\
  	      --enable-x11 			\
  	      --enable-egl=no 			\
  	      --enable-sdl 			\
  	      --enable-mesa 			\
  	      --enable-jpeg 			\
  	      --enable-zlib 			\
  	      --enable-png 			\
  	      --enable-gstreamer=no 		\
  	      --with-smooth-scaling 		\
	      --enable-one			\
	      --enable-voodoo			\
  	      --with-gfxdrivers=i810,i830 	\
	      --enable-fbdev

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__ilixi()
{
	__cd ilixi

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr		\
	      --sysconfdir=/etc		\
	      --localstatedir=/var	\
	      --libexecdir=/usr/lib	\
	      --enable-dale		\
	      --enable-sound

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__all()
{
#	__rem(){
	__linux-fusion
###	__flux
	__direct-fb
	__common FusionSound
	__common LiTE
	__common DirectFBGL
	__common FusionDale

	__common DirectFB-examples
	__common SaWMan

	__ilixi

	__common DFBTerm
	__common DFBSee
}

$@

