#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr
GST_VERSION=0.10

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

libav()
{
	cd $BASE_DIR/libav
	./autogen.sh --prefix=/usr
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

common()
{
	cd $BASE_DIR/common
	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	cd $BASE_DIR
}

gstreamer-core()
{
	cd $BASE_DIR/gstreamer

	rm -rf $BASE_DIR/gstreamer/common
	ln -s $BASE_DIR/common $BASE_DIR/gstreamer/common

	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-gst-debug \
		--disable-debug
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gst-plugins-base()
{
	cd $BASE_DIR/gst-plugins-base

	rm -rf $BASE_DIR/gst-plugins-base/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-base/common

	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gst-plugins-good()
{
	cd $BASE_DIR/gst-plugins-good

	rm -rf $BASE_DIR/gst-plugins-good/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-good/common

	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	./autogen.sh --prefix=$PREFIX \
		--sysconfdir=/etc/gnome \
		--enable-maintainer-mode \
		--disable-debug \
		--disable-debugutils
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gst-plugins-ugly()
{
	cd $BASE_DIR/gst-plugins-ugly

	rm -rf $BASE_DIR/gst-plugins-ugly/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-ugly/common

	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gst-plugins-bad()
{
	cd $BASE_DIR/gst-plugins-bad

	rm -rf $BASE_DIR/gst-plugins-bad/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-plugins-bad/common

	git checkout -b $GST_VERSION origin/$GST_VERSION
	git checkout $GST_VERSION

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode \
		--disable-debug
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

gst-ffmpeg()
{
	cd $BASE_DIR/gst-ffmpeg

	rm -rf $BASE_DIR/gst-ffmpeg/common
	ln -s $BASE_DIR/common $BASE_DIR/gst-ffmpeg/common

	rm -rf $BASE_DIR/gst-ffmpeg/gst-libs/ext/libav
	ln -s $BASE_DIR/libav $BASE_DIR/gst-ffmpeg/gst-libs/ext/libav

	git checkout -b $GST_VERSION.13 origin/$GST_VERSION.13
	git checkout $GST_VERSION.13

	./autogen.sh --prefix=$PREFIX \
		--enable-maintainer-mode
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

lame()
{
	cd $BASE_DIR/lame-3.99.3
	./configure --prefix=$PREFIX \
		--enable-mp3rtp
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

lame
rem(){
libav
common
gstreamer-core
gst-plugins-base
gst-plugins-good
gst-plugins-ugly
gst-plugins-bad
}
#gst-ffmpeg

