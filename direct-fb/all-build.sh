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

__linux-fusion()
{
	__cd $BASE_DIR/linux-fusion
	__mk
}

__direct-fb()
{
	__cd $BASE_DIR/DirectFB

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
  		--enable-x11 		\
  		--enable-egl=no 	\
  		--enable-sdl 		\
  		--enable-mesa 		\
  		--enable-jpeg 		\
  		--enable-zlib 		\
  		--enable-png 		\
  		--enable-gstreamer 	\
  		--with-smooth-scaling 	\
		--enable-one		\
		--enable-voodoo		\
  		--with-gfxdrivers=i810,i830 \
		--enable-fbdev 		\

	__mk
	__mk install
	ldconfig
}

__direct-fbgl()
{
	__common $BASE_DIR/DirectFBGL
}

__fusion-sound()
{
	__cd $BASE_DIR/FusionSound

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
		--with-ffmpeg=no

	__mk
	__mk install
	ldconfig
}

__ilixi()
{
	__cd $BASE_DIR/ilixi

	$MAKE_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
		--enable-dale		\
		--enable-sound

	__mk
	__mk install
	ldconfig
}

#__rem(){
__linux-fusion
__common $BASE_DIR/flux
__common $BASE_DIR/LiTE
__fusion-sound
__direct-fb
__direct-fbgl
__common $BASE_DIR/FusionDale

__common $BASE_DIR/DirectFB-examples
__common $BASE_DIR/SaWMan

__ilixi

__common $BASE_DIR/DFBTerm
__common $BASE_DIR/DFBSee

