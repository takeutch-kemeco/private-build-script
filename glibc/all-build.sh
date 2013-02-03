#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

. ../common-func/__common-func.sh

__glibc() {
	__cdbt

cat > configparms << "EOF"
ASFLAGS-config=-O4 -march=native -mtune=native -msse3 -Wa,--noexecstack
EOF

	$BASE_DIR/glibc/configure --prefix=/usr \
    		--disable-profile	\
		--enable-kernel=3.0 	\
		--libexecdir=/usr/lib/glibc \
		--enable-add-ons

	__mk

	cp -v $BASE_DIR/glibc/sunrpc/rpc/*.h /usr/include/rpc/
	cp -v $BASE_DIR/glibc/sunrpc/rpcsvc/*.h /usr/include/rpc/
	cp -v $BASE_DIR/glibc/nis/rpcsvc/*.h /usr/include/rpc/

	__mk install
	ldconfig
}

__glibc
