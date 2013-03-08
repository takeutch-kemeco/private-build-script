#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__git-clean()
{
	git clone . b
	cp b/* . -rf
	rm b -rf
	git checkout master
	git pull
}

__bld-common()
{
	__git-clean

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr		\
              --sysconfdir=/etc		\
	      $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__libffi()
{
	__common libffi

	cp -f $BASE_DIR/libffi/`gcc -dumpmachine`/include/ffi.h /usr/include/
	cp -f $BASE_DIR/libffi/`gcc -dumpmachine`/include/ffitarget.h /usr/include/

	ldconfig
}

__pkg-config()
{
	__cd pkg-config
	rm -f /usr/bin/`gcc -dumpmachine`-pkg-config
	__bld-common --docdir=/usr/share/doc/pkg-config-0.28 \
                     --with-internal-glib
}

__pcre()
{
	__cd pcre

	svn cleanup
	svn update

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr                     \
              --docdir=/usr/share/doc/pcre      \
              --enable-utf                      \
              --enable-unicode-properties       \
              --enable-pcregrep-libz            \
              --enable-pcregrep-libbz2          \
              --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	cp -f /usr/lib/libpcre.la      /lib/
	cp -f /usr/lib/libpcrecpp.la   /lib/
	cp -f /usr/lib/libpcreposix.la /lib/

	ln -sf /usr/lib/libpcre.so      /lib/libpcre.so
	ln -sf /usr/lib/libpcrecpp.so   /lib/libpcrecpp.so
	ln -sf /usr/lib/libpcreposix.so /lib/libpcreposix.so
	ldconfig
}

__gtk-doc()
{
	__common gtk-doc
}

__glib()
{
	__cd glib
	__bld-common --with-pcre=system
}

__gobject-introspection()
{
	__common gobject-introspection
}

__expat()
{
	__common expat
}

__dbus()
{
	__cd dbus
	__git-clean

	git checkout origin/dbus-1.6
	git checkout -b 1.6
	git checkout 1.6

	groupadd -g 18 messagebus
	useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 18 -g messagebus -s /bin/false messagebus

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr	 			\
              --sysconfdir=/etc 			\
              --localstatedir=/var 			\
              --libexecdir=/usr/lib/dbus-1.0 		\
              --with-console-auth-dir=/run/console/ 	\
              --without-systemdsystemunitdir 		\
              --disable-systemd 			\
              --disable-static				\
	      --disable-tests

	$MAKE_CLEAN
#	__mk
#	__mk install
	make
	make install
	ldconfig

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
}

__at-spi2-core()
{
	__cd at-spi2-core
	__bld-common --libexecdir=/usr/lib/at-spi2-core
}

__atk()
{
	__common atk
}

__intltool()
{
#	__wget http://launchpad.net/intltool/trunk/0.50.2/+download/intltool-0.50.2.tar.gz
	__decord intltool-0.50.2
	__common intltool-0.50.2
	install -v -m644 -D doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO
}

__at-spi2-atk()
{
	__cd at-spi2-atk
	__git-clean
	git checkout AT_SPI2_ATK_2_7_5
	git checkout -b 2.7.5
	git checkout 2.7.5

	$DIST_CLEAN
	./autogen.sh
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__nasm()
{
	__wget http://www.nasm.us/pub/nasm/releasebuilds/2.10.07/nasm-2.10.07.tar.xz
	__wget http://www.nasm.us/pub/nasm/releasebuilds/2.10.07/nasm-2.10.07-xdoc.tar.xz
#	__decord nasm-2.10.07
	__cd nasm-2.10.07

	tar -xf ${SRC_DIR}/nasm-2.10.07-xdoc.tar.xz --strip-components=1

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -m755 -d         /usr/share/doc/nasm-2.10.07/html
	cp -v doc/html/*.html    /usr/share/doc/nasm-2.10.07/html
	cp -v doc/*.{txt,ps,pdf} /usr/share/doc/nasm-2.10.07
	cp -v doc/info/*         /usr/share/info
	install-info /usr/share/info/nasm.info /usr/share/info/dir
}

__libjpeg-turbo()
{
	__wget http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.2.1.tar.gz
	__dcd libjpeg-turbo-1.2.1

	__bld-common --mandir=/usr/share/man	\
                     --with-jpeg8

	docsdir=/usr/share/doc/libjpeg-turbo-1.2.1
	make docdir=$docsdir exampledir=$docsdir install
	unset docsdir
}

__libpng()
{
	__wget http://downloads.sourceforge.net/libpng/libpng-1.5.13.tar.xz
	__decord libpng-1.5.13
	__common libpng-1.5.13
}

__libtiff()
{
	__wget ftp://ftp.remotesensing.org/libtiff/tiff-4.0.3.tar.gz
	__decord tiff-4.0.3
	__common tiff-4.0.3
}

__gdk-pixbuf()
{
	__cd gdk-pixbuf
	__bld-common --with-x11
}

__freetype2()
{
	__cd freetype2
	sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h
	__bld-common
}

__fontconfig()
{
	__cd fontconfig
	__bld-common --localstatedir=/var		\
                     --docdir=/usr/share/doc/fontconfig	\
                     --disable-docs			\
                     --disable-static
}

__pixman()
{
	__common pixman
}

__cairo()
{
	__cd cairo
	__bld-common --enable-tee   		\
                     --enable-gl                \
                     --enable-xcb               \
                     --enable-gtk-doc           \
                     --enable-xcb-drm           \
                     --enable-glsv2             \
                     --enable-xlib-xcb          \
                     --enable-xml               \
                     --enable-directfb=auto     \
                     --enable-ft                \
                     --enable-fc
}

__ragel()
{
	__wget http://www.complang.org/ragel/ragel-6.8.tar.gz
	__dcd ragel-6.8
	__common ragel-6.8
}

__harfbuzz()
{
	__common harfbuzz
}

__pango()
{
	__common pango
	pango-querymodules --update-cache
}

__pangox-compat()
{
	__common pangox-compat
}

__gtk+3()
{
	__cd gtk+
	git-clean
	git checkout 3.7.8
	git checkout -b 3.7.8
	git checkout 3.7.8

        $DIST_CLEAN
        ./autogen.sh
        __cfg --prefix=/usr             \
              --sysconfdir=/etc         \
              $@

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

	gtk-query-immodules-3.0 --update-cache
	glib-compile-schemas /usr/share/glib-2.0/schemas

	mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/settings.ini << "EOF"
[Settings]
gtk-theme-name = Adwaita
gtk-fallback-icon-theme = gnome
EOF

cat > /etc/gtk-3.0/settings.ini << "EOF"
[Settings]
gtk-theme-name = Clearwaita
gtk-fallback-icon-theme = elementary
EOF
}

__glib-package()
{
#__rem() {
	__libffi
	__pkg-config
	__pcre
	__gtk-doc
	__glib
}

__dbus-package()
{
#__rem() {
	__expat
	__dbus
	
}

__at-spi2-package()
{
#__rem() {
	__dbus-package
	__gobject-introspection
	__at-spi2-core
	__atk
	__intltool
	__at-spi2-atk
}

__gdk-pixbuf-package()
{
#__rem() {
	__nasm
	__libjpeg-turbo
	__libpng
	__libtiff
	__gdk-pixbuf

}

__fontconfig-package()
{
#__rem() {
	__freetype2
	__fontconfig
}

__cairo-package()
{
#__rem() {
	__fontconfig-package
	__pixman
	__cairo
}

__harfbuzz-package()
{
#__rem() {
	__ragel
	__harfbuzz
}

__pango-package()
{
#__rem() {
	__cairo-package
	__harfbuzz-package
	__pango
	__pangox-compat
}

__all()
{
#__rem() {
	__glib-package
	__at-spi2-package
	__gdk-pixbuf-package
	__pango-package
	__gtk+3
}

$@

