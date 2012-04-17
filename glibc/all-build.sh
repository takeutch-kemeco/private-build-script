#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

glibc() {
	rm -rf $BASE_DIR/build-glibc
	mkdir -p $BASE_DIR/build-glibc
	cd $BASE_DIR/build-glibc

cat > configparms << "EOF"
ASFLAGS-config=-march=core2 -mtune=core2 -msse3 -Wa,--noexecstack
EOF
	$BASE_DIR/glibc/configure --prefix=$PREFIX \
		--enable-kernel=3.1 \
		--libexecdir=$PREFIX/lib/glibc
	make
	make install
	ldconfig

	cd $BASE_DIR
}

glibc

