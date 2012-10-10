#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR
PREFIX=/usr

. ../common-func/__common-func.sh

__glibc() {
	__cdbt

cat > configparms << "EOF"
ASFLAGS-config=-march=native -msse3 -mtune=native -m32 -Wa,--noexecstack
EOF

	$BASE_DIR/glibc/configure --prefix=$PREFIX \
		--enable-kernel=3.0 	\
		--libexecdir=$PREFIX/lib/glibc \
		--enable-add-ons

#		--with-cpu=i686

	__mk

	cp -v $BASE_DIR/glibc/sunrpc/rpc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/sunrpc/rpcsvc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/nis/rpcsvc/*.h $PREFIX/include/rpc/

	__mk install
	ldconfig
}

__glibc

