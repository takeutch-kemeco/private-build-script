#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gst-clean()
{
	echo
}

__gst-clean()
{
	ls .git
	if [ $? -eq 0 ]
	then
		rm * -rf
		git clone . b
		mv b/* .
		rm b -rf
	fi
}

__ogg()
{
	__common $BASE_DIR/ogg
}

__vorbis()
{
	__common $BASE_DIR/vorbis
}

__theora()
{
	__cd $BASE_DIR/theora

	./configure --prefix=/usr	\
		--disable-examples

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__theora-tools()
{
	__common $BASE_DIR/theora-tools
}

__xvidcore()
{
	__common $BASE_DIR/xvidcore/build/generic
}

__x264()
{
	__common $BASE_DIR/x264
}

__soundtouch()
{
	__common $BASE_DIR/soundtouch/trunk
}

__libvpx()
{
	__cdbt $BASE_DIR/libvpx-build

	$DIST_CLEAN
	../libvpx/autogen.sh
	../libvpx/configure --prefix=/usr \
		--enable-shared

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__flac()
{
	__common $BASE_DIR/flac
}

__faad2()
{
	__common $BASE_DIR/faad2
}

__faac()
{
	__common $BASE_DIR/faac
}

__libav()
{
	__cd $BASE_DIR/libav

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr	\
		--enable-shared 	\
		--enable-gpl

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gstreamer-core()
{
	__cd $BASE_DIR/gstreamer

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-maintainer-mode \
		--disable-gst-debug 	\
		--disable-debug 	\
		--disable-fatal-warnings \
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gst-plugins-base()
{
	__cd $BASE_DIR/gst-plugins-base

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-maintainer-mode \
		--disable-debug 	\
		--disable-fatal-warnings \
		--disable-wayland 	\
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gst-plugins-good()
{
	__cd $BASE_DIR/gst-plugins-good

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--sysconfdir=/etc/gnome \
		--enable-maintainer-mode \
		--disable-debug 	\
		--disable-debugutils 	\
		--disable-fatal-warnings \
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gst-plugins-ugly()
{
	__cd $BASE_DIR/gst-plugins-ugly

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-maintainer-mode \
		--disable-debug 	\
		--disable-fatal-warnings \
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gst-plugins-bad()
{
	__cd $BASE_DIR/gst-plugins-bad

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-maintainer-mode \
		--disable-debug 	\
		--disable-fatal-warnings \
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gst-ffmpeg()
{
	__cd $BASE_DIR/gst-ffmpeg

	__gst-clean

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-maintainer-mode \
		--disable-fatal-warnings \
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__lame()
{
	__cd $BASE_DIR/lame
	
	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr 	\
		--enable-mp3rtp 	\
		--enable-shared

	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__ffmpeg()
{
	__cd $BASE_DIR/ffmpeg

	$DIST_CLEAN
	./autogen.sh
	./configure --prefix=/usr	 \
        	    --disable-debug      \
	            --enable-shared      \
	            --enable-gpl         \
	            --enable-x11grab     \
	            --enable-version3    \
	            --enable-nonfree     \
	            --enable-libfaac     \
	            --enable-libfreetype \
	            --enable-libmp3lame  \
	            --enable-libspeex    \
	            --enable-libtheora   \
	            --enable-libvorbis   \
	            --enable-libvpx      \
	            --enable-libxvid     \
	            --enable-libpulse    \
	            --enable-openssl

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gstreamermm()
{
	__common $BASE_DIR/gstreamermm
}

__gst() {
	__gstreamer-core
	__gst-plugins-base
	__gst-plugins-good
	__gst-plugins-ugly
	__gst-plugins-bad
	__gst-ffmpeg
}

#__rem(){
__ogg
__vorbis
__theora
__theora-tools
__xvidcore
__x264
__soundtouch
__libvpx
__flac
__faad2
__faac
__lame
__libav
__ffmpeg

__gst
###__gstreamermm

