#!/bin/bash

wget -c http://llvm.org/releases/3.1/clang-3.1.src.tar.gz
wget -c http://llvm.org/releases/3.1/llvm-3.1.src.tar.gz
gzip -dc llvm-3.1.src.tar.gz | tar xvf -
ln -s llvm-3.1.src llvm

