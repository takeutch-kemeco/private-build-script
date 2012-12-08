#!/bin/bash

BASE_DIR=/mnt/clfs/sources/src
mkdir -p $BASE_DIR
cd $BASE_DIR
wget -c http://cross-lfs.org/files/packages/clfs-packages-1.2.0.tar
tar xvf clfs-packages-1.2.0.tar

