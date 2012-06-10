#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

glibc() {
	rm -rf $BASE_DIR/build-glibc
	mkdir -p $BASE_DIR/build-glibc
	cd $BASE_DIR/build-glibc

cat > configparms << "EOF"
ASFLAGS-config=-march=core2 -Wa,--noexecstack
EOF
	$BASE_DIR/glibc/configure --prefix=$PREFIX \
		--enable-kernel=3.1 \
		--libexecdir=$PREFIX/lib/glibc \
		--disable-profile \
		--enable-add-ons

	make
	make install

	cp -v $BASE_DIR/glibc/sunrpc/rpc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/sunrpc/rpcsvc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/nis/rpcsvc/*.h $PREFIX/include/rpc/

	ldconfig

	cd $BASE_DIR
}

glibc

