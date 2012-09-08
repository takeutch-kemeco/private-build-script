#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN=
#MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

__common()
{
	__cd $1
	./autogen.sh
	./configure --prefix=$PREFIX
	__mk
	__mk install
	ldconfig
}

__gobject-introspection()
{
	__common $BASE_DIR/gobject-introspection
}

__nspr()
{
	__cd $BASE_DIR/nspr/mozilla/nsprpub

	sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in
	sed -i 's#$(LIBRARY) ##' config/rules.mk

	./configure --prefix=$PREFIX	\
		--with-mozilla		\
		--with-pthreads     	\
		$([ $(uname -m) = x86_64 ] && echo --enable-64bit)

	__mk
	__mk install
	ldconfig
}

__zip()
{
	__cd $BASE_DIR/zip30

	__mk -f unix/Makefile generic_gcc
	__mk prefix=$PREFIX -f unix/Makefile install
}

__js()
{
       __cd $BASE_DIR/js/js/src

       sed -i 's#s \($(SHLIB_\(ABI\|EXACT\)_VER)\)#s $(notdir \1)#' Makefile.in

       ./configure --prefix=$PREFIX	\
		--enable-threadsafe	\
        	--with-system-nspr

	__mk
	__mk install
	ldconfig
}

__polkit()
{
	__cd $BASE_DIR/polkit

	groupadd -fg 27 polkitd
	useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 -g polkitd -s /bin/false polkitd

	./autogen.sh
	./configure --prefix=$PREFIX 	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/polkit-1 \
            	--with-authfw=shadow 	\
            	--disable-static

	__mk
	__mk install
	ldconfig

cat > /etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF
}

__gconf()
{
	__cd $BASE_DIR/gconf

	./autogen.sh --prefix=$PREFIX 	\
            	--sysconfdir=/etc 	\
            	--libexecdir=/usr/lib/GConf \
            	--disable-orbit 	\
            	--disable-static

	__mk
	__mk install
	install -v -m755 -d /etc/gconf/gconf.xml.system
	ldconfig
}

__gnome-backgrounds()
{
	__common $BASE_DIR/gnome-backgrounds
}

