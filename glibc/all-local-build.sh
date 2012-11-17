#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

. ../common-func/__common-func.sh

__glibc() {
	__cdbt

cat > configparms << "EOF"
ASFLAGS-config=-O4 -march=native -msse3 -mtune=native -Wa,--noexecstack -m32
EOF

	$BASE_DIR/glibc/configure --prefix=/usr/local \
    		--disable-profile	\
		--enable-kernel=3.0 	\
		--libexecdir=/usr/local/lib/glibc \
		--enable-add-ons	\
		--disable-sanity-checks

	__mk

	cp -v $BASE_DIR/glibc/sunrpc/rpc/*.h /usr/local/include/rpc/
	cp -v $BASE_DIR/glibc/sunrpc/rpcsvc/*.h /usr/local/include/rpc/
	cp -v $BASE_DIR/glibc/nis/rpcsvc/*.h /usr/local/include/rpc/

	__mk install
	ldconfig
}

__glibc

