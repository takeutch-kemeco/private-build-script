#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

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

__apr-1.5.0()
{
    __dep ""

    __wget http://archive.apache.org/dist/apr/apr-1.5.0.tar.bz2
    __dcd apr-1.5.0
    __bld-common
}

__apr()
{
    __apr-1.5.0
}

__apr-util-1.5.3()
{
    __dep apr openssl sqlite

    __wget http://archive.apache.org/dist/apr/apr-util-1.5.3.tar.bz2
    __dcd apr-util-1.5.3
    __bld-common --with-apr=/usr --with-gdbm=/usr --with-openssl=/usr --with-crypto
}

__apr-util()
{
    __apr-util-1.5.3
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

__binutils-2.24()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2
    __decord binutils-2.24
    __cdbt
    ../binutils-2.24/configure --prefix=/usr --enable-shared
    __mk tooldir=/usr
    __mkinst tooldir=/usr install
}

__binutils()
{
    __binutils-2.24
}

__bison-git()
{
    ### flex と bison は開発版を入れるべきではない
    echo
}

__bison-3.0.2()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/bison/bison-3.0.2.tar.xz
    __dcd bison-3.0.2
    __bld-common
}

__bison()
{
    __bison-3.0.2
}

__cairo()
{
    __dep libpng glib pixman fontconfig

    __git-clone git://anongit.freedesktop.org/git/cairo
    __cd cairo
    __bld-common --enable-tee --enable-gl --enable-xcb --enable-glsv2 --enable-xlib-xcb \
        --enable-directfb=no --enable-ft --enable-fc --enable-test-surfaces=no
}

