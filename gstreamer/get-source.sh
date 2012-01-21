#!/bin/bash

git clone git://anongit.freedesktop.org/gstreamer/common

git clone git://anongit.freedesktop.org/gstreamer/gst-ffmpeg

git clone git://git.libav.org/libav.git

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-bad

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-base

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-good

git clone git://anongit.freedesktop.org/gstreamer/gst-plugins-ugly

git clone git://anongit.freedesktop.org/gstreamer/gstreamer

wget -c http://sourceforge.net/projects/lame/files/lame/3.99/lame-3.99.3.tar.gz
gzip -dc lame-3.99.3.tar.gz | tar xvf -

