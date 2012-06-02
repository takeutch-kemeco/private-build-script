#!/bin/bash

BASE_DIR=$(pwd)

cd $BASE_DIR/git
git pull

cd $BASE_DIR/gitg
git pull

cd $BASE_DIR/hg
hg pull
hg update

#apr1

#apr1-util

####apr2
###cd $BASE_DIR/apr
svn update

cd $BASE_DIR/serf
svn update

#sqlite3

#cd $BASE_DIR/svn
#svn update

# gdbm

# cvs
cd ccvs
cvs update

#diffutils
cd diffutils
cvs update

