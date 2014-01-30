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

__cairo()
{
    __dep libpng glib pixman fontconfig
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

__glib()
{
    __dep libffi python-27 pcre attr

    __git-clone git://git.gnome.org/glib
    __cd glib
    __bld-common --with-pcre=system --enable-debug=no
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

__harfbuzz()
{
    __dep glib icu freetype cairo gobject-introspection
}

__inetutils()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/inetutils.git
    __cd inetutils
    ./bootstrap
    ### ping, traceroute, telnet 以外は全て無効。
    ### r*系のツールはセキュリティー的観点からはシステムに入れるべきではない。
    __bld-common --libexecdir=/usr/sbin --localstatedir=/var \
                 --disable-servers --disable-ifconfig --disable-ftpd --disable-inetd --disable-rexecd \
                 --disable-rlogind --disable-rshd --disable-syslogd --disable-talkd --disable-telnetd \
                 --disable-tftpd --disable-uucpd --disable-ftp --disable-ping6 --disable-rcp \
                 --disable-rexec --disable-rlogin --disable-rsh --disable-logger --disable-talk \
                 --disable-tftp --disable-whois --disable-rpath --disable-ipv6
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

__librsvg()
{
    __dep gdk-pixbuf libcroco pango gtk+3 gobject-introspection vala

    __git-clone git://git.gnome.org/librsvg
    __cd librsvg
    __bld-common --enable-vala
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

__python-2.7.6()
{
    __dep expat libffi
}

__python-27()
{
    __python-2.7.6
}

__sysklogd()
{
    __dep ""

    __wget http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
    __dcd sysklogd-1.5
    __mk
    __mkinst BINDIR=/sbin

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

$@

