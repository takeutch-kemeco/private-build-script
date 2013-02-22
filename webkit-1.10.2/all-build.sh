#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__init-env()
{
	echo
}

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__gperf()
{
	__wget ftp://ftp.gnu.org/gnu/gperf/gperf-3.0.4.tar.gz
	__dcd gperf-3.0.4

	__cfg 	--prefix=/usr				\
		--docdir=/usr/share/doc/gperf-3.0.4

	__mk
	makeinfo -o doc/gperf.txt --plaintext doc/gperf.texi

	__mk install
	install -m644 -v doc/gperf.{dvi,ps,pdf,txt} /usr/share/doc/gperf-3.0.4

	pushd /usr/share/info
	rm -v dir
	for FILENAME in *; do
    		install-info $FILENAME dir 2>/dev/null
	done
	popd

	ldconfig
}

__gstreamer()
{
	__wget http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.0.5.tar.xz
	__common gstreamer-1.0.5
}

__gst-plugins-base()
{
	__wget http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.0.5.tar.xz
	__common gst-plugins-base-1.0.5
}

__harfbuzz()
{
	__wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.9.tar.bz2
	__common harfbuzz-0.9.9
}

__pango()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/pango/1.32/pango-1.32.5.tar.xz
	__common pango-1.32.5
	pango-querymodules --update-cache
}

__pangox-compat()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/pangox-compat/0.0/pangox-compat-0.0.2.tar.xz
	__common pangox-compat-0.0.2
}



