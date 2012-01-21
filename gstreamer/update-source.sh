#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/common
git pull origin

cd $BASE_DIR/gst-ffmpeg
git pull origin

cd $BASE_DIR/libav
git pull origin

cd $BASE_DIR/gst-plugins-bad
git pull origin

cd $BASE_DIR/gst-plugins-base
git pull origin

cd $BASE_DIR/gst-plugins-good
git pull origin

cd $BASE_DIR/gst-plugins-ugly
git pull origin

cd $BASE_DIR/gstreamer
git pull origin

#lame

