#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

__libav()
{
	cd $BASE_DIR/libav
	$DIST_CLEAN
	./configure --prefix=/usr --enable-shared --enable-gpl
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__common()
{
	cd $BASE_DIR/common
	$DIST_CLEAN

	cd $BASE_DIR
}

__gstreamer-core()
{
	cd $BASE_DIR/gstreamer

	rm -rf $BASE_DIR/gstreamer/common
	ln -s $BASE_DIR/common $BASE_DIR/gstreamer/common

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-gst-debug \
		--disable-debug \
		--disable-fatal-warnings \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gst-plugins-base()
{
	cd $BASE_DIR/gst-plugins-base

	rm -rf $BASE_DIR/gst-plugins-base/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-base/common

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug \
		--disable-fatal-warnings \
		--disable-directfb \
		--disable-wayland \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gst-plugins-good()
{
	cd $BASE_DIR/gst-plugins-good

	rm -rf $BASE_DIR/gst-plugins-good/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-good/common

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc/gnome \
		--enable-maintainer-mode \
		--disable-debug \
		--disable-debugutils \
		--disable-fatal-warnings \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gst-plugins-ugly()
{
	cd $BASE_DIR/gst-plugins-ugly

	rm -rf $BASE_DIR/gst-plugins-ugly/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-ugly/common

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug \
		--disable-fatal-warnings \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gst-plugins-bad()
{
	cd $BASE_DIR/gst-plugins-bad

	rm -rf $BASE_DIR/gst-plugins-bad/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-bad/common

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug \
		--disable-fatal-warnings \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gst-ffmpeg()
{
	cd $BASE_DIR/gst-ffmpeg

	rm -rf $BASE_DIR/gst-ffmpeg/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-ffmpeg/common

	rm -rf $BASE_DIR/gst-ffmpeg/gst-libs/ext/libav
	ln -s $BASE_DIR/libav $BASE_DIR/gst-ffmpeg/gst-libs/ext/libav

	$DIST_CLEAN
	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-fatal-warnings \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__lame()
{
	cd $BASE_DIR/lame
	$DIST_CLEAN
	./configure --prefix=$PREFIX \
		--enable-mp3rtp \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

test()
{
	exit
}
#test

__lame
__libav
__common
__gstreamer-core
__gst-plugins-base
__gst-plugins-good
__gst-plugins-ugly
__gst-plugins-bad
__gst-ffmpeg

