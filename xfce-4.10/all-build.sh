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
	XFCE_URL="http://archive.xfce.org/xfce/4.10/src"
}

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc

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

__perl-module-common()
{
	__dcd $1

	perl Makefile.PL
	__mk
	__mk install
	ldconfig
}

__which()
{
	__wget ftp://ftp.gnu.org/gnu/which/which-2.20.tar.gz
	__common which-2.20
}

__perl-module-uri()
{
	__wget http://www.cpan.org/authors/id/G/GA/GAAS/URI-1.60.tar.gz
	__perl-module-common URI-1.60
}

__libffi()
{
	__wget ftp://sourceware.org/pub/libffi/libffi-3.0.11.tar.gz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/libffi-3.0.11-includedir-1.patch

	__dcd libffi-3.0.11
	patch -Np1 -i ../libffi-3.0.11-includedir-1.patch

	__bld-common
}

__pcre()
{
	__wget http://downloads.sourceforge.net/pcre/pcre-8.32.tar.bz2

	__dcd pcre-8.32
	patch -Np1 -i ../libffi-3.0.11-includedir-1.patch

	__cfg --prefix=/usr			\
      	      --docdir=/usr/share/doc/pcre-8.32	\
              --enable-utf                      \
              --enable-unicode-properties       \
              --enable-pcregrep-libz            \
              --enable-pcregrep-libbz2          \
              --disable-static

	__mk
	__mk install
	ldconfig

	mv -v /usr/lib/libpcre.so.* /lib
	ln -sfv ../../lib/libpcre.so.1.2.0 /usr/lib/libpcre.so
}

__pkg-config()
{
	__wget http://pkgconfig.freedesktop.org/releases/pkg-config-0.27.1.tar.gz
	__dcd pkg-config-0.27.1

	$DIST_CLEAN
	__cfg --prefix=/usr				\
              --docdir=/usr/share/doc/pkg-config-0.27.1	\
              --with-internal-glib

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__glib()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/glib/2.34/glib-2.34.2.tar.xz
	__dcd glib-2.34.2

	$DIST_CLEAN
	__cfg --prefix=/usr --with-pcre=system

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__dbus()
{
	__wget http://dbus.freedesktop.org/releases/dbus/dbus-1.6.8.tar.gz
	__dcd dbus-1.6.8

	groupadd -g 18 messagebus
	useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 18 -g messagebus -s /bin/false messagebus

	$DIST_CLEAN
	__cfg --prefix=/usr				\
              --sysconfdir=/etc 			\
              --localstatedir=/var 			\
              --libexecdir=/usr/lib/dbus-1.0 		\
              --with-console-auth-dir=/run/console/ 	\
              --without-systemdsystemunitdir 		\
              --disable-systemd 			\
              --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	mv -v /usr/share/doc/dbus /usr/share/doc/dbus-1.6.8

	dbus-uuidgen --ensure

	ls /etc/dbus-1/session-local.conf
	if [ $? -ne 0 ]
	then
cat > /etc/dbus-1/session-local.conf << .
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
.
	fi
}

__blfs-bootscripts-dbus()
{
	__wget http://www.linuxfromscratch.org/blfs/downloads/svn/blfs-bootscripts-20120828.tar.bz2
	__dcd blfs-bootscripts-20120828

	__mk install-dbus
	ldconfig

	cp -v /etc/rc.d/init.d/dbus{,.orig}
	sed -e "s/\. \/lib\/lsb\/init-functions//g" \
		/etc/rc.d/init.d/dbus.orig > /etc/rc.d/init.d/dbus
}

__dbus-glib()
{
	__wget http://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.100.tar.gz
	__dcd dbus-glib-0.100

	$DIST_CLEAN
	__cfg --prefix=/usr			\
              --sysconfdir=/etc			\
              --libexecdir=/usr/lib/dbus-1.0 	\
              --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gobject-introspection()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.34/gobject-introspection-1.34.2.tar.xz
	__common gobject-introspection-1.34.2
}

__atk()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/atk/2.6/atk-2.6.0.tar.xz
	__common atk-2.6.0
}

