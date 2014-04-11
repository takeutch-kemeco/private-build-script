#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__ghc-binary()
{
    __wget https://www.haskell.org/ghc/dist/7.8.1/ghc-7.8.1-x86_64-unknown-linux-deb7.tar.xz
    __decord ghc-7.8.1-x86_64-unknown-linux-deb7
    __cd ghc-7.8.1
    __cfg --prefix=/usr --sysconfdir=/etc
    __mkinst
}

__cabal-install()
{
    __wget http://hackage.haskell.org/package/cabal-install-1.18.0.3/cabal-install-1.18.0.3.tar.gz
    __dcd cabal-install-1.18.0.3
    sudo sh ./bootstrap.sh
    sudo cabal update
}

__ghc()
{
    __wget https://www.haskell.org/ghc/dist/7.8.1/ghc-7.8.1-src.tar.xz
    __decord ghc-7.8.1-src
    __cd ghc-7.8.1
    __bld-common
}

__all()
{
     __ghc-binary
### __cabal-install
### __ghc
}

$@

