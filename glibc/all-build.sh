#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

glibc() {
	rm -rf $BASE_DIR/build-glibc
	mkdir -p $BASE_DIR/build-glibc
	cd $BASE_DIR/build-glibc

cat > configparms << "EOF"
ASFLAGS-config=-march=native -msse3 -mtune=native -m32 -Wa,--noexecstack
EOF

#cat > configparms << "EOF"
#ASFLAGS-config=-march=core2 -mtune=core2 -msse3 -Wa,--noexecstack
#EOF
	$BASE_DIR/glibc-2.15/configure --prefix=$PREFIX \
		--enable-kernel=3.0 \
		--libexecdir=$PREFIX/lib/glibc \
		--disable-profile \
		--enable-add-ons
#		--with-cpu=i686

	make

	### test
#	cp -v ../glibc/iconvdata/gconv-modules iconvdata
#	make -k check 2>&1 | tee glibc-check-log
#	grep Error glibc-check-log

	cp -v $BASE_DIR/glibc/sunrpc/rpc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/sunrpc/rpcsvc/*.h $PREFIX/include/rpc/
	cp -v $BASE_DIR/glibc/nis/rpcsvc/*.h $PREFIX/include/rpc/

	make install

	ldconfig

	cd $BASE_DIR
}

glibc

