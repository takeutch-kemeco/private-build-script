#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__ogg()
{
    __svn-clone http://svn.xiph.org/trunk/ogg
    __common ogg
}

__vorbis()
{
    __svn-clone http://svn.xiph.org/trunk/vorbis
    __common vorbis
}

__theora()
{
    __svn-clone http://svn.xiph.org/trunk/theora
    __cd theora
    __bld-common --disable-examples
}

__theora-tools()
{
    __svn-clone http://svn.xiph.org/trunk/theora-tools
    __cd theora-tools
    __bld-common PNG_CFLAGS=`pkg-config libpng15 --cflags` PNG_LIBS=`pkg-config libpng15 --libs`
}

__xvidcore()
{
    __wget http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
    __decord xvidcore-1.3.2
    __cd xvidcore/build/generic
    __bld-common
}

__x264()
{
    __git-clone git://git.videolan.org/x264.git
    __common x264
}

__soundtouch()
{
    __svn-clone http://svn.code.sf.net/p/soundtouch/code/trunk soundtouch
    __cd soundtouch
    ./bootstrap
    __bld-common
}

__libvpx()
{
    __git-clone https://chromium.googlesource.com/webm/libvpx
    __cd libvpx
    __bld-common-simple
}

__flac()
{
    __git-clone git://git.xiph.org/flac.git
    __common flac
}

__faad2()
{
    __wget http://downloads.sourceforge.net/faac/faad2-2.7.tar.bz2
    __dcd faad2-2.7
    __bld-common
}

__faac()
{
    __wget http://downloads.sourceforge.net/faac/faac-1.28.tar.bz2
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/faac-1.28-glibc_fixes-1.patch
    __dcd faac-1.28
    patch -Np1 -i $SRC_DIR/faac-1.28-glibc_fixes-1.patch
    sed -i -e '/obj-type/d' -e '/Long Term/d' frontend/main.c
    __bld-common
}

__libav()
{
    __git-clone git://git.libav.org/libav.git
    __cd libav
    __bld-common-simple --enable-shared --enable-gpl
}

__gstreamer-core()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/common gstreamer-core
    __cd gstreamer-core
    __bld-common
}

__gstreamer()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gstreamer
    __cd gstreamer
    __bld-common --enable-maintainer-mode --disable-gst-debug \
        --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-plugins-base()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gst-plugins-base
    __cd gst-plugins-base
    __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings \
        --disable-wayland --enable-shared
}

__gst-plugins-good()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gst-plugins-good
    __cd gst-plugins-good
    __bld-common-simple --sysconfdir=/etc/gnome --enable-maintainer-mode --disable-debug \
        --disable-debugutils --disable-fatal-warnings --enable-shared --disable-jpeg
}

__gst-plugins-ugly()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gst-plugins-ugly
    __cd gst-plugins-ugly
    __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-plugins-bad()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gst-plugins-bad
    __cd gst-plugins-bad
    __bld-common --enable-maintainer-mode --disable-debug --disable-fatal-warnings --enable-shared
}

__gst-ffmpeg()
{
    __git-clone git://anongit.freedesktop.org/gstreamer/gst-ffmpeg
    __cd gst-ffmpeg
    __bld-common --enable-maintainer-mode --disable-fatal-warnings --enable-shared
}

__lame()
{
    __wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
    __dcd lame-3.99.5
    __bld-common --enable-mp3rtp --enable-shared
}

__speex()
{
    __git-clone http://git.xiph.org/speex.git
    __common speex
}

__ffmpeg()
{
    __git-clone git://source.ffmpeg.org/ffmpeg.git
    __cd ffmpeg
    __bld-common-simple --disable-debug --enable-shared --enable-gpl --enable-x11grab --enable-version3 \
        --enable-nonfree --enable-libfaac --enable-libfreetype --enable-libmp3lame \
        --enable-libtheora --enable-libvorbis --enable-libvpx \
        --enable-libxvid --enable-libpulse --enable-openssl
}

__gstreamermm()
{
    __git-clone git://git.gnome.org/gstreamermm
    __common gstreamermm
}

__gst()
{
    __gstreamer
### __gstreamer-core
    __gst-plugins-base
    __gst-plugins-good
    __gst-plugins-ugly
    __gst-plugins-bad
    __gst-ffmpeg
}

__all()
{
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
### __libav
    __speex
    __ffmpeg

    __gst
### __gstreamermm
}

$@

