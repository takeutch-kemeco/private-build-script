#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__libffi()
{
    git clone git://github.com/atgreen/libffi.git
    __common libffi

    sudo cp -f $BASE_DIR/libffi/`gcc -dumpmachine`/include/ffi.h /usr/include/
    sudo cp -f $BASE_DIR/libffi/`gcc -dumpmachine`/include/ffitarget.h /usr/include/
}

__pkg-config()
{
    git clone git://anongit.freedesktop.org/pkg-config
    __cd pkg-config
    sudo rm -f /usr/bin/`gcc -dumpmachine`-pkg-config
    __bld-common --docdir=/usr/share/doc/pkg-config-0.28 --with-internal-glib
}

__pcre()
{
    svn co svn://vcs.exim.org/pcre/code/trunk pcre
    __cd pcre
    __bld-common --docdir=/usr/share/doc/pcre --enable-utf \
                 --enable-unicode-properties --enable-pcregrep-libz \
                 --enable-pcregrep-libbz2 --enable-pcretest-libreadline

    sudo cp -f /usr/lib/libpcre.la      /lib/
    sudo cp -f /usr/lib/libpcrecpp.la   /lib/
    sudo cp -f /usr/lib/libpcreposix.la /lib/

    sudo ln -sf /usr/lib/libpcre.so      /lib/libpcre.so
    sudo ln -sf /usr/lib/libpcrecpp.so   /lib/libpcrecpp.so
    sudo ln -sf /usr/lib/libpcreposix.so /lib/libpcreposix.so
    sudo ldconfig
}

__gtk-doc()
{
    git clone git://git.gnome.org/gtk-doc
    __common gtk-doc
}

__glib()
{
    git clone git://git.gnome.org/glib
    __cd glib
    __bld-common --with-pcre=system --enable-debug=no
}

__gobject-introspection()
{
    git clone git://git.gnome.org/gobject-introspection
    __cd gobject-introspection 
    __bld-common PYTHON=/usr/bin/python2
}

__expat()
{
#   cvs -z3 -d:pserver:anonymous@expat.cvs.sourceforge.net:/cvsroot/expat co expat
    __wget http://downloads.sourceforge.net/expat/expat-2.1.0.tar.gz
    __decord expat-2.1.0
    __common expat-2.1.0
}

__dbus()
{
    git clone git://anongit.freedesktop.org/dbus/dbus
    sudo groupadd -g 27 messagebus
    sudo useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 27 \
                 -g messagebus -s /bin/false messagebus
    __cd dbus
    __bld-common --localstatedir=/var 			\
                 --libexecdir=/usr/lib/dbus-1.0 	\
                 --with-console-auth-dir=/run/console/ 	\
                 --without-systemdsystemunitdir 	\
                 --disable-systemd 			\
                 --disable-static			\
                 --disable-Werror			\
	         --disable-tests

    sudo dbus-uuidgen --ensure

cat > /tmp/t << "EOF" 
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

    sudo cp /tmp/t /etc/dbus-1/session-local.conf
}

__dbus-glib()
{
    git clone git://anongit.freedesktop.org/dbus/dbus-glib
    __cd dbus-glib
    __bld-common --libexecdir=/usr/lib/dbus-1.0
}

__at-spi2-core()
{
    git clone git://git.gnome.org/at-spi2-core
    __cd at-spi2-core
    __bld-common --libexecdir=/usr/lib/at-spi2-core
}

__atk()
{
    git clone git://git.gnome.org/atk
    __common atk
}

__intltool()
{
    __wget http://launchpad.net/intltool/trunk/0.50.2/+download/intltool-0.50.2.tar.gz
    __decord intltool-0.50.2
    __common intltool-0.50.2
    sudo install -v -m644 -D doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO
}

__at-spi2-atk()
{
    git clone git://git.gnome.org/at-spi2-atk
    __common at-spi2-atk
}

__nasm()
{
    git clone git://repo.or.cz/nasm.git
    __common nasm
}

__libjpeg()
{
    __wget http://www.ijg.org/files/jpegsrc.v9.tar.gz
    __decord jpegsrc.v9
    __common jpeg-9
}

__libpng()
{
    git clone git://libpng.git.sourceforge.net/gitroot/libpng/libpng
    __cd libpng
    __bld-common --enable-maintainer-mode
}

__libtiff()
{
    __wget ftp://ftp.remotesensing.org/libtiff/tiff-4.0.3.tar.gz
    __decord tiff-4.0.3
    __cd tiff-4.0.3
    __bld-common --disable-mdi --disable-old-jpeg --disable-pixarlog \
                 --disable-logluv --disable-next --disable-thunder \
                 --disable-packbits --disable-ccitt --disable-jpeg
}

__gdk-pixbuf()
{
    git clone git://git.gnome.org/gdk-pixbuf
    __cd gdk-pixbuf
    __bld-common --with-x11
}

__freetype2()
{
    git clone git://git.sv.gnu.org/freetype/freetype2.git
    __cd freetype2
    cp include/freetype/config/{ftoption.h,ftoption.h.orig}
    sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h
    __bld-common
    cp include/freetype/config/{ftoption.h.orig,ftoption.h}
}

__fontconfig()
{
    git clone git://anongit.freedesktop.org/fontconfig
    __cd fontconfig
    __bld-common --localstatedir=/var --disable-docs 
}

__pixman()
{
    git clone git://anongit.freedesktop.org/pixman
    __common pixman
}

__cairo()
{
    git clone git://anongit.freedesktop.org/git/cairo
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

__ragel()
{
#   git clone git://git.complang.org/ragel.git 
    __wget http://www.complang.org/ragel/ragel-6.8.tar.gz
    __dcd ragel-6.8
    __bld-common
}

__harfbuzz()
{
    git clone git://anongit.freedesktop.org/harfbuzz
    __common harfbuzz
}

__pango()
{
    git clone git://git.gnome.org/pango
    __common pango
    sudo pango-querymodules --update-cache
}

__pangox-compat()
{
    git clone git://git.gnome.org/pangox-compat
    __common pangox-compat
}

__gtk+2()
{
    git clone git://git.gnome.org/gtk+
    git clone gtk+ gtk+-2.24.git
    __cd gtk+-2.24.git
    git checkout master
    git pull
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
    git clone git://git.gnome.org/gtk+
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
    __git-clone git://git.gnome.org/gtk-engines
    __cd gtk-engines
    __autogen.sh
    __cfg --prefix=/usr --sysconfdir=/etc
    # 必ずエラーとなるので
    make
    __mkinst
}

__glib-package()
{
    __libffi
    __pkg-config
    __pcre
    __gtk-doc
    __glib
}

__dbus-package()
{
    __expat
    __dbus
    __dbus-glib
}

__at-spi2-package()
{
    __dbus-package
    __gobject-introspection
    __at-spi2-core
    __atk
    __intltool
    __at-spi2-atk
}

__gdk-pixbuf-package()
{
    __nasm
    __libjpeg
    __libpng
    __libtiff
    __gdk-pixbuf
}

__fontconfig-package()
{
    __freetype2
    __fontconfig
}

__cairo-package()
{
    __fontconfig-package
    __pixman
    __cairo
}

__harfbuzz-package()
{
    __ragel
    __harfbuzz
}

__pango-package()
{
    __cairo-package
    __harfbuzz-package
    __pango
    __pangox-compat
}

__all()
{
    __glib-package
    __at-spi2-package
    __gdk-pixbuf-package
    __pango-package
    __gtk+2
    __gtk+3
    __gtk-engines2
    __gtk-engines3
}

$@

