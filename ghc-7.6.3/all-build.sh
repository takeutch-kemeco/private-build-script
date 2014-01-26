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
    __wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
    __decord ghc-7.6.3-x86_64-unknown-linux
    __cd ghc-7.6.3
    sudo ln -sf /usr/lib/libgmp.so /usr/lib/libgmp.so.3
    __cfg --prefix=/usr --sysconfdir=/etc
    __mkinst
}

__cabal-install()
{
    __wget http://hackage.haskell.org/packages/archive/cabal-install/1.16.0.2/cabal-install-1.16.0.2.tar.gz
    __dcd cabal-install-1.16.0.2
    sh ./bootstrap.sh
    sudo cabal update
}

__ghc()
{
    __wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-src.tar.bz2
    __decord ghc-7.6.3-src
    __cd ghc-7.6.3
    __bld-common
}

__all()
{
    __ghc-binary
### __cabal-install
### __ghc
}

$@

