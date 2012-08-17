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

	__cd $BASE_DIR/blfs-bootscripts
	make install-dbus
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
            	--with-ca-certificates=/etc/ssl/ca-bundle.crt \
            	--disable-static

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

	./autogen.sh --prefix=$PREFIX	\
		--disable-static	\
		--enable-tee		\
		--enable-xcb

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

	./autogen.sh --prefix=$PREFIX	\
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

	./autogen.sh --prefix=$PREFIX	\
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



__rem() {
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
###__libgcrypt
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
###__cups
__unzip
__docbook-xml
__itstool
__yelp-xsl
__yelp
__yelp-tools
__gnome-desktop
}









exit

### memo ###

### gnome-themes
./configure --prefix=/usr --enable-all-themes --enable-test-themes --enable-placeholders

### glib-networking
./configure --prefix=/usr \
            --with-ca-certificates=/etc/ssl/ca-bundle.crt


