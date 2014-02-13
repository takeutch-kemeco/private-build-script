#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__attr()
{
    __dep ""

    __git-clone git://git.savannah.nongnu.org/attr.git
    __cd attr
    __bld-common INSTALL_USER=root INSTALL_GROUP=root
}

__acl()
{
    __dep attr

    __git-clone git://git.savannah.nongnu.org/acl.git
    __cd acl
    __bld-common INSTALL_USER=root INSTALL_GROUP=root
}

__atk()
{
    __dep glib

    __git-clone git://git.gnome.org/atk
    __common atk
}

__at-spi2-atk()
{
    __dep at-spi2-core atk

    __git-clone git://git.gnome.org/at-spi2-atk
    __common at-spi2-atk
}

__at-spi2-core()
{
    __dep dbus glib intltool gobject-introspection

    __git-clone git://git.gnome.org/at-spi2-core
    __common at-spi2-core
}

__cairo()
{
    __dep libpng glib pixman fontconfig

    __git-clone git://anongit.freedesktop.org/git/cairo
    __cd cairo
    __bld-common --enable-tee               \
                 --enable-gl                \
                 --enable-xcb               \
                 --enable-glsv2             \
                 --enable-xlib-xcb          \
                 --enable-directfb=auto     \
                 --enable-ft                \
                 --enable-fc
}

__cogl()
{
    __dep gdk-pixbuf mesalib pango gobject-introspection

    __git-clone git://git.gnome.org/cogl
    __cd cogl
    __bld-common \
        --enable-debug=no               \
        --enable-cairo=yes              \
        --enable-maintainer-flags=yes   \
        --disable-glibtest              \
        --enable-glib=yes               \
        --enable-cogl-pango=yes         \
        --enable-gdk-pixbuf=yes         \
        --enable-examples-install=no    \
        --enable-gles1=yes              \
        --enable-gles2=yes              \
        --enable-gl=yes                 \
        --enable-cogl-gles2=yes         \
        --enable-glx=yes                \
        --enable-wgl=no                 \
        --enable-sdl=no                 \
        --enable-sdl2=yes               \
        --enable-xlib-egl-platform=yes  \
        --enable-introspection=yes
}

__convmv-1.15()
{
    __dep perl

    __wget https://www.j3e.de/linux/convmv/convmv-1.15.tar.gz
    __dcd convmv-1.15
    sudo install convmv /usr/bin/convmv
}

__convmv()
{
    __convmv-1.15
}

__coreutils-git()
{
    __dep acl attr

    __git-clone git://git.savannah.gnu.org/coreutils.git
    __common coreutils
}

__coreutils-8.22()
{
    __dep acl attr

    __wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.22.tar.xz
    __dcd coreutils-8.22
    __bld-common
}

__coreutils()
{
    __coreutils-8.22
}

__colord()
{
    __dep glib intltool lcms2 sqlite dbus

    __git-clone git://github.com/hughsie/colord.git
    __cd colord
    sudo groupadd -g 71 colord
    sudo useradd -c "Color Daemon Owner" -d /var/lib/colord -u 71 -g colord -s /bin/false colord
    __bld-common --localstatedir=/var --with-daemon-user=colord --enable-vala \
                 --disable-bash-completion --disable-systemd-login
}

__dbus()
{
    __dep expat

    __git-clone git://anongit.freedesktop.org/dbus/dbus
    sudo groupadd -g 27 messagebus
    sudo useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 27 \
                 -g messagebus -s /bin/false messagebus
    __cd dbus
    __bld-common --localstatedir=/var                   \
                 --libexecdir=/usr/lib/dbus-1.0         \
                 --with-console-auth-dir=/run/console/  \
                 --without-systemdsystemunitdir         \
                 --disable-systemd                      \
                 --disable-Werror                       \
                 --disable-tests

    sudo dbus-uuidgen --ensure

    T=mktemp
    cat > $T << .
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
.
    sudo install $T /etc/dbus-1/session-local.conf
}

__doxygen()
{
    __dep ghostscript python2

    __wget http://ftp.stack.nl/pub/doxygen/doxygen-1.8.6.src.tar.gz
    __dcd doxygen-1.8.6
    ./configure --prefix /usr --docdir /usr/share/doc/doxygen-1.8.6
    __mk
    __mkinst
}

__fontconfig()
{
    __dep freetype2 expat

    __git-clone git://anongit.freedesktop.org/fontconfig
    __cd fontconfig
    __bld-common --localstatedir=/var --disable-docs
}

__freetype2()
{
    __dep which libpng

    __git-clone git://git.sv.gnu.org/freetype/freetype2.git
    __cd freetype2
    cp include/config/{ftoption.h,ftoption.h.orig}
    sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/config/ftoption.h
    __bld-common
    cp include/config/{ftoption.h.orig,ftoption.h}
}

