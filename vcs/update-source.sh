#!/bin/bash

BASE_DIR=$(pwd)

#git
cd $BASE_DIR/git
git pull

#gitg
cd $BASE_DIR/gitg
git pull

#hg
cd $BASE_DIR/hg
hg pull
hg update

#apr1

#apr1-util

#apr2
cd $BASE_DIR/apr
svn update

#serf
cd $BASE_DIR/serf
svn update

#svn

#sqlite3

#gdbm
cd $BASE_DIR/gdbm
git pull

#cvs
cd $BASE_DIR/ccvs
cvs update

#diffutils
cd $BASE_DIR/diffutils
cvs update