__cmake()
{
    __git-clone git://cmake.org/cmake.git
    __cd cmake
    ./bootstrap
    __bld-common-simple --system-libs --mandir=/share/man --docdir=/share/doc/cmake
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
        --enable-sdl2=no                \
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

__curl()
{
    __dep "?"

    __git-clone git://github.com/bagder/curl.git
    __cd curl
    ./buildconf
    __bld-common --enable-threaded-resolver --with-ca-path=/etc/ssl/certs
}

__cython-0.20.1()
{
    __dep python2

    __wget http://cython.org/release/Cython-0.20.1.tar.gz
    __dcd Cython-0.20.1
    sudo python2 ./setup.py install
}

__cython()
{
    __cython-0.20.1
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

__dbus-glib()
{
    __dep "?"

    git clone git://anongit.freedesktop.org/dbus/dbus-glib
    __cd dbus-glib
    __bld-common --libexecdir=/usr/lib/dbus-1.0
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

__eudev()
{
    __dep "?"

    __git-clone git://github.com/gentoo/eudev.git
    __cd eudev
    ./autogen.sh
    ./configure --prefix=/usr --exec-prefix= --sysconfdir=/etc --enable-libkmod \
	--with-rootprefix= --with-rootlibdir=/lib --enable-legacylib
    __mk
    __mkinst
}

__flex-git()
{
    ### flex と bison は開発版を入れるべきではない
    echo
}

__flex-2.5.37()
{
### __dep "texlive"
    __dep ""

    __wget http://downloads.sourceforge.net/project/flex/flex-2.5.37.tar.bz2
    __dcd flex-2.5.37

    ### texliveが無くてもビルドできるようにMakefileを修正
    cp configure.in{,.orig}
    cat configure.in.orig | sed -e "s/^doc\/Makefile.*$//g" > configure.in
    cp Makefile.am{,.orig}
    cat Makefile.am.orig | sed -e "s/^[ \t]*doc /\t/g" > Makefile.am

    __bld-common
}

__flex()
{
    __flex-2.5.37
}

__fontconfig()
{
    __dep freetype2 expat

    __git-clone git://anongit.freedesktop.org/fontconfig
    __cd fontconfig
    __bld-common --localstatedir=/var --disable-docs
}

__freeglut-2.8.1()
{
    __dep "?"

    __wget "?"
    __dcd freeglut-2.8.1
    __bld-common
}

__freeglut-svn()
{
    __dep "?"

    __svn-clone http://svn.code.sf.net/p/freeglut/code/trunk/freeglut/freeglut freeglut
    __cd freeglut
    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    __mk
    __mkinst
}

__freeglut()
{
    __freeglut-2.8.1
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

__gc()
{
    __libatomic_ops()
    {
        __git-clone git://github.com/ivmai/libatomic_ops.git
        __cd libatomic_ops
        git pull
    }

    __libatomic_ops
    __git-clone git://github.com/ivmai/bdwgc.git
    __cd bdwgc
    ln -sf ${BASE_DIR}/libatomic_ops ${BASE_DIR}/bdwgc/libatomic_ops
    ./autoreconf -vif
    ./automake --add-missing
    __bld-common
}

__gcc-4.8.2()
{
    __dep gmp mpfr mpc

    __wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
    __decord gcc-4.8.2
    __cdbt
    ../gcc-4.8.2/configure --prefix=/usr --libexecdir=/usr/lib --enable-shared \
        --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu \
        --enable-languages=c,c++,fortran --disable-multilib \
        --disable-bootstrap --with-system-zlib
#       --disable-libstdcxx-pch --enable-c99 --enable-cloog-backend=isl \
#       --enable-long-long
    __mk
    __mkinst
    sudo mkdir -pv /usr/share/gdb/auto-load/usr/lib
    sudo mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
    sudo ldconfig
}

__gcc()
{
    __gcc-4.8.2
}

__gdb-7.7()
{
    __dep python2

    __wget http://ftp.gnu.org/gnu/gdb/gdb-7.7.tar.bz2
    __dcd gdb-7.7
    __cfg --prefix=/usr --disable-werror
    __mk
    __mkinst -C gdb install
}

__gdb()
{
    __gdb-7.7
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

__gdbm()
{
    __dep "?"

    git clone git://git.gnu.org.ua/gdbm.git
    __cd gdbm
    ./bootstrap
    __bld-common
}

__gdk-pixbuf()
{
    __dep glib libjpeg libpng libtiff gobject-introspection

    __git-clone git://git.gnome.org/gdk-pixbuf
    __cd gdk-pixbuf
    __bld-common --with-x11
    sudo gdk-pixbuf-query-loaders --update-cache
}

__git()
{
    __dep "?"

    __git-clone git://git.kernel.org/pub/scm/git/git.git
    __cd git
    __git-pull
    $MAKE_CLEAN
    __mk prefix=/usr
    __mkinst prefix=/usr
}

__glib()
{
    __dep libffi python-27 pcre attr

    __git-clone git://git.gnome.org/glib
    __cd glib
    __bld-common --with-pcre=system --enable-debug=no
}

__glibc-2.19()
{
    __dep ""
    
    __decord glibc-2.19
    __cdbt
    cat > configparms << .
ASFLAGS-config=-O4 -march=native -mtune=native -msse3
.
    $BASE_DIR/glibc-2.19/configure --prefix=/usr --disable-profile --enable-kernel=3.13 \
        --libexecdir=/usr/lib/glibc --enable-obsolete-rpc
    __mk
    __mkinst
}

__glibc()
{
    __glibc-2.19
}

__gobject-introspection()
{
    __dep "?"

    __git-clone git://git.gnome.org/gobject-introspection
    __cd gobject-introspection
    __bld-common PYTHON=/usr/bin/python2
}

__gmp-5.1.3()
{
    __dep ""

    __wget ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.3.tar.xz
    __dcd gmp-5.1.3
    ABI=64 ./configure --prefix=/usr --enable-cxx
    __mk
    __mkinst
    sudo mkdir -v /usr/share/doc/gmp-5.1.3
    sudo cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp-5.1.3
}

__gmp()
{
    __gmp-5.1.3
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

    GTK2VERSION=2.24.22
    make distclean
    git checkout master
    git pull
    git branch -D $GTK2VERSION
    git checkout $GTK2VERSION
    git checkout -b $GTK2VERSION
    __bld-common --with-xinput --with-gdktarget=x11 --with-x --disable-cups --disable-papi
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

__gtk-engines2()
{
    __dep "?"

    __git-clone git://git.gnome.org/gtk-engines
    __git-clone gtk-engines gtk-engines2
    __cd gtk-engines2
    git checkout GTK_ENGINES_2_20_2
    git checkout -b 2.20.2

    cp autogen.sh autogen.sh.orig
    sed -e "s/1\.11/1\.14/g" autogen.sh.orig

    __autogen.sh
    __cfg --prefix=/usr --sysconfdir=/etc
    # 必ずエラーとなるので
    make
    __mkinst
}

__gtk-engines3()
{
    __dep "?"

    __git-clone git://git.gnome.org/gtk-engines
    __cd gtk-engines
    __autogen.sh
    __cfg --prefix=/usr --sysconfdir=/etc
    # 必ずエラーとなるので
    make
    __mkinst
}

__guile()
{
    __dep  gc libffi libunistring

    __git-clone git://git.sv.gnu.org/guile.git
    __common guile
}

__harfbuzz()
{
    __dep glib icu freetype cairo gobject-introspection

    git clone git://anongit.freedesktop.org/harfbuzz
    __common harfbuzz
}

__hg()
{
    __dep "?"

    __hg-clone http://selenic.com/hg
    __cd hg
    __hg-pull
    sudo python setup.py install
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

__libarchive()
{
    __dep "?"

    __git-clone https://github.com/libarchive/libarchive.git
    __cd libarchive
    __autogen
    __bld-common
}

__libcroco()
{
    __dep glib libxml2

    __git-clone git://git.gnome.org/libcroco
    __common libcroco
}

__libffi()
{
    __dep ""

    __git-clone https://github.com/atgreen/libffi.git
    __common libffi
}

__libpng()
{
    git clone git://libpng.git.sourceforge.net/gitroot/libpng/libpng
    __cd libpng
    __bld-common --enable-maintainer-mode
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

__libunistring()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libunistring.git
    __common libunistring
}

__libxml2()
{
    __dep python-27

    __git-clone git://git.gnome.org/libxml2
    __common libxml2
}

__libxslt-1.1.28()
{
    __dep "?"

###    __wget  ?
    __dcd libxslt-1.1.28
    __bld-common
}

__libxslt()
{
    __libxslt-1.1.28
}

__mpc-1.0.2()
{
    __dep mpfr

    __wget http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz
    __dcd mpc-1.0.2
    __cfg --prefix=/usr
    __mk
    __mkinst
}

__mpc()
{
    __mpc-1.0.2
}

__mpfr-3.1.2()
{
    __dep gmp

    __wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.xz
    __dcd mpfr-3.1.2
    ABI=64 ./configure --prefix=/usr --enable-thread-safe --docdir=/usr/share/doc/mpfr-3.1.2
    __mk
    __mkinst
}

__mpfr()
{
    __mpfr-3.1.2
}

__mplayer-1.1.1()
{
    __dep yasm

    __wget http://www.mplayerhq.hu/MPlayer/releases/MPlayer-1.1.1.tar.xz
    __dcd MPlayer-1.1.1
    __bld-common-simple
}

__mplayer()
{
    __mplayer-1.1.1
}

__ncurses-5.9()
{
    __dep "?"

    __wget ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
    __dcd ncurses-5.9
    __bld-common --mandir=/usr/share/man --with-shared --enable-widec
}

__ncurses()
{
    __ncurses-5.9
}

__nettle()
{
    __git-clone git://git.lysator.liu.se/nettle/nettle.git
    __cd nettle
    __bld-common --disable-documentation
    sudo chmod -v 755 /usr/lib/libhogweed.so.* /usr/lib/libnettle.so.*
}

__nspr-4.10.3()
{
    __dep ""

    __wget http://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.3/src/nspr-4.10.3.tar.gz
    __dcd nspr-4.10.3
    cd nspr
    __bld-common --with-mozilla --with-pthreads --enable-64bit
}

__nspr()
{
    __nspr-4.10.3
}

__nss-3.15.4()
{
    __dep nspr sqlite

    __wget http://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_15_4_RTM/src/nss-3.15.4.tar.gz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/nss-3.15.4-standalone-1.patch
    __dcd nss-3.15.4
    patch -Np1 -i $SRC_DIR/nss-3.15.4-standalone-1.patch
    cd nss
    make BUILD_OPT=1 NSPR_INCLUDE_DIR=/usr/include/nspr USE_SYSTEM_ZLIB=1 ZLIB_LIBS=-lz USE_64=1 NSS_USE_SYSTEM_SQLITE=1

    cd ../dist
    sudo install -v -m755 Linux*/lib/*.so              /usr/lib
    sudo install -v -m644 Linux*/lib/{*.chk,libcrmf.a} /usr/lib
    sudo install -v -m755 -d                           /usr/include/nss
    sudo cp -v -RL {public,private}/nss/*              /usr/include/nss
    sudo chmod -v 644                                  /usr/include/nss/*
    sudo install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} /usr/bin
    sudo install -v -m644 Linux*/lib/pkgconfig/nss.pc  /usr/lib/pkgconfig
}

__nss()
{
    __nss-3.15.4
}

__openssh-6.5p1()
{
    __dep openssl linux-pam

    __wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.5p1.tar.gz
    __decord openssh-6.5p1
    __cd openssh-6.5p1

    sudo install -v -m700 -d /var/lib/sshd
    sudo chown -v root:sys /var/lib/sshd
    sudo groupadd -g 50 sshd
    sudo useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd

    $DIST_CLEAN
    __cfg --prefix=/usr --libexecdir=/usr/lib/openssh --sysconfdir=/etc/ssh --datadir=/usr/share/sshd \
        --with-md5-passwords --with-privsep-path=/var/lib/sshd

    $MAKE_CLEAN
    __mk
    __mkinst

    sudo install -v -m755 contrib/ssh-copy-id /usr/bin
    sudo install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
    sudo install -v -m755 -d /usr/share/doc/openssh-6.5p1
    sudo install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-6.5p1
}

__openssh()
{
    __openssh-6.5p1
}

__openssl-1.0.1f()
{
    __dep ""

    __wget http://www.openssl.org/source/openssl-1.0.1f.tar.gz
    __dcd openssl-1.0.1f
    ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic
    __mk
    __mkinst
}

__openssl()
{
    __openssl-1.0.1f
}

__pango()
{
    __dep cairo harfbuzz xorg gobject-introspenction

    __git-clone git://git.gnome.org/pango
    __common pango
    sudo pango-querymodules --update-cache
}

__pangox-compat()
{
    __dep pango

    __git-clone git://git.gnome.org/pangox-compat
    __common pangox-compat
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

__perl-5.8.2()
{
    __dep ""

    __wget http://www.cpan.org/src/5.0/perl-5.18.2.tar.gz
    __dcd perl-5.18.2
    sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 \
        -Dpager="/usr/bin/less -isR" -Duseshrplib
    __mk
    __mkinst
}

__perl()
{
    __perl-5.8.2
}

__pixman()
{
    __dep ""

    __git-clone git://anongit.freedesktop.org/pixman
    __common pixman
}

__popt-1.16()
{
    __wget http://rpm5.org/files/popt/popt-1.16.tar.gz
    __dcd popt-1.16
    __bld-common
}

__popt()
{
    __popt-1.16
}

__python-2.7.6()
{
    __dep expat libffi
}

__python-27()
{
    __python-2.7.6
}

__serf-1.3.3()
{
    __dep apr-util openssl scons

    __wget https://serf.googlecode.com/files/serf-1.3.3.tar.bz2
    __dcd serf-1.3.3
    sed -i "/Append/s:RPATH=libdir,::"   SConstruct
    sed -i "/Default/s:lib_static,::"    SConstruct
    sed -i "/Alias/s:install_static,::"  SConstruct
    sed -i '/get.*_LIBS/s:)):, '\'\''&:' SConstruct
    scons PREFIX=/usr
    sudo scons PREFIX=/usr install
}

__serf()
{
    __serf-1.3.3
}

__scons-2.3.0()
{
    __dep python2

    rm $SRC_DIR/scons-2.3.0.tar.gz
    __wget http://downloads.sourceforge.net/scons/scons-2.3.0.tar.gz
    __dcd scons-2.3.0
    sudo python setup.py install --prefix=/usr --standard-lib --optimize=1 --install-data=/usr/share
}

__scons()
{
    __scons-2.3.0
}

__sudo()
{
    __dep linux-pam

    __hg-clone http://www.sudo.ws/repos/sudo
    __cd sudo
    __bld-common-simple --libexecdir=/usr/lib/sudo --docdir=/usr/share/doc/sudo \
        --with-all-insults --with-env-editor --with-pam --without-sendmail

cat > /tmp/t << "EOF" &&
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
    sudo cp -f /tmp/t /etc/pam.d/sudo
    sudo chmod 644 /etc/pam.d/sudo
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

__sqlite-3.8.3.1()
{
    __dep unzip

    __wget http://sqlite.org/2014/sqlite-autoconf-3080301.tar.gz
    __dcd sqlite-autoconf-3080301
    ./configure --prefix=/usr --sysconfdir=/etc \
                CFLAGS="-DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                        -DSQLITE_ENABLE_UNLOCK_NOTIFY=1 -DSQLITE_SECURE_DELETE=1"
    __mk
    __mkinst
}

__sqlite()
{
    __sqlite-3.8.3.1
}

__svn-1.8.5()
{
    __dep apr-util sqlite openssl serf dbus

    __wget http://ftp.riken.jp/net/apache/subversion/subversion-1.8.5.tar.bz2
    __dcd subversion-1.8.5
    __bld-common --with-serf=/usr
}

__svn()
{
    __svn-1.8.5
}

__talloc-2.1.0()
{
    __wget http://samba.org/ftp/talloc/talloc-2.1.0.tar.gz
    __dcd talloc-2.1.0
    __bld-common
}

__talloc()
{
    __talloc-2.1.0
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

__install-tl()
{
    __install-tl-20140225
}

__install-tl-20140225()
{
    __dep ghostscript libdrm freeglut glu libxcb ruby

    __wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    __decord install-tl-unx
    __cd install-tl-20140225
    sudo TEXLIVE_INSTALL_PREFIX=/opt/texlive ./install-tl
}

__tomoyo-tools-2.5.0()
{
    __dep "?"

    cd ${BASE_DIR}
    wget -O ${SRC_DIR}/tomoyo-tools-2.5.0-20140105.tar.gz 'http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/tomoyo-tools-2.5.0-20140105.tar.gz'

    __decord tomoyo-tools-2.5.0-20140105
    __cd tomoyo-tools
    __mk USRLIBDIR=/lib
    __mkinst USRLIBDIR=/lib install
}

__tomoyo-tools()
{
    __tomoyo-tools-2.5.0
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
    __vala-git
}

__vte()
{
    __dep gtk-introspection

    __git-clone git://git.gnome.org/vte
    __cd vte
    __bld-common --enable-introspection --enable-maintainer-mode
}

__wget-1.15()
{
    __dep openssl

    __wget http://ftp.gnu.org/gnu/wget/wget-1.15.tar.xz
    __cd wget
    __bld-common --with-ssl=openssl --with-openssl --disable-ipv6
}

### wget のビルド&インストールを行う
### 名前が __wget() だと common-func-2.sh 内定義の間数名と重複してしまい、誤動作してしまうため
__install-wget()
{
    __wget-1.15
}

__yasm-1.2.0()
{
    __dep python2 cython

    __wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
    __dcd yasm-1.2.0
    __bld-common
}

__yasm()
{
    __yasm-1.2.0
}

$@