__geany()
{
    __dep gtk+2

    __git-clone git://github.com/geany/geany.git
    __cd geany
    __bld-common --enable-gtk3
}

__gettext-0.18.3.2()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/gettext/gettext-0.18.3.2.tar.gz
    __dcd gettext-0.18.3.2
    __bld-common
}

__gettext()
{
    __gettext-0.18.3.2
}

__gdk-pixbuf()
{
    __dep glib libjpeg libpng libtiff gobject-introspection

    __git-clone git://git.gnome.org/gdk-pixbuf
    __cd gdk-pixbuf
    __bld-common --with-x11
    sudo gdk-pixbuf-query-loaders --update-cache
}

__glib()
{
    __dep libffi python-27 pcre attr

    __git-clone git://git.gnome.org/glib
    __cd glib
    __bld-common --with-pcre=system --enable-debug=no
}

__gobject-introspection()
{
    __git-clone git://git.gnome.org/gobject-introspection
    __cd gobject-introspection
    __bld-common PYTHON=/usr/bin/python2
}

__gnome-icon-theme()
{
    __dep gtk+3 gtk+2 hicolor-icon-themes icon-naming-utils intltool xml::simple

    __git-clone git://git.gnome.org/gnome-icon-theme
    __common gnome-icon-theme
}

__gnome-icon-theme-extras()
{
    __dep gnome-icon-theme

    __git-clone git://git.gnome.org/gnome-icon-theme-extras
    __common gnome-icon-theme-extras
}

__gnome-icon-theme-symbolic()
{
    __dep gnome-icon-theme

    __git-clone git://git.gnome.org/gnome-icon-theme-symbolic
    __common gnome-icon-theme-symbolic
}

__gnome-themes-standard()
{
    __dep gtk+2 gtk+3 librsvg

    __git-clone git://git.gnome.org/gnome-themes-standard
    __common gnome-themes-standard
}

__gtk+2()
{
    __dep atk gdk-pixbuf pango gobject-introspection

    __git-clone git://git.gnome.org/gtk+
    __git-clone gtk+ gtk+-2.24.git
    __cd gtk+-2.24.git
    git checkout master
    git pull
    git branch -D 2.24.22
    git checkout 2.24.22
    git checkout -b 2.24.22
    __bld-common --with-xinput --with-gdktarget=x11 --with-x
    sudo gtk-query-immodules-2.0 --update-cache

cat > /tmp/t << "EOF"
include "/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
gtk-icon-theme-name = "Mist"
EOF
    sudo cp /tmp/t /etc/gtk-2.0/gtkrc
}

__gtk+3()
{
    __dep at-spi2-atk gdk-pixbuf pango

    __git-clone git://git.gnome.org/gtk+
    __common gtk+
    sudo gtk-query-immodules-3.0 --update-cache
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas

cat > /tmp/t << "EOF"
[Settings]
gtk-theme-name = Adwaita
gtk-fallback-icon-theme = Mist
EOF
    sudo cp /tmp/t /etc/gtk-3.0/settings.ini
}

__harfbuzz()
{
    __dep glib icu freetype cairo gobject-introspection
}

__iana-etc-2.30()
{
    __dep ""

    __wget http://anduin.linuxfromscratch.org/sources/LFS/lfs-packages/conglomeration//iana-etc/iana-etc-2.30.tar.bz2
    __dcd iana-etc-2.30
    __mk
    __mkinst
}

__iana-etc()
{
    __iana-etc-2.30
}

__inetutils()
{
    __dep syslog.conf

    __git-clone git://git.savannah.gnu.org/inetutils.git
    __cd inetutils
    ./bootstrap
    ### ping, traceroute, telnet, inetd, logger, whois, syslogd 以外は全て無効。
    ### syslogd は、sysklogd でも同名のバイナリーがインストールされるので注意。
    ### （どちらを使うか等は、管理者が意図的にコントロールすること）
    ### r*系のツールはセキュリティー的観点からはシステムに入れるべきではない。
    __bld-common --libexecdir=/usr/sbin --localstatedir=/var \
                 --disable-ifconfig --disable-ftpd --disable-rexecd \
                 --disable-rlogind --disable-rshd --disable-talkd --disable-telnetd \
                 --disable-tftpd --disable-uucpd --disable-ftp --disable-ping6 --disable-rcp \
                 --disable-rexec --disable-rlogin --disable-rsh --disable-talk \
                 --disable-tftp --disable-rpath --disable-ipv6
}

