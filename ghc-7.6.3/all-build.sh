#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

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
    __cabal-install
    __ghc
}

$@

