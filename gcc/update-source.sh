#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/mpfr
#svn upgrade
svn update

cd $BASE_DIR/gmp
hg pull
hg update

cd $BASE_DIR/mpc
#svn upgrade
svn update

cd $BASE_DIR/gcc
#svn upgrade
svn update

#gdb