__gnome-menus()
{
	__cd $BASE_DIR/gnome-menus

	./autogen.sh --prefix=$PREFIX	\
		--sysconfdir=/etc 	\
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__expat()
{
	__common $BASE_DIR/expat
}

__doxygen()
{
	__cd $BASE_DIR/doxygen

	./configure --prefix /usr \
            	--docdir /usr/share/doc/doxygen-1.8.1.2

	__mk
	__mk install
}

__dbus()
{
	__cd $BASE_DIR/dbus

	groupadd -g 18 messagebus
	useradd -c "D-Bus Message Daemon User" -d /var/run/dbus \
		-u 18 -g messagebus -s /bin/false messagebus

	./autogen.sh --prefix=$PREFIX 	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/dbus-1.0 \
            	--with-console-auth-dir=/run/console/ \
            	--without-systemdsystemunitdir \
            	--disable-systemd 	\
            	--disable-static	\
		--disable-Werror

	__mk
	__mk install

	dbus-uuidgen --ensure

cat > /etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

	cd $BASE_DIR/blfs-bootscripts
	__mk install-dbus
}

__libgpg-error()
{
	__common $BASE_DIR/libgpg-error
}

### error
__libgcrypt()
{
	__cd $BASE_DIR/libgcrypt

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--enable-maintainer-mode

	__mk
	__mk install
	ldconfig
}

__libgnome-keyring()
{
	__common $BASE_DIR/libgnome-keyring
}

__libnotify()
{
	__common $BASE_DIR/libnotify
}

__certificate()
{
	sh $BASE_DIR/certificate-build.sh
}

__librest()
{
	__cd $BASE_DIR/librest

	./autogen.sh --prefix=$PREFIX	\
		--with-ca-certificates=/etc/ssl/ca-bundle.crt
#		--without-ca-certificates

	__mk
	__mk install
	ldconfig
}

__nettle()
{
	__common $BASE_DIR/nettle
	chmod -v 755 /usr/lib/libhogweed.so.2.2 /usr/lib/libnettle.so.4.4
}

__gnutls()
{
	__common $BASE_DIR/gnutls
}

__glib-networking()
{
	__cd $BASE_DIR/glib-networking

	./autogen.sh --prefix=$PREFIX 	\
            	--libexecdir=/usr/lib/glib-networking \
            	--disable-static \
            	--with-ca-certificates=/etc/ssl/ca-bundle.crt

#            	--without-ca-certificates

	__mk
	__mk install
	ldconfig
}

__libxml()
{
	__common $BASE_DIR/libxml
}

__libsoup()
{
	__common $BASE_DIR/libsoup
}

__json-glib()
{
	__common $BASE_DIR/json-glib
}

__gperf()
{
	__common $BASE_DIR/gperf
}

__icu()
{
	__common $BASE_DIR/icu/source
}

__libxslt()
{
	__common $BASE_DIR/libxslt
}

__geoclue()
{
	__cd $BASE_DIR/geoclue

	sed -i "s@ -Werror@@" configure
	sed -i "s@libnm_glib@libnm-glib@g" configure
	sed -i "s@geoclue/libgeoclue.la@& -lgthread-2.0@g" \
       		providers/skyhook/Makefile.in

	./configure --prefix=$PREFIX	\
		--libexecdir=/usr/lib/geoclue

	__mk
	__mk install
	ldconfig
}

__which()
{
	__common $BASE_DIR/which
}

__sqlite3()
{
	__cd $BASE_DIR/sqlite3

	./configure --prefix=$PREFIX	\
		--disable-static 	\
  		CFLAGS="-g -O2 -DSQLITE_SECURE_DELETE=1 -DSQLITE_ENABLE_UNLOCK_NOTIFY=1"

	__mk
	__mk install
	ldconfig
}

__libpng()
{
	__common $BASE_DIR/libpng
}

__cairo()
{
        __cd $BASE_DIR/cairo

        ./autogen.sh --prefix=$PREFIX   \
                --enable-tee            \
                --enable-gl             \
                --enable-xcb            \
                --enable-gtk-doc        \
                --enable-xcb-drm        \
                --enable-glsv2          \
		--enable-xlib-xcb	\
		--enable-xml

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__pango()
{
	__cd $BASE_DIR/pango

	./autogen.sh --prefix=$PREFIX	\
		--sysconfdir=/etc

	__mk
	__mk install
	ldconfig
}

___gstreamer()
{
	__cd $BASE_DIR/gstreamer

	sed -i 's/\(.*gtkdoc-rebase --relative.* \)\(;.*\)/\1|| true\2/' docs/{gst,libs}/Makefile.in

	./autogen.sh --prefix=$PREFIX	\
            	--libexecdir=/usr/lib	\
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__gst-plugins-base()
{
	__cd $BASE_DIR/gst-plugins-base

	sed -i 's/\(.*gtkdoc-rebase --relative.* \)\(;.*\)/\1|| true\2/' docs/libs/Makefile.in

	./autogen.sh --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__webkit()
{
	__cd $BASE_DIR/webkit

	sed -i 's#=GST#=$GST#' configure

	sed -i '/generate-gtkdoc --rebase/s:^:# :' GNUmakefile.in

	patch -Np1 -i ../webkitgtk-1.8.2-bison-1.patch
	./configure --prefix=/usr	\
            	--libexecdir=/usr/lib/WebKit \
            	--enable-introspection

	__mk
	__mk install
	ldconfig
}

__libsecret()
{
	__common $BASE_DIR/libsecret
}

__gnome-online-accounts()
{
	__cd $BASE_DIR/gnome-online-accounts

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--libexecdir=/usr/lib/gnome-online-accounts \
           	--disable-static

	__mk
	__mk install
	ldconfig
}

__lcms2()
{
	__cd $BASE_DIR/lcms2

	aclocal --force
	libtoolize
	automake -acf
	autoconf

	./configure --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__colord()
{
	__cd $BASE_DIR/colord

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/colord \
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__pciutils()
{
	__cd $BASE_DIR/pciutils

	make PREFIX=$PREFIX		\
		SHAREDIR=/usr/share/misc \
     		MANDIR=/usr/share/man 	\
     		SHARED=yes 		\
		ZLIB=no all

	make PREFIX=$PREFIX 		\
     		SHAREDIR=/usr/share/misc \
     		MANDIR=/usr/share/man 	\
     		SHARED=yes 		\
		ZLIB=no			\
		install install-lib

	ldconfig
}

__libusb()
{
	__common $BASE_DIR/libusb
}

__usbutils()
{
	__cd $BASE_DIR/usbutils

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--datadir=/usr/share/misc \
            	--disable-zlib

	__mk
	__mk install
	ldconfig
}

__udev()
{
	__cd $BASE_DIR/udev

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--sbindir=/sbin		\
            	--with-rootlibdir=/lib	\
            	--libexecdir=/lib	\
            	--with-systemdsystemunitdir=no \
            	--disable-introspection	\
            	--docdir=/usr/share/doc/udev

	__mk
	__mk install
	ldconfig
}

__cups()
{
	echo
}

__unzip()
{
	__cd $BASE_DIR/unzip
	__mk -f unix/Makefile linux
	__mk prefix=$PREFIX install
	ldconfig
}

__docbook-xml()
{
	__cd $BASE_DIR/docbook-xml

	install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5
	install -v -d -m755 /etc/xml
	chown -R root:root .
	cp -v -af docbook.cat *.dtd ent/ *.mod /usr/share/xml/docbook/xml-dtd-4.5

if [ ! -e /etc/xml/docbook ]; then
    xmlcatalog --noout --create /etc/xml/docbook
fi &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.5//EN" \
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    /etc/xml/docbook &&
xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    /etc/xml/docbook

if [ ! -e /etc/xml/catalog ]; then
    xmlcatalog --noout --create /etc/xml/catalog
fi &&
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//ENTITIES DocBook XML" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog &&
xmlcatalog --noout --add "delegatePublic" \
    "-//OASIS//DTD DocBook XML" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog &&
xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog &&
xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog

for DTDVERSION in 4.1.2 4.2 4.3 4.4
do
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
    /etc/xml/docbook
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    /etc/xml/docbook
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    /etc/xml/docbook
  xmlcatalog --noout --add "delegateSystem" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog
  xmlcatalog --noout --add "delegateURI" \
    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
    "file:///etc/xml/docbook" \
    /etc/xml/catalog
done
}

__itstool()
{
	__common $BASE_DIR/itstool
}

__yelp-xsl()
{
	__common $BASE_DIR/yelp-xsl
}

__yelp()
{
	__common $BASE_DIR/yelp
}

__yelp-tools()
{
	__common $BASE_DIR/yelp-tools
}

__gnome-desktop()
{
	__common $BASE_DIR/gnome-desktop
}

__libogg()
{
	__common $BASE_DIR/libogg
}

__libvorbis()
{
	__common $BASE_DIR/libvorbis
}

__libcanberra()
{
	__cd $BASE_DIR/libcanberra

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--disable-oss

	__mk
	__mk install
	ldconfig
}

__iso-codes()
{
	__common $BASE_DIR/iso-codes
}

__libxklavier()
{
	__common $BASE_DIR/libxklavier
}

__libgnomekbd()
{
	__common $BASE_DIR/libgnomekbd
}

__libwacom()
{
	__common $BASE_DIR/libwacom
}

__json-c()
{
	__common $BASE_DIR/json-c
}

__alsa-lib()
{
	__common $BASE_DIR/alsa-lib
}

__flac()
{
	__cd $BASE_DIR/flac

	sed -i 's/#include <stdio.h>/&\n#include <string.h>/' examples/cpp/encode/file/main.cpp

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--disable-thorough-tests

	__mk
	__mk install
	ldconfig
}

__libsndfile()
{
	__common $BASE_DIR/libsndfile
}

__check()
{
	__common $BASE_DIR/check
}

__pulseaudio()
{
	__cd $BASE_DIR/pulseaudio

	groupadd -g 58 pulse
	groupadd -g 59 pulse-access
	useradd -c "Pulseaudio User" -d /var/run/pulse -g pulse -s /bin/false -u 58 pulse
	usermod -a -G audio pulse

	find . -name "Makefile.in" | xargs sed -i "s|(libdir)/@PACKAGE@|(libdir)/pulse|"
	./autogen.sh --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib 	\
            	--with-module-dir=/usr/lib/pulse/modules

	__mk
	__mk install

        grep "/usr/lib/pulseaudio" /etc/ld.so.conf
        if [ $? -ne 0 ]
        then
                echo "/usr/lib/pulseaudio" >> /etc/ld.so.conf
        fi

        grep "/usr/lib/pulse/modules" /etc/ld.so.conf
        if [ $? -ne 0 ]
        then
                echo "/usr/lib/pulse/modules" >> /etc/ld.so.conf
        fi

	ldconfig
}

__upower()
{
	__cd $BASE_DIR/upower

	./autogen.sh --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/upower \
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__gnome-settings-daemon()
{
	__cd $BASE_DIR/gnome-settings-daemon

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--libexecdir=/usr/lib/gnome-settings-daemon \
            	--disable-packagekit 	\
            	--disable-static	\
		--disable-ibus		\
		--disable-cups

	__mk
	__mk install
	ldconfig
}

__libgtop()
{
	__common $BASE_DIR/libgtop
}

__shared-mime-info()
{
	__common $BASE_DIR/shared-mime-info
}

__atk()
{
	__common $BASE_DIR/atk
}

__cogl()
{
	__common $BASE_DIR/cogl
}

__clutter()
{
	__common $BASE_DIR/clutter
}

__clutter-gtk()
{
	__common $BASE_DIR/clutter-gtk
}

__libpwquality()
{
	__common $BASE_DIR/libpwquality
}

__gnome-control-center()
{
	__cd $BASE_DIR/gnome-control-center

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--disable-static	\
		--enable-compile-warnings=no \
		--disable-ibus		\
		--disable-cups

	__mk
	__mk install
	ldconfig
}

__gvfs()
{
	__cd $BASE_DIR/gvfs

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--libexecdir=/usr/lib/gvfs \
		--disable-gphoto2

	__mk
	__mk install
	ldconfig
}

__gnome-icon-theme()
{
	__cd $BASE_DIR/gnome-icon-theme
	
	./autogen.sh
	./configure  --prefix=/usr --enable-all-themes --enable-test-themes --enable-placeholders

	__mk
	__mk install
	ldconfig
}

__gnome-icon-theme-extras()
{
	__common $BASE_DIR/gnome-icon-theme-extras
}

__gnome-icon-theme-symbolic()
{
	__common $BASE_DIR/gnome-icon-theme-symbolic
}

__libtasn1()
{
	__common $BASE_DIR/libtasn1	
}

__p11-kit()
{
	__cd $BASE_DIR/p11-kit

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--sysconfdir=/etc

	__mk
	__mk install
	ldconfig
}

__gcr()
{
	__cd $BASE_DIR/gcr

	./autogen.sh --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--libexecdir=/usr/lib/gnome-keyring

	__mk
	__mk install
	ldconfig
}

__gnome-keyring()
{
	__common $BASE_DIR/gnome-keyring

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--with-pam-dir=/lib/security \
            	--with-root-certs=/etc/ssl/certs \
            	--without-ca-certificates
#            	--with-ca-certificates=/etc/ssl/ca-bundle.crt

	__mk
	__mk install
	ldconfig
}

__libwnck()
{
	__common $BASE_DIR/libwnck
}

__libcroco()
{
	__common $BASE_DIR/libcroco
}

__librsvg()
{
	__common $BASE_DIR/librsvg
}

__libgweather()
{
	__cd $BASE_DIR/libgweather

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--enable-locations-compression

	__mk
	__mk install
	ldconfig
}

__gnome-panel()
{
	__cd $BASE_DIR/gnome-panel

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--libexecdir=/usr/lib/gnome-applets \
		--disable-scrollkeeper

	__mk
	__mk install
	ldconfig
}

__gnome-session()
{
	__cd $BASE_DIR/gnome-session

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--libexecdir=/usr/lib/gnome-session

	__mk
	__mk install
	ldconfig
}

__db()
{
	__cd $BASE_DIR/db/build_unix

	../dist/configure --prefix=$PREFIX \
        	--enable-compat185	\
        	--enable-dbm       	\
      		--disable-static   	\
         	--enable-cxx

	__mk
	__mk install
	ldconfig
}

__curl()
{
	__cd $BASE_DIR/curl

	./configure --prefix=$PREFIX	\
		--disable-static	\
		--with-ca-path=/etc/ssl/certs

	__mk
	__mk install
	ldconfig
}

__openssl()
{
	__cd $BASE_DIR/openssl

	./config --prefix=/usr --openssldir=/etc/ssl shared

	make
	make MANDIR=/usr/share/man install
	ldconfig
}

__liboauth()
{
	__common $BASE_DIR/liboauth
}

__libgdata()
{
	__common $BASE_DIR/libgdata
}

__libical()
{
	__common $BASE_DIR/libical
}

__nss()
{
	__cd $BASE_DIR/nss

	patch -Np1 -i ../nss-3.13.5-standalone-1.patch
	cd mozilla/security/nss
	make nss_build_all BUILD_OPT=1	\
  		NSPR_INCLUDE_DIR=/usr/include/nspr \
  		USE_SYSTEM_ZLIB=1	\
  		ZLIB_LIBS=-lz		\
  		$([ $(uname -m) = x86_64 ] && echo USE_64=1) \
  		$([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1)

	cd ../../dist
	install -v -m755 Linux*/lib/*.so /usr/lib
	install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib
	install -v -m755 -d /usr/include/nss
	cp -v -RL {public,private}/nss/* /usr/include/nss
	chmod 644 /usr/include/nss/*
	install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin
	install -v -m644 Linux*/lib/pkgconfig/nss.pc /usr/lib/pkgconfig

	ldconfig
}

__evolution-data-server()
{
	__cd $BASE_DIR/evolution-data-server

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--libexecdir=/usr/lib/evolution-data-server \
            	--enable-vala-bindings

	__mk
	__mk install
	ldconfig
}

__libgee()
{
	__common $BASE_DIR/libgee
}

__telepathy-glib()
{
	__cd $BASE_DIR/telepathy-glib

	./autogen.sh
	./configure --prefix=$PREFIX	\
           	--libexecdir=/usr/lib/telepathy \
            	--enable-vala-bindings	\
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__folks()
{
	__cd $BASE_DIR/folks

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--enable-vala

	__mk
	__mk install
	ldconfig
}

__gjs()
{
	__common $BASE_DIR/gjs
}

__zenity()
{
	__common $BASE_DIR/zenity
}

__mutter()
{
	__cd $BASE_DIR/mutter

	./autogen.sh
	./configure --prefix=$PREFIX	\
		 --enable-compile-warnings=no

	__mk
	__mk install
	ldconfig
}

__iptables()
{
	__cd $BASE_DIR/iptables

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--exec-prefix=    	\
            	--bindir=/sbin    	\
            	--with-xtlibdir=/lib/xtables \
            	--with-pkgconfigdir=/usr/lib/pkgconfig

	__mk
	__mk install
	ln -sfv xtables-multi /sbin/iptables-xml
	ldconfig

	cd $BASE_DIR/blfs-bootscripts
	__mk install-iptables
}

__libnl()
{
	__cd $BASE_DIR/libnl

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__wireless-tools()
{
	__cd $BASE_DIR/wireless_tools

	__mk
	__mk PREFIX=$PREFIX INSTALL_MAN=/usr/share/man install
	ldconfig
}

__dhcpcd()
{
	__cd $BASE_DIR/dhcpcd

	./autogen.sh
	./configure --libexecdir=/lib/dhcpcd \
            	--dbdir=/run 		\
            	--sysconfdir=/etc

	__mk
	__mk install
	sed -i "s;/var/lib;/run;g" dhcpcd-hooks/50-dhcpcd-compat
	install -v -m 644 dhcpcd-hooks/50-dhcpcd-compat /lib/dhcpcd/dhcpcd-hooks/
	ldconfig

	cd $BASE_DIR/blfs-bootscripts
	__mk install-service-dhcpcd

cat > /etc/sysconfig/ifconfig.wlan0 << "EOF"
ONBOOT="no"
IFACE="wlan0"
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF
}

__NetworkManager()
{
	__cd $BASE_DIR/NetworkManager

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--localstatedir=/var 	\
            	--libexecdir=/usr/lib/NetworkManager \
            	--without-systemdsystemunitdir \
            	--disable-ppp		\
		--with-distro=lfs

	__mk
	__mk install
	ldconfig

cat >> /etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF

	cd $BASE_DIR/blfs-bootscripts
	__mk install-networkmanager
}

__telepathy-logger()
{
	__cd $BASE_DIR/telepathy-logger

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--libexecdir=/usr/lib/telepathy \
            	--disable-static

	__mk
	__mk install
	ldconfig
}

__startup-notification()
{
	__common $BASE_DIR/startup-notification
}

__gnome-shell()
{
	__cd $BASE_DIR/gnome-shell

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--libexecdir=/usr/lib/gnome-shell \
		--enable-compile-warnings=no \
            	--without-ca-certificates
#            	--with-ca-certificates=/etc/ssl/ca-bundle.crt

	__mk
	__mk install
	ldconfig
}

__gnome-themes-standard()
{
	__cd $BASE_DIR/gnome-themes-standard

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--enable-all-themes	\
		--enable-test-themes	\
		--enable-placeholders

	__mk
	__mk install
	ldconfig
}

__gnome-doc-utils()
{
	__common $BASE_DIR/gnome-doc-utils
}

__gnome-user-docs()
{
	__common $BASE_DIR/gnome-user-docs
}

__metacity()
{
	__common $BASE_DIR/metacity
}

__nautilus()
{
	__cd $BASE_DIR/nautilus

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
            	--libexecdir=/usr/lib/nautilus \
            	--disable-nst-extension	\
            	--disable-packagekit	\
		--enable-exif=no	\
		--enable-more-warnings=no

	__mk
	__mk install
	ldconfig
}

__libpeas()
{
	__cd $BASE_DIR/libpeas

	./autogen.sh
	./configure --prefix=$PREFIX \
            	--enable-vala

	__mk
	__mk install
	ldconfig
}

__eog()
{
	__common $BASE_DIR/eog
}

__dconf()
{
	__cd $BASE_DIR/dconf

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--libexecdir=/usr/lib/dconf

	__mk
	__mk install
	ldconfig
}

__gnome-terminal()
{
	__cd $BASE_DIR/gnome-terminal

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc	\
		--enable-compile-warnings=no \
		--disable-scrollkeeper

	__mk
	__mk install
	ldconfig
}

__gst-plugins-good()
{
	__cd $BASE_DIR/gst-plugins-good

	./autogen.sh
	./configure --prefix=$PREFIX	\
            	--sysconfdir=/etc 	\
            	--with-gtk=3.0

	__mk
	__mk install
}

__mx()
{
	__common $BASE_DIR/mx
}

__clutter-gst()
{
	__common $BASE_DIR/clutter-gst
}

__gmime()
{
	__cd $BASE_DIR/gmime

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--disable-static

	__mk

	pushd docs/tutorial
	docbook2html --nochunks gmime-tut.sgml
	docbook2pdf             gmime-tut.sgml
	docbook2ps              gmime-tut.sgml
	docbook2txt             gmime-tut.sgml
	popd

	__mk install
	ldconfig
}

__totem-pl-parser()
{
	__cd $BASE_DIR/totem-pl-parser
}

__totem()
{
	__cd $BASE_DIR/totem

	./autogen.sh
	./configure --prefix=$PREFIX	\
		--libexecdir=/usr/lib/totem \
        	--disable-static	\
		--disable-scrollkeeper

	__mk
	__mk install
	ldconfig
}

__mpg123()
{
	__common $BASE_DIR/mpg123
}

__ffmpeg()
{
	__cd $BASE_DIR/ffmpeg

	./autogen.sh
	./configure --prefix=$PREFIX	\
      		--enable-shared 	\
		--disable-static

	__mk
	__mk install
	ldconfig
}

__gst-ffmpeg()
{
	__common $BASE_DIR/gst-ffmpeg
}

__gtksourceview()
{
	__common $BASE_DIR/gtksourceview
}



#__librest
#__glib-networking
#__gnome-keyring
#__gnome-shell

#__dhcpcd
#__NetworkManager

#__mutter
#__gnome-shell

#__libgcrypt
#__cups
#__folks

#__gnome-terminal

#__nautilus

#__gnome-themes-standard
#__glib-networking
#exit



#__rem() {
__gobject-introspection
__nspr
__zip
__js
__polkit
__gconf
__gnome-backgrounds
__gnome-menus
__expat
__doxygen
__dbus
__libgpg-error
__libgcrypt
__libgnome-keyring
__libnotify
__certificate
__nettle
__gnutls
__glib-networking
__libxml
__libsoup
__librest
__json-glib
__gperf
__icu
__libxslt
__geoclue
__which
__sqlite3
__libpng
__cairo
__pango
__gstreamer
__gst-plugins-base
__webkit
__libsecret
__gnome-online-accounts
__lcms2
__pciutils
__libusb
__usbutils
__udev
__colord
__cups
__unzip
__docbook-xml
__itstool
__yelp-xsl
__yelp
__yelp-tools
__gnome-desktop
__libogg
__libvorbis
__libcanberra
__iso-codes
__libxklavier
__libgnomekbd
__libwacom
__json-c
__alsa-lib
__flac
__libsndfile
__check
__pulseaudio
__upower
__gnome-settings-daemon
__libgtop
__shared-mime-info
__atk
__cogl
__clutter
__clutter-gtk
__gnome-control-center
__gvfs
__gnome-icon-theme
__gnome-icon-theme-extras
__gnome-icon-theme-symbolic
__libtasn1
__p11-kit
__gcr
__gnome-keyring
__libwnck
__libcroco
__librsvg
__libgweather
__gnome-panel
__gnome-session
__db
__curl
__openssl
__liboauth
__libgdata
__libical
__nss
__evolution-data-server
__libgee
__telepathy-glib
###__folks
__gjs
__zenity
__mutter
__iptables
__libnl
__wireless-tools
__dhcpcd
__NetworkManager
__telepathy-logger
__startup-notification
__gnome-shell
__gnome-themes-standard
__gnome-doc-utils
__gnome-user-docs
__metacity
__nautilus

__libpeas
__eog
__dconf

__gnome-terminal

__gst-plugins-good
__mx
__clutter-gst
__gmime
__totem-pl-parser
__totem

__mpg123
__ffmpeg
__gst-ffmpeg

__gtksourceview


