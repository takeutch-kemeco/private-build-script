#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

. ../common-func/__common-func-2.sh

DIST_CLEAN=""
#DIST_CLEAN="make distclean"

MAKE_CLEAN=""
#MAKE_CLEAN="make clean"

__libmnl()
{
    __git-clone git://git.netfilter.org/libmnl
    __common libmnl
}

__libnftnl()
{
    __git-clone git://git.netfilter.org/libnftnl
    __common libnftnl
}

__nftables()
{
    __git-clone git://git.netfilter.org/nftables
    __common nftables
}

__all() {
    __libmnl
    __libnftnl
    __nftables
}

$@

