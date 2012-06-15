#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/common
$(pwd)
git pull

cd $BASE_DIR/gst-ffmpeg
$(pwd)
git pull

cd $BASE_DIR/libav
$(pwd)
git pull

cd $BASE_DIR/gst-plugins-bad
$(pwd)
git pull

cd $BASE_DIR/gst-plugins-base
$(pwd)
git pull

cd $BASE_DIR/gst-plugins-good
$(pwd)
git pull

cd $BASE_DIR/gst-plugins-ugly
$(pwd)
git pull

cd $BASE_DIR/gstreamer
$(pwd)
git pull

cd $BASE_DIR/lame
$(pwd)
cvs update

