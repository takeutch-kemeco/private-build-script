#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__ogg()
{
	__common ogg
}

__vorbis()
{
	__common vorbis
}

__theora()
{
	__cd theora
        __bld-common --disable-examples
}

__theora-tools()
{
	__cd theora-tools
	__bld-common PNG_CFLAGS=`pkg-config libpng15 --cflags` PNG_LIBS=`pkg-config libpng15 --libs`
}

__xvidcore()
{
	__common xvidcore/build/generic
}

__x264()
{
	__common x264
}

__soundtouch()
{
	__common soundtouch/trunk
}

__libvpx()
{
        __cd libvpx
        __git-pull

	__cdbt libvpx-build

	$DIST_CLEAN
	../libvpx/autogen.sh
	../libvpx/configure --prefix=/usr --enable-shared

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__flac()
{
	__common flac
}

__faad2()
{
	__common faad2
}

__faac()
{
	__common faac
}

__libav()
{
	__cd libav
        __bld-common-simple --enable-shared --enable-gpl
}

__gstreamer-core()
{
	__cd gstreamer
        __bld-common --enable-maintainer-mode --disable-gst-debug \
                     --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-plugins-base()
{
	__cd gst-plugins-base
        __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings \
                     --disable-wayland --enable-shared
}

__gst-plugins-good()
{
	__cd gst-plugins-good
        __bld-common-simple --sysconfdir=/etc/gnome --enable-maintainer-mode --disable-debug \
                            --disable-debugutils --disable-fatal-warnings --enable-shared \
                            --disable-jpeg
}

__gst-plugins-ugly()
{
	__cd gst-plugins-ugly
        __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-plugins-bad()
{
	__cd gst-plugins-bad
        __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-ffmpeg()
{
	__cd gst-ffmpeg
        __bld-common --enable-maintainer-mode --disable-fatal-warnings --enable-shared
}

__lame()
{
	__cd lame
        __bld-common --enable-mp3rtp --enable-shared
}

__speex()
{
	__common speex
}

__ffmpeg()
{
	__cd ffmpeg
        __bld-common-simple --disable-debug --enable-shared --enable-gpl --enable-x11grab --enable-version3 \
                            --enable-nonfree --enable-libfaac --enable-libfreetype --enable-libmp3lame \
                            --enable-libspeex --enable-libtheora --enable-libvorbis --enable-libvpx \
                            --enable-libxvid --enable-libpulse --enable-openssl
}

__gstreamermm()
{
	__common gstreamermm
}

__gst() {
	__gstreamer-core
	__gst-plugins-base
	__gst-plugins-good
	__gst-plugins-ugly
	__gst-plugins-bad
	__gst-ffmpeg
}

__all()
{
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
__speex
__ffmpeg

__gst
###__gstreamermm
}

$@
