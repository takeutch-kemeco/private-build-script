#!/bin/bash

git clone git://anongit.freedesktop.org/gstreamer/common

git clone git://anongit.freedesktop.org/gstreamer/gst-ffmpeg

git clone git://git.libav.org/libav.git

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-bad

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-base

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-good

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-ugly

git clone git://anongit.freedesktop.org/gstreamer/gstreamer

git clone git://git.gnome.org/gstreamermm

cvs -z3 -d:pserver:anonymous@lame.cvs.sourceforge.net:/cvsroot/lame co -P lame

svn co http://svn.xiph.org/trunk/ogg
svn co http://svn.xiph.org/trunk/vorbis
svn co http://svn.xiph.org/trunk/theora
cvs -z3 -d:pserver:anonymous@flac.cvs.sourceforge.net:/cvsroot/flac co -P flac