__iproute2()
{
    __dep ""

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git
    __cd iproute2
    __mk DESTDIR=
    __mkinst DESTDIR= SBINDIR=/sbin MANDIR=/usr/share/man DOCDIR=/usr/share/doc/iproute2
}

__libcap()
{
    __dep attr linux-pam

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/morgan/libcap.git
    __cd libcap
    __mkinst prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
}

__lcms2()
{
    __dep libjpeg libtiff

    __git-clone https://github.com/mm2/Little-CMS.git lcms2
    __cd lcms2
    __self-autogen
    __bld-common
}

__libcroco()
{
    __dep glib libxml

    __git-clone git://git.gnome.org/libcroco
    __common libcroco
}

__libffi()
{
    __dep ""

    __git-clone https://github.com/atgreen/libffi.git
    __common libffi
}

__libjpeg-8()
{
    __dep ""

    __wget http://www.ijg.org/files/jpegsrc.v8.tar.gz
    __decord jpegsrc.v8
    __common jpeg-8
}

__libjpeg-9a()
{
    __dep ""

    __wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz
    __decord jpegsrc.v9a
    __common jpeg-9a
}

__libjpeg()
{
    __libjpeg-9a
}

__librsvg()
{
    __dep gdk-pixbuf libcroco pango gtk+3 gobject-introspection vala

    __git-clone git://git.gnome.org/librsvg
    __cd librsvg
    __bld-common --enable-vala
}

__libtiff-4.0.3()
{
    __dep libjpeg-8

    __wget ftp://ftp.remotesensing.org/libtiff/tiff-4.0.3.tar.gz
    __dcd tiff-4.0.3
    __bld-common
}

__libtiff()
{
    __libtiff-4.0.3
}

__libxml2()
{
    __dep python-27

    __git-clone git://git.gnome.org/libxml2
    __common libxml2
}

__pango()
{
    __dep cairo harfbuzz xorg gobject-introspenction

    __git-clone git://git.gnome.org/pango
    __common pango
    sudo pango-querymodules --update-cache
}

__pcre-8.34()
{
    __dep ""

    __wget http://downloads.sourceforge.net/pcre/pcre-8.34.tar.bz2
    __dcd  pcre-8.34
    __bld-common --docdir=/usr/share/doc/pcre-8.34 --enable-unicode-properties \
                 --enable-pcre16 --enable-pcre32 \
                 --enable-pcregrep-libz --enable-pcregrep-libbz2 \
                 --enable-pcretest-libreadline
}

__pcre()
{
    __pcre-8.34
}

__pixman()
{
    __dep ""

    __git-clone git://anongit.freedesktop.org/pixman
    __common pixman
}

__python-2.7.6()
{
    __dep expat libffi
}

__python-27()
{
    __python-2.7.6
}

__sysklogd-1.5()
{
    __dep syslog.conf

    __wget http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
    __dcd sysklogd-1.5
    __mk
    __mkinst BINDIR=/sbin

}

__sysklogd()
{
    __sysklogd-1.5
}

__syslog.conf()
{
    __dep ""

    T=mktemp
    cat > $T << .
auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *
.
    sudo cp $T /etc/syslog.conf
}

__sqlite-3.8.2()
{
    __dep unzip

    __wget http://sqlite.org/2013/sqlite-autoconf-3080200.tar.gz
    __dcd sqlite-autoconf-3080200
    ./configure --prefix=/usr --sysconfdir=/etc \
                CFLAGS="-DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                        -DSQLITE_ENABLE_UNLOCK_NOTIFY=1 -DSQLITE_SECURE_DELETE=1"
    __mk
    __mkinst
}

__sqlite()
{
    __sqlite-3.8.2
}

__tar-1.27()
{
    __dep acl attr

    __wget http://ftp.gnu.org/gnu/tar/tar-1.27.tar.xz
    __dcd tar-1.27
    __bld-common
}

__tar-git()
{
    __dep acl attr

    __git-clone git://git.savannah.gnu.org/tar.git
    __common tar
}

__tar()
{
    __tar-1.27
}

__unzip()
{
    __dep ""

    __wget http://downloads.sourceforge.net/infozip/unzip60.tar.gz
    __dcd unzip60
    sed -i -e 's/CFLAGS="-O -Wall/& -DNO_LCHMOD/' unix/Makefile
    __mk -f unix/Makefile linux_noasm
    __mkinst prefix=/usr MANDIR=/usr/share/man/man1
}

__vala-0.22.1()
{
    __dep glib dbus libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/vala/0.22/vala-0.22.1.tar.xz
    __dcd vala-0.22.1
    __bld-common
}

__vala-git()
{
    __dep glib dbus libxslt

    __git-clone git://git.gnome.org/vala
    __common vala
}

__vala()
{
    __vala-0.22.1
}

$1

