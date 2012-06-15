#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/common
git pull

cd $BASE_DIR/gst-ffmpeg
git pull

cd $BASE_DIR/libav
git pull

cd $BASE_DIR/gst-plugins-bad
git pull

cd $BASE_DIR/gst-plugins-base
git pull

cd $BASE_DIR/gst-plugins-good
git pull

cd $BASE_DIR/gst-plugins-ugly
git pull

cd $BASE_DIR/gstreamer
git pull

cd $BASE_DIR/lame
cvs update