__cairo()
{
	__wget http://cairographics.org/releases/cairo-1.12.8.tar.xz
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/cairo-1.12.8-expose_snapshot-1.patch

	__dcd cairo-1.12.8
	patch -Np1 -i ../cairo-1.12.8-expose_snapshot-1.patch

	$DIST_CLEAN
	__cfg --prefix=/usr	\
              --enable-tee  	\
              --enable-xcb  	\
              --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libjpeg-8d()
{
	__wget http://www.ijg.org/files/jpegsrc.v8d.tar.gz
	__decord jpegsrc.v8d
	__cd jpeg-8d
	__bld-common
}

__libtiff()
{
	__wget ftp://ftp.remotesensing.org/libtiff/tiff-4.0.3.tar.gz
	__common tiff-4.0.3
}

__gdk-pixbuf()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.26/gdk-pixbuf-2.26.5.tar.xz
	__dcd gdk-pixbuf-2.26.5

	$DIST_CLEAN
	__cfg --prefix=/usr --with-x11

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__harfbuzz()
{
	__wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.6.tar.bz2
	__common harfbuzz-0.9.6
}

__pango()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/pango/1.32/pango-1.32.2.tar.xz
	__common pango-1.32.2

	pango-querymodules --update-cache

	__pangox-compat()
	{
		__wget ftp://ftp.gnome.org/pub/gnome/sources/pangox-compat/0.0/pangox-compat-0.0.2.tar.xz
		__common pangox-compat-0.0.2
	}

	__pangox-compat
}

__hicolor-icon-theme()
{
	__wget http://icon-theme.freedesktop.org/releases/hicolor-icon-theme-0.12.tar.gz
	__common hicolor-icon-theme-0.12
}

__gtk+2()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.13.tar.xz
	__dcd gtk+-2.24.13

	sed -i 's#l \(gtk-.*\).sgml#& -o \1#' docs/{faq,tutorial}/Makefile.in
	sed -i 's#.*@man_#man_#' docs/reference/gtk/Makefile.in

	$DIST_CLEAN
	__cfg --prefix=/usr		\
	      --sysconfdir=/etc		\
	      --with-xinput=yes 	\
	      --with-gdktarget=x11 	\
	      --with-x

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	ls /etc/gtk-2.0/gtk.immodules
	if [ $? -ne 0 ]
	then
		gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
	fi

	ls /etc/gtk-2.0/gtkrc
	if [ $? -ne 0 ]
	then
cat > /etc/gtk-2.0/gtkrc << .
include "/usr/share/themes/Clearlooks/gtk-2.0/gtkrc"
gtk-icon-theme-name = "elementary"
.
	fi
}

__perl-module-xml-simple()
{
	__wget http://cpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.20.tar.gz
	__perl-module-common XML-Simple-2.20
}

__icon-naming-utils()
{
	__wget http://tango.freedesktop.org/releases/icon-naming-utils-0.8.90.tar.bz2
	__dcd icon-naming-utils-0.8.90

	$DIST_CLEAN
	__cfg --prefix=/usr				\
	      --libexecdir=/usr/lib/icon-naming-utils

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__gtk-engines()
{
	__wget http://ftp.gnome.org/pub/gnome/sources/gtk-engines/2.20/gtk-engines-2.20.2.tar.bz2
	__common gtk-engines-2.20.2
}

__gnome-themes()
{
	__wget http://ftp.gnome.org/pub/gnome/sources/gnome-themes/2.32/gnome-themes-2.32.1.tar.bz2
	__common gnome-themes-2.32.1
}

__gnome-icon-theme()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme/2.31/gnome-icon-theme-2.31.0.tar.bz2
	__common gnome-icon-theme-2.31.0
}

__gnome-icon-theme-extras()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme-extras/2.30/gnome-icon-theme-extras-2.30.1.tar.bz2
	__common gnome-icon-theme-extras-2.30.1
}

__gnome-icon-theme-symbolic()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/gnome-icon-theme-symbolic/2.31/gnome-icon-theme-symbolic-2.31.0.tar.bz2
	__common gnome-icon-theme-symbolic-2.31.0
}