__freetype()
{
	__wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/freetype-2.4.11.tar.bz2
	__wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/freetype-doc-2.4.11.tar.bz2
	__dcd freetype-2.4.11

	tar -xf ${SRC_DIR}/freetype-doc-2.4.11.tar.bz2 --strip-components=2 -C docs

	sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h

	__cfg --prefix=/usr

	__mk
	__mk install
	install -v -m755 -d /usr/share/doc/freetype-2.4.11
	cp -v -R docs/*     /usr/share/doc/freetype-2.4.11
	ldconfig
}

__expat()
{
	__wget http://downloads.sourceforge.net/expat/expat-2.1.0.tar.gz
	__dcd expat-2.1.0

	__cfg --prefix=/usr

	__mk
	__mk install
	install -v -m755 -d /usr/share/doc/expat-2.1.0
	install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.1.0
	ldconfig
}

__libxml()
{
	__wget ftp://xmlsoft.org/libxml2/libxml2-2.9.0.tar.gz
	__common libxml2-2.9.0
}

__fontconfig()
{
	__wget http://fontconfig.org/release/fontconfig-2.10.2.tar.bz2
	__dcd fontconfig-2.10.2

	__cfg --prefix=/usr 				\
              --sysconfdir=/etc 			\
              --localstatedir=/var 			\
              --docdir=/usr/share/doc/fontconfig-2.10.2	\
              --disable-docs

	__mk
	__mk install

	install -v -dm755 /usr/share/{man/man{3,5},doc/fontconfig-2.10.2/fontconfig-devel}
	install -v -m644 fc-*/*.1          /usr/share/man/man1
	install -v -m644 doc/*.3           /usr/share/man/man3
	install -v -m644 doc/fonts-conf.5  /usr/share/man/man5
	install -v -m644 doc/fontconfig-devel/* /usr/share/doc/fontconfig-2.10.2/fontconfig-devel
	install -v -m644 doc/*.{pdf,sgml,txt,html} /usr/share/doc/fontconfig-2.10.2

	ldconfig
}

__cairo()
{
	__wget http://cairographics.org/releases/cairo-1.12.10.tar.xz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/cairo-1.12.10-upstream_fix-1.patch
	__dcd cairo-1.12.10

	patch -Np1 -i ${SRC_DIR}/cairo-1.12.10-upstream_fix-1.patch

	__cfg --prefix=/usr \
              --enable-tee  \
              --enable-xcb

	__mk
	__mk install
	ldconfig
}

__icu()
{
	__wget http://download.icu-project.org/files/icu4c/50.1.2/icu4c-50_1_2-src.tgz

	cd ${BASE_DIR}
	gzip -dc ${SRC_DIR}/icu4c-50_1_2-src.tgz | tar xvf -

	__cd icu/source

	cp configure.in{,.orig}
	sed -e "s/clang++//g" configure.in.orig | sed -e "s/clang//" > configure.in
	rm configure
	autoconf

	__cfg --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__libxslt()
{
	__wget ftp://xmlsoft.org/libxslt/libxslt-1.1.28.tar.gz
	__common libxslt-1.1.28
}

__gsettings-desktop-schemas()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gsettings-desktop-schemas/3.6/gsettings-desktop-schemas-3.6.1.tar.xz
	__common gsettings-desktop-schemas-3.6.1
	glib-compile-schemas /usr/share/glib-2.0/schemas
}

__glib-networking()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/glib-networking/2.34/glib-networking-2.34.2.tar.xz
	__dcd glib-networking-2.34.2

	__cfg --prefix=/usr					\
              --libexecdir=/usr/lib/glib-networking		\
	      --with-ca-certificates=/etc/ssl/ca-bundle.crt

	__mk
	__mk install
	ldconfig
}

__libsoup()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/libsoup/2.40/libsoup-2.40.3.tar.xz
	__dcd libsoup-2.40.3
	__bld-common --without-gnome
}

__p11-kit()
{
	__wget http://p11-glue.freedesktop.org/releases/p11-kit-0.14.tar.gz
	__common p11-kit-0.14
}

__nettle()
{
	__wget ftp://ftp.gnu.org/gnu/nettle/nettle-2.6.tar.gz
	__common nettle-2.6

	chmod -v 755 /usr/lib/libhogweed.so.2.3 /usr/lib/libnettle.so.4.5
	install -v -m755 -d /usr/share/doc/nettle-2.6
	install -v -m644 nettle.html /usr/share/doc/nettle-2.6
}

__libtasn()
{
	__wget ftp://ftp.gnu.org/gnu/libtasn1/libtasn1-3.2.tar.gz
	__common libtasn1-3.2
}

__gnutls()
{
	__wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.1/gnutls-3.1.6.tar.xz
	__common gnutls-3.1.6
}

__sqlite()
{
	__wget http://sqlite.org/sqlite-autoconf-3071502.tar.gz
	__wget http://sqlite.org/sqlite-doc-3071502.zip
	__dcd sqlite-autoconf-3071502

###	unzip -q $SRC_DIR/sqlite-doc-3071502.zip

	./configure --prefix=/usr			\
        	CFLAGS="-g -O2 -DSQLITE_ENABLE_FTS3=1 	\
                      -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                      -DSQLITE_ENABLE_UNLOCK_NOTIFY=1	\
                      -DSQLITE_SECURE_DELETE=1"

	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/doc/sqlite-3.7.15.2
	cp -v -R sqlite-doc-3071502/* /usr/share/doc/sqlite-3.7.15.2
}

__which()
{
	__wget ftp://ftp.gnu.org/gnu/which/which-2.20.tar.gz
	__common which-2.20
}

__make()
{
	__wget http://ftp.gnu.org/gnu/make/make-3.82.tar.bz2
	__wget http://www.linuxfromscratch.org/patches/downloads/make/make-3.82-upstream_fixes-3.patch
	__dcd make-3.82

	patch -Np1 -i ${SRC_DIR}/make-3.82-upstream_fixes-3.patch

	__bld-common
}

__webkit()
{
	__wget http://webkitgtk.org/releases/webkitgtk-1.10.2.tar.xz
	__dcd webkitgtk-1.10.2

	sed -i '/generate-gtkdoc --rebase/s:^:# :' GNUmakefile.in

	__cfg --prefix=/usr 			\
              --libexecdir=/usr/lib/WebKitGTK	\
              --with-gstreamer=1.0		\
              --enable-introspection		\
	      --disable-geolocation

	__mk
	__mk install
}

__package-gnutls()
{
#__rem() {
	__p11-kit
	__nettle
	__libtasn
	__gnutls
}

__package-libsoup()
{
#__rem() {
	__package-gnutls
	__gsettings-desktop-schemas
	__glib-networking
	__libsoup
}

__package-cairo()
{
#__rem() {
	__freetype
	__expat
	__libxml
	__fontconfig
	__cairo
}

__package-pango()
{
#__rem() {
	__harfbuzz
	__pango
	__pangox-compat
}

__package-gstreamer()
{
#__rem() {
	__gstreamer
	__gst-plugins-base
}

__all()
{
#__rem() {
	__gperf
	__package-cairo
	__package-pango
	__package-gstreamer
###	__icu
	__libxslt
	__package-libsoup
	__sqlite
	__which
	__make
	__webkit
}

__init-env
$@

