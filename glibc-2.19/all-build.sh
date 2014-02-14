#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

. ../common-func/__common-func-2.sh

__glibc-2.19()
{
    __decord glibc-2.19
    __cdbt

    cat > configparms << .
ASFLAGS-config=-O4 -march=native -mtune=native -msse3 -Wa,--noexecstack
.

    $BASE_DIR/glibc-2.19/configure --prefix=/usr --disable-profile --enable-kernel=3.13 \
        --libexecdir=/usr/lib/glibc --enable-add-ons
    __mk
    sudo cp -v $BASE_DIR/glibc-2.19/sunrpc/rpc/*.h    /usr/include/rpc/
    sudo cp -v $BASE_DIR/glibc-2.19/sunrpc/rpcsvc/*.h /usr/include/rpc/
    sudo cp -v $BASE_DIR/glibc-2.19/nis/rpcsvc/*.h    /usr/include/rpc/
    __mkinst
}

__all()
{
    __glibc-2.19
}

$@
