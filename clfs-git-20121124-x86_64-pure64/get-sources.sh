#!/bin/bash

BASE_DIR=/mnt/clfs/sources/src
mkdir -p $BASE_DIR
cd $BASE_DIR
wget -c http://cross-lfs.org/files/packages/clfs-packages-git-20121107.tar
tar xvf clfs-packages-git-20121107.tar

