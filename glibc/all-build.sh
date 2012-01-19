#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"

glibc() {
	rm -rf $BASE_DIR/build-glibc
	mkdir -p $BASE_DIR/build-glibc
	cd $BASE_DIR/build-glibc

cat > configparms << "EOF"
ASFLAGS-config=-march=core2 -mtune=native -Wa,--noexecstack
EOF
	$BASE_DIR/glibc/configure --prefix=$PREFIX \
		--disable-profile \
		--enable-add-ons \
		--enable-kernel=3.0 \
		--libexecdir=$PREFIX/lib/glibc
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

glibc

