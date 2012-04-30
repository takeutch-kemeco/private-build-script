#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/zlib
git pull

cd $BASE_DIR/mpfr
svn update

cd $BASE_DIR/gmp
hg pull
hg update

cd $BASE_DIR/mpc
svn update

cd $BASE_DIR/gcc
svn update

cd $BASE_DIR/gdb
svn update
