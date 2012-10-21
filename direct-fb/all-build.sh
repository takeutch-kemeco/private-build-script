#!/bin/bash

BASE_DIR=$(pwd)

MAKE_CLEAN=
#MAKE_CLEAN="make distclean && make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__direct-fb()
{
	__cd $BASE_DIR/DirectFB

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
  		--enable-x11 		\
  		--enable-egl=no 	\
  		--enable-fbdev 		\
  		--enable-sdl 		\
  		--enable-mesa 		\
  		--enable-jpeg 		\
  		--enable-zlib 		\
  		--enable-png 		\
  		--enable-gstreamer 	\
  		--with-smooth-scaling 	\
  		--with-gfxdrivers=i810,i830

	__mk
	__mk install
	ldconfig
}

__common $BASE_DIR/flux
__common $BASE_DIR/LiTE
__direct-fb
__common $BASE_DIR/DirectFB-examples

