#!/bin/bash

base_dir=$(pwd)

for package in $(ls)
do
  cd $base_dir/$package
  git pull
  ./autogen.sh --prefix=/usr --disable-python
#  make clean
  make
  make install
  ldconfig
  cd $base_dir
done

