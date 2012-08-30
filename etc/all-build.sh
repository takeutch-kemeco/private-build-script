#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

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
	./configure --prefix=$PREFIX \
		--libdir=/lib \
		--docdir=$PREFIX/share/doc/pcre-8 \
		--enable-utf8 \
		--enable-unicode-properties \
		--enable-pcregrep-libz \
		--enable-pcregrep-libbz2
	$MAKE_CLEAN
	__mk
	__mk install
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

__linux-pam()
{
	__cd $BASE_DIR/linux-pam
	./autogen.sh
	./configure --sbindir=/lib/security \
		--docdir=/usr/share/doc/Linux-PAM \
		--disable-nis \
		--enable-read-both-confs
	__mk

	install -v -m755 -d /etc/pam.d

cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

	rm -rfv /etc/pam.d

	__mk install
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
	__mk

	__mk install
	mkdir -p $XORG_PREFIX/share/doc/freeglut-2.8.0
	cp doc/*.{html,png} $XORG_PREFIX/share/doc/freeglut-2.8.0
	ldconfig
}

__ConsoleKit()
{
	__cd $BASE_DIR/ConsoleKit

	./configure --prefix=$PREFIX	\
           	--sysconfdir=/etc 	\
           	 --localstatedir=/var 	\
           	 --libexecdir=/usr/lib/ConsoleKit \
           	 --enable-pam-module

###           	 --enable-udev-acl 	\

	__mk
	__mk install
	ldconfig

cat >> /etc/pam.d/system-session << "EOF"
# Begin ConsoleKit addition

session   optional    pam_loginuid.so
session   optional    pam_ck_connector.so nox11

# End ConsoleKit addition
EOF

cat > /usr/lib/ConsoleKit/run-session.d/pam-foreground-compat.ck << "EOF"
#!/bin/sh
TAGDIR=/var/run/console

[ -n "$CK_SESSION_USER_UID" ] || exit 1
[ "$CK_SESSION_IS_LOCAL" = "true" ] || exit 0

TAGFILE="$TAGDIR/`getent passwd $CK_SESSION_USER_UID | cut -f 1 -d:`"

if [ "$1" = "session_added" ]; then
    mkdir -p "$TAGDIR"
    echo "$CK_SESSION_ID" >> "$TAGFILE"
fi

if [ "$1" = "session_removed" ] && [ -e "$TAGFILE" ]; then
    sed -i "\%^$CK_SESSION_ID\$%d" "$TAGFILE"
    [ -s "$TAGFILE" ] || rm -f "$TAGFILE"
fi
EOF
chmod -v 755 /usr/lib/ConsoleKit/run-session.d/pam-foreground-compat.ck
}

__test__()
{
#__linux-pam
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
__ConsoleKit

