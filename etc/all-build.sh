#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

__cd()
{
	echo "------------------------------"
	echo $1
	echo "------------------------------"

	cd $1
}

__talloc() {
	__cd $BASE_DIR/talloc
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__pcre() {
	__cd $BASE_DIR/pcre
	./configure --prefix=$PREFIX \
		--libdir=/lib \
		--docdir=$PREFIX/share/doc/pcre-8 \
		--enable-utf8 \
		--enable-unicode-properties \
		--enable-pcregrep-libz \
		--enable-pcregrep-libbz2
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__popt() {
	__cd $BASE_DIR/popt
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

__gc() {
	__cd $BASE_DIR/gc
	./autogen.sh
	./configure --prefix=$PREFIX \
		--enable-cplusplus
	$MAKE_CLEAN
	make
	make install
	ldconfig

	install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3 &&
	ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3 
}

__nettle() {
	__cd $BASE_DIR/nettle
	./configure --prefix=$PREFIX \
		--enable-shared
	$MAKE_CLEAN
	make
	make install
	ldconfig
}

#__tetex() {
#	__cd $BASE_DIR/tetex
#}

__tcl() {
	__cd $BASE_DIR/tcl
        cd unix

        ./configure --prefix=$PREFIX \
                --enable-threads \
                --mandir=$PREFIX/share/man
        make

        make install
        make install-private-headers

#	rm -f /lib/libtcl.so
#	ln -sf libtcl.so.8 /lib/libtcl.so

        ldconfig
}

__tk() {
        __cd $BASE_DIR/tk
        cd unix

        ./configure --prefix=$PREFIX \
                --enable-threads \
                --mandir=$PREFIX/share/man
        make

        make install
        make install-private-headers

#	rm -f /lib/libtk.so
#	ln -sf libtk.so.8 /lib/libtk.so

        ldconfig
}

__tomoyo-tools() {
	__cd $BASE_DIR/tomoyo-tools
	make USRLIBDIR=/lib
	make USRLIBDIR=/lib install
}

__linux-pam()
{
	__cd $BASE_DIR/linux-pam
	./autogen.sh
	./configure --sbindir=/lib/security \
		--docdir=/usr/share/doc/Linux-PAM \
		--disable-nis \
		--enable-read-both-confs
	make

	install -v -m755 -d /etc/pam.d

cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

	rm -rfv /etc/pam.d

	make install
	chmod -v 4755 /lib/security/unix_chkpwd
	mv -v /lib/security/pam_tally /sbin
	ldconfig
}

__freeglut()
{
	__cd $BASE_DIR/freeglut

	export LIBRARY_PATH=$XORG_PREFIX/lib
	./configure --prefix=$XORG_PREFIX \
		--disable-static

	$MAKE_CLEAN
	make

	make install
	mkdir -p $XORG_PREFIX/share/doc/freeglut-2.8.0
	cp doc/*.{html,png} $XORG_PREFIX/share/doc/freeglut-2.8.0
	ldconfig
}

__test__()
{

	exit
}
#__test__

__talloc
__pcre
__popt
__gc
__nettle
__tcl
__tk
__tomoyo-tools
__linux-pam
__freeglut

