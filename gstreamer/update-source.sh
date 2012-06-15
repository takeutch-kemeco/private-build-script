#!/bin/bash

BASE_DIR=$(pwd)

f() {
	git checkout master
	git pull
}

cd $BASE_DIR/common
f

cd $BASE_DIR/gst-ffmpeg
f

cd $BASE_DIR/libav
f

cd $BASE_DIR/gst-plugins-bad
f

cd $BASE_DIR/gst-plugins-base
f

cd $BASE_DIR/gst-plugins-good
f

cd $BASE_DIR/gst-plugins-ugly
f

cd $BASE_DIR/gstreamer
f

cd $BASE_DIR/lame
cvs update

