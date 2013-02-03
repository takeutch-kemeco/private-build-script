#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	./autogen.sh
	./configure --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__libarchive()
{
	__common $BASE_DIR/libarchive
}

__cmake()
{
	__cd $BASE_DIR/cmake

	./bootstrap --prefix=/usr       \
        	--system-libs       	\
            	--mandir=/share/man 	\
            	--docdir=/share/doc/cmake-2.8.10.2

	__mk
	__mk install
	ldconfig
}

__talloc() {
	__cd $BASE_DIR/talloc
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__pcre() {
	__cd $BASE_DIR/pcre

	./configure --prefix=/usr	\
		--libdir=/lib 		\
		--docdir=/usr/share/doc/pcre-8 \
		--enable-utf 		\
		--enable-unicode-properties \
		--with-pcre=system	\
		--enable-pcregrep-libz 	\
		--enable-pcregrep-libbz2

	$MAKE_CLEAN
	__mk
	make install
	ldconfig
}

__popt() {
	__cd $BASE_DIR/popt
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gc() {
	__cd $BASE_DIR/gc
	./autogen.sh
	./configure --prefix=$PREFIX \
		--enable-cplusplus
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3 &&
	ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3 
}

__nettle() {
	__cd $BASE_DIR/nettle
	./configure --prefix=$PREFIX \
		--enable-shared
	$MAKE_CLEAN
	__mk
	__mk install
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
        __mk

        __mk install
        __mk install-private-headers

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
        __mk

        __mk install
        __mk install-private-headers

#	rm -f /lib/libtk.so
#	ln -sf libtk.so.8 /lib/libtk.so

        ldconfig
}

__tomoyo-tools() {
	__cd $BASE_DIR/tomoyo-tools
	__mk USRLIBDIR=/lib
	__mk USRLIBDIR=/lib install
}

__freeglut()
{
	__cd $BASE_DIR/freeglut

	./autogen.sh
	./configure --prefix=/usr

	rm CMakeCache.txt
	cmake -DCMAKE_INSTALL_PREFIX=/usr .
	
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	mkdir -p $XORG_PREFIX/share/doc/freeglut
	cp doc/*.{html,png} $XORG_PREFIX/share/doc/freeglut
}

__sudo()
{
	__cd $BASE_DIR/sudo

	./autogen.sh
	./configure --prefix=/usr	\
            	--libexecdir=/usr/lib/sudo \
            	--docdir=/usr/share/doc/sudo
            	--with-all-insults	\
            	--with-env-editor  	\
            	--with-pam 	        \
            	--without-sendmail

	__mk
	__mk install
	ldconfig

cat > /etc/pam.d/sudo << "EOF" &&
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF

	chmod 644 /etc/pam.d/sudo
}

__all()
{
#__rem(){
__livarchive
__cmake
__talloc
__pcre
__popt
__gc
__nettle
__tcl
__tk
__tomoyo-tools
__freeglut
__sudo
}

$@