__libwnck()
{
	__wget ftp://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
	__dcd libwnck-2.30.7

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-static --program-suffix=-1

	$MAKE_CLEAN
	__mk GETTEXT_PACKAGE=libwnck-1
	__mk GETTEXT_PACKAGE=libwnck-1 install
	ldconfig
}

__libxfce4util()
{
	__wget $XFCE_URL/libxfce4util-4.10.0.tar.bz2
	__common libxfce4util-4.10.0
}

__xfconf()
{
	__wget $XFCE_URL/xfconf-4.10.0.tar.bz2
	__common xfconf-4.10.0
}

__libxfce4ui()
{
	__wget $XFCE_URL/libxfce4ui-4.10.0.tar.bz2
	__common libxfce4ui-4.10.0
}

__exo()
{
	__wget $XFCE_URL/exo-0.8.0.tar.bz2
	__common exo-0.8.0
}

__thunar()
{
	__wget $XFCE_URL/Thunar-1.4.0.tar.bz2
	__common Thunar-1.4.0
}

__garcon()
{
	__wget $XFCE_URL/garcon-0.2.0.tar.bz2
	__common garcon-0.2.0
}

__gtk-xfce-engine()
{
	__wget $XFCE_URL/gtk-xfce-engine-3.0.0.tar.bz2
	__common gtk-xfce-engine-3.0.0
}

__thunar-volman()
{
	__wget $XFCE_URL/thunar-volman-0.8.0.tar.bz2
	__common thunar-volman-0.8.0
}

__tumbler()
{
	__wget $XFCE_URL/tumbler-0.1.25.tar.bz2
	__common tumbler-0.1.25
}

__xfce4-appfinder()
{
	__wget $XFCE_URL/xfce4-appfinder-4.10.0.tar.bz2
	__common xfce4-appfinder-4.10.0
}

__xfce4-dev-tools()
{
	__wget $XFCE_URL/xfce4-dev-tools-4.10.0.tar.bz2
	__common xfce4-dev-tools-4.10.0
}

__xfce4-panel()
{
	__wget $XFCE_URL/xfce4-panel-4.10.0.tar.bz2
	__common xfce4-panel-4.10.0
}

__xfce4-power-manager()
{
	__wget $XFCE_URL/xfce4-power-manager-1.2.0.tar.bz2
	__common xfce4-power-manager-1.2.0
}

__xfce4-session()
{
	__wget $XFCE_URL/xfce4-session-4.10.0.tar.bz2
	__common xfce4-session-4.10.0
}

__xfce4-settings()
{
	__wget $XFCE_URL/xfce4-settings-4.10.0.tar.bz2
	__common xfce4-settings-4.10.0
}

__xfdesktop()
{
	__wget $XFCE_URL/xfdesktop-4.10.0.tar.bz2
	__common xfdesktop-4.10.0
}

__xfwm4()
{
	__wget $XFCE_URL/xfwm4-4.10.0.tar.bz2
	__common xfwm4-4.10.0
}

__init-env

__all-required()
{
#	__rem() {
	__which
	__perl-module-uri
	__libffi
	__pcre
	__pkg-config
	__glib
	__dbus
	__blfs-bootscripts-dbus
	__dbus-glib
	__gobject-introspection
	__atk
	__cairo
	__libjpeg-8d
	__libtiff
	__gdk-pixbuf
	__harfbuzz
	__pango
	__hicolor-icon-theme
	__gtk+2
	__perl-module-xml-simple
	__icon-naming-utils
	__gtk-engines
	__gnome-themes
	__gnome-icon-theme
	__gnome-icon-theme-extras
	__gnome-icon-theme-symbolic
	__libwnck
}

__all()
{
#	__rem() {
	__all-required
	__libxfce4util
	__xfconf
	__libxfce4ui
	__exo
	__thunar
	__garcon
	__gtk-xfce-engine
###	__thunar-volman # required gudev
	__tumbler
	__xfce4-appfinder
	__xfce4-dev-tools
	__xfce4-panel
###	__xfce4-power-manager # required libnotify
	__xfce4-session
	__xfce4-settings
	__xfdesktop
	__xfwm4
}

$@

