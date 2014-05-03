#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

### ビルド時にシステムメモリーを使いきらないように制限する
__init-build-group

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

__atk()
{
    __dep glib

    __git-clone git://git.gnome.org/atk
    __common atk
}

__automake-1.14.1()
{
    __dep autoconf

    __wget http://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.xz
    __dcd automake-1.14.1
    __bld-common
}

__automake()
{
    __automake-1.14.1
}

__gawk()
{
    __dep readline

    __git-clone git://git.savannah.gnu.org/gawk.git
    __common gawk
}

__bash()
{
    __dep readline

    __git-clone git://git.savannah.gnu.org/bash.git
    __common bash
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

__bzip2-1.0.6()
{
    __dep ""

    __wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
    __dcd bzip2-1.0.6

    $MAKE_CLEAN
    __mk -f Makefile-libbz2_so
    __mk clean
    __mk
    __mkinst PREFIX=/usr

    sudo cp -v bzip2-shared /bin/bzip2
    sudo cp -av libbz2.so* /lib

    sudo ldconfig
}

__bzip2()
{
    __bzip2-1.0.6
}

__cairo()
{
    __dep libpng glib pixman fontconfig

    __git-clone git://anongit.freedesktop.org/git/cairo
    __cd cairo
    __bld-common --enable-tee --enable-gl --enable-xcb --enable-glsv2 --enable-xlib-xcb \
        --enable-directfb=no --enable-ft --enable-fc --enable-test-surfaces=no
}

__certificate-authority-certificates()
{
    __dep openssl

    sudo install $SRC_DIR/make-cert.pl            /bin/
    sudo install $SRC_DIR/make-ca.sh              /bin/
    sudo install $SRC_DIR/remove-expired-certs.sh /bin/

    certhost='http://mxr.mozilla.org'
    certdir='/mozilla/source/security/nss/lib/ckfw/builtins'
    url="$certhost$certdir/certdata.txt?raw=1"

    wget --output-document certdata.txt $url
    unset certhost certdir url
    make-ca.sh
    remove-expired-certs.sh certs

    SSLDIR=/etc/ssl
    sudo install -d ${SSLDIR}/certs
    sudo cp -v certs/*.pem ${SSLDIR}/certs
    c_rehash
    sudo install BLFS-ca-bundle*.crt ${SSLDIR}/ca-bundle.crt
    sudo ln -sv ../ca-bundle.crt ${SSLDIR}/certs/ca-certificates.crt
    unset SSLDIR

    rm -r certs BLFS-ca-bundle*

    sudo c_rehash
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
                 --disable-bash-completion --enable-systemd-login
}

__cryptsetup()
{
    __dep LVM2

    __git-clone https://github.com/mbroz/cryptsetup.git
    __common cryptsetup
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
                 --enable-systemd                       \
                 --disable-Werror                       \
                 --disable-tests

    sudo ln -sv /etc/machine-id /var/lib/dbus
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

__dhcpcd-6.2.1()
{
    __dep ""

    __wget http://roy.marples.name/downloads/dhcpcd/dhcpcd-6.2.1.tar.bz2
    __dcd dhcpcd-6.2.1
    __bld-common --libexecdir=/lib/dhcpcd --dbdir=/var/tmp

    cat > /tmp/ifconfig.wlan0 << .
ONBOOT="yes"
IFACE="wlan0"
SERVICE="dhcpcd"
DHCP_START=""
DHCP_STOP="-k"
.
    sudo install /tmp/ifconfig.wlan0 /etc/sysconfig/network-devices/

    cat > /tmp/resolv.conf << .
nameserver 192.168.11.1
.
    sudo install /tmp/resolv.conf /etc/resolv.conf
}

__dhcpcd()
{
    __dhcpcd-6.2.1
}

__dbus-glib()
{
    __dep "?"

    git clone git://anongit.freedesktop.org/dbus/dbus-glib
    __cd dbus-glib
    __bld-common --libexecdir=/usr/lib/dbus-1.0
}

__docbook-xml-4.3()
{
    __dep libxml2 unzip

    __wget http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip
    mkdir docbook-xml-4.3
    cd $BASE_DIR/docbook-xml-4.3
    sudo cp $SRC_DIR/docbook-xml-4.3.zip $BASE_DIR/docbook-xml-4.3
    sudo unzip docbook-xml-4.3.zip

    sudo install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.3
    sudo install -v -d -m755 /etc/xml
    sudo chown -R root:root .
    sudo cp -v -af docbook.cat *.dtd ent/ *.mod /usr/share/xml/docbook/xml-dtd-4.3

    if [ ! -e /etc/xml/docbook ]
    then
	sudo xmlcatalog --noout --create /etc/xml/docbook
    fi

    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD DocBook XML V4.3//EN" \
	"http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD DocBook XML CALS Table Model V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/calstblx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/soextblx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML Information Pool V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/dbpoolx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/dbhierx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/htmltblx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Notations V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/dbnotnx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Character Entities V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/dbcentx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.3//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3/dbgenent.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "rewriteSystem" \
	"http://www.oasis-open.org/docbook/xml/4.3" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "rewriteURI" \
	"http://www.oasis-open.org/docbook/xml/4.3" \
	"file:///usr/share/xml/docbook/xml-dtd-4.3" \
	/etc/xml/docbook

    if [ ! -e /etc/xml/catalog ]
    then
	sudo xmlcatalog --noout --create /etc/xml/catalog
    fi

    sudo xmlcatalog --noout --add "delegatePublic" \
	"-//OASIS//ENTITIES DocBook XML" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegatePublic" \
	"-//OASIS//DTD DocBook XML" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegateSystem" \
	"http://www.oasis-open.org/docbook/" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegateURI" \
	"http://www.oasis-open.org/docbook/" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
}

__docbook-xml-4.5()
{
    __dep libxml2 unzip

    __wget http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip
    mkdir docbook-xml-4.5
    cd $BASE_DIR/docbook-xml-4.5
    sudo cp $SRC_DIR/docbook-xml-4.5.zip $BASE_DIR/docbook-xml-4.5
    sudo unzip docbook-xml-4.5.zip

    sudo install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5
    sudo install -v -d -m755 /etc/xml
    sudo chown -R root:root .
    sudo cp -v -af docbook.cat *.dtd ent/ *.mod /usr/share/xml/docbook/xml-dtd-4.5

    if [ ! -e /etc/xml/docbook ]
    then
	sudo xmlcatalog --noout --create /etc/xml/docbook
    fi

    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD DocBook XML V4.5//EN" \
	"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "public" \
	"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "rewriteSystem" \
	"http://www.oasis-open.org/docbook/xml/4.5" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5" \
	/etc/xml/docbook
    sudo xmlcatalog --noout --add "rewriteURI" \
	"http://www.oasis-open.org/docbook/xml/4.5" \
	"file:///usr/share/xml/docbook/xml-dtd-4.5" \
	/etc/xml/docbook

    if [ ! -e /etc/xml/catalog ]
    then
	sudo xmlcatalog --noout --create /etc/xml/catalog
    fi

    sudo xmlcatalog --noout --add "delegatePublic" \
	"-//OASIS//ENTITIES DocBook XML" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegatePublic" \
	"-//OASIS//DTD DocBook XML" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegateSystem" \
	"http://www.oasis-open.org/docbook/" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
    sudo xmlcatalog --noout --add "delegateURI" \
	"http://www.oasis-open.org/docbook/" \
	"file:///etc/xml/docbook" \
	/etc/xml/catalog
}

__docbook-xml()
{
    __docbook-xml-4.5
}

__docbook-xsl-1.78.1()
{
    __dep libxml2

    __wget http://downloads.sourceforge.net/docbook/docbook-xsl-1.78.1.tar.bz2
    __wget http://downloads.sourceforge.net/docbook/docbook-xsl-doc-1.78.1.tar.bz2
    __dcd docbook-xsl-1.78.1

    tar -xf $SRC_DIR/docbook-xsl-doc-1.78.1.tar.bz2 --strip-components=1

    sudo install -v -m755 -d /usr/share/xml/docbook/xsl-stylesheets-1.78.1

    sudo cp -v -R VERSION common eclipse epub extensions fo highlighting html \
        htmlhelp images javahelp lib manpages params profiling \
        roundtrip slides template tests tools webhelp website \
        xhtml xhtml-1_1 \
	/usr/share/xml/docbook/xsl-stylesheets-1.78.1

    sudo ln -s VERSION /usr/share/xml/docbook/xsl-stylesheets-1.78.1/VERSION.xsl

    sudo install -v -m644 -D README /usr/share/doc/docbook-xsl-1.78.1/README.txt
    sudo install -v -m644    RELEASE-NOTES* NEWS* /usr/share/doc/docbook-xsl-1.78.1

    sudo cp -v -R doc/* /usr/share/doc/docbook-xsl-1.78.1

    if [ ! -d /etc/xml ]
    then
	sudo install -v -m755 -d /etc/xml
    fi

    if [ ! -f /etc/xml/catalog ]
    then
	sudo xmlcatalog --noout --create /etc/xml/catalog
    fi

    sudo xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/1.78.1" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
	/etc/xml/catalog

    sudo xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/1.78.1" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
	/etc/xml/catalog

    sudo xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
	/etc/xml/catalog

    sudo xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
	/etc/xml/catalog
}

__docbook-xsl()
{
    __docbook-xsl-1.78.1
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

__expect-5.45()
{
    __dep tcl tk

    __wget http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz
    __dcd expect5.45
    __bld-common --with-tcl=/usr/lib --enable-shared --mandir=/usr/share/man --with-tclinclude=/usr/include
}

__expect()
{
    __expect-5.45
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

__firefox()
{
    __dep "?"

    __hg-clone http://hg.mozilla.org/comm-central/
    __cd comm-central
    ./client.py checkout

    __cd comm-central/mozilla
    sudo rm $BASE_DIR/comm-central/ff-opt -rf
    ln -sf $SRC_DIR/mozconfig $BASE_DIR/comm-central/mozilla/.mozconfig 
    __mk -f client.mk configure
    __mk -f client.mk build
    __mkinst -f client.mk
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

__gcc-4.9.0()
{
    __dep gmp mpfr mpc

    __wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-4.9.0/gcc-4.9.0.tar.bz2
    __decord gcc-4.9.0
    __cdbt
    ../gcc-4.9.0/configure --prefix=/usr --libexecdir=/usr/lib --enable-shared \
        --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu \
        --enable-languages=c,c++,fortran --disable-multilib \
        --disable-bootstrap --with-system-zlib --enable-c99 \
        --enable-long-long
    __mk
    __mkinst
    sudo mkdir -pv /usr/share/gdb/auto-load/usr/lib
    sudo mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
    sudo ldconfig
}

__gcc()
{
    __gcc-4.9.0
}

__gcr()
{
    __dep glib intltool libgcrypt libtasn1 p11-kit gnupg gobject-introspection gtk+3

    __git-clone git://git.gnome.org/gcr
    __common gcr
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

__glib-networking()
{
    __dep gnutls gsettings desktop-schemas p11-kit

    __git-clone git://git.gnome.org/glib-networking
    __common glib-networking
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

__gnome-keyring()
{
    __dep dbus gcr linux-pam

    __git-clone git://git.gnome.org/gnome-keyring
    __cd gnome-keyring
    __bld-common --with-pam-dir=/lib/security
}

__gnome-themes-standard()
{
    __dep gtk+2 gtk+3 librsvg

    __git-clone git://git.gnome.org/gnome-themes-standard
    __common gnome-themes-standard
}

__gnupg()
{
    __dep pth libassuan libgcript libksda

    __git-clone git clone git://git.gnupg.org/gnupg.git
    __cd gnupg
    __bld-common --enable-maintainer-mode
}

__gperf-3.0.4()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/gperf/gperf-3.0.4.tar.gz
    __dcd gperf-3.0.4
    __bld-common
}

__gperf-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/gperf.git
    __common gperf
}

__gperf()
{
    __gperf-3.0.4
}

__gsettings-desktop-schemas()
{
    __dep glib libtool gobject-introspection

    __git-clone git://git.gnome.org/gsettings-desktop-schemas
    __common gsettings-desktop-schemas
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas
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

__gtk-doc.git()
{
    __dep docbook-xml docbook-xsl Itstool libxslt

    __git-clone git://git.gnome.org/gtk-doc
    __common gtk-doc
}

__gtk-doc-1.19()
{
    __dep docbook-xml docbook-xsl Itstool libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.19/gtk-doc-1.19.tar.xz
    __dcd gtk-doc-1.19
    __bld-common
}

__gtk-doc()
{
    __gtk-doc-1.19
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

__guile-git()
{
    __dep  gc libffi libunistring

    __git-clone git://git.sv.gnu.org/guile.git
    __common guile
}

__guile-2.0.9()
{
    __wget http://ftp.gnu.org/pub/gnu/guile/guile-2.0.9.tar.xz
    __dcd guile-2.0.9
    __bld-common
}

__guile()
{
    __guile-2.0.9
}

__guile-lib-0.2.2()
{
    __dep ""

    __wget http://download.savannah.gnu.org/releases/guile-lib/guile-lib-0.2.2.tar.gz
    __dcd guile-lib-0.2.2
    __bld-common
}

__guile-lib()
{
    __guile-lib-0.2.2
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

__icu-52.1()
{
    __dep llvm

    __wget http://download.icu-project.org/files/icu4c/52.1/icu4c-52_1-src.tgz
    __decord icu4c-52_1-src
    __cd icu/source
    __bld-common-simple CXX=g++
}

__icu()
{
    __icu-52.1
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

__intel-driver()
{
    __dep libvpx livva "?"

    git clone git://anongit.freedesktop.org/vaapi/intel-driver
    __common intel-driver
}

__intltool-0.50.2()
{
    __dep perl-module-xml-parser

    __wget http://launchpad.net/intltool/trunk/0.50.2/+download/intltool-0.50.2.tar.gz
    __dcd intltool-0.50.2
    __bld-common
}

__intltool()
{
    __intltool-0.50.2
}

__iproute2()
{
    __dep ""

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git
    __cd iproute2
    __mk DESTDIR=
    __mkinst DESTDIR= SBINDIR=/sbin MANDIR=/usr/share/man DOCDIR=/usr/share/doc/iproute2
}

__itstool-2.0.2()
{
    __dep docbook-xml docbook-xsl python2

    __wget http://files.itstool.org/itstool/itstool-2.0.2.tar.bz2
    __dcd itstool-2.0.2
    __bld-common
}

__itstool()
{
    __itstool-2.0.2
}

__mozjs()
{
    __dep libffi nspr python2 zip

    __wget http://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.gz
    __dcd mozjs17.0.0
    cd js/src
    __bld-common --enable-readline --enable-threadsafe --with-system-ffi --with-system-nspr
    __mk
    __mkinst
}

__kmod()
{
    __dep ""

    __git-clone git://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
    __cd kmod
    __bld-common --with-xz --with-zlib

    for target in depmod insmod modinfo modprobe rmmod; do
        sudo ln -sv ../bin/kmod /sbin/$target
    done

    sudo ln -sv kmod /bin/lsmod
}

__linux-pam()
{
    __dep ""

    __git-clone https://git.fedorahosted.org/git/linux-pam.git
    __cd linux-pam
    __bld-common --enable-securedir=/lib/security
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

__libcap()
{
    __dep attr linux-pam

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/morgan/libcap.git
    __cd libcap
    __mk prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
    __mkinst prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
}

__libcg()
{
    __dep linux-pam

    __git-clone git://git.code.sf.net/p/libcg/libcg
    __cd libcg
    ./bootstrap.sh
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

__libgcrypt()
{
    __dep libgpg-error libcap pth

    __git-clone git://git.gnupg.org/libgcrypt.git
    __cd libgcrypt

    ### fig2dev が無くてもビルドできるように
    cp configure.ac{,.orig}
    cat configure.ac.orig | sed -e "s/^doc\/Makefile//g" > configure.ac
    cp Makefile.am{,.orig}
    cat Makefile.am.orig | sed -e "s/ doc //g" > Makefile.am

    __self-autogen
    __bld-common --enable-maintainer-mode

    cp configure.ac{.orig,}
    cp Makefile.am{.orig,}
}

__libgee-git()
{
    __dep glib vala gobject-introspection

    __git-clone git://git.gnome.org/libgee
    __common libgee
}

__libgee-0.6.8()
{
    __dep gilb vala gobject-introspection

    __wget http://ftp.gnome.org/pub/gnome/sources/libgee/0.6/libgee-0.6.8.tar.xz
    __dcd libgee-0.6.8
    __bld-common
}

__libgee()
{
    ### gitソースだとgee-0.8.vala, gee-0.8.pcのファイル名となるので、
    ### gee-1.0.* を想定したビルドで失敗する場合がある。
    ### tarソースならばgee-1.0.vala, gee-1.0.pcのファイル名となるので、
    ### 回避手段として使える。
    __libgee-git
}

__libgpg-error()
{
    __dep ""

    __git-clone git://git.gnupg.org/libgpg-error.git
    __cd libgpg-error
    __self-autogen
    __bld-common --enable-maintainer-mode
}

__libmnl()
{
    __dep ""

    __git-clone git://git.netfilter.org/libmnl
    __common libmnl
}

__libnftnl()
{
    __dep libmnl

    __git-clone git://git.netfilter.org/libnftnl
    __common libnftnl
}

__libnl-3.2.23()
{
    __dep "?"

    __wget http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-3.2.23.tar.gz
    __dcd libnl-3.2.23
    __bld-common
}

__libnl()
{
    __libnl-3.2.23
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

__libseccomp()
{
    __dep ""

    __git-clone git://git.code.sf.net/p/libseccomp/libseccomp
    __common libseccomp
}

__libsecret()
{
    __dep glib gobject-introspection libgcrypt vala

    __git-clone git://git.gnome.org/libsecret
    __common libsecret
}

__libsoup()
{
    __dep glib-networking libxml2 sqlite gobject-introspection

    __git-clone git://git.gnome.org/libsoup
    __common libsoup
}

__libtasn1-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libtasn1.git
    __cd libtasn1
    __self-autogen
    __bld-common-simple
}

__libtasn1-3.4()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/libtasn1/libtasn1-3.4.tar.gz
    __dcd libtasn1-3.4
    __bld-common
}

__libtasn1()
{
    __libtasn1-3.4
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

__libtool()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libtool.git
    __cd libtool
    ./bootstrap
    __bld-common
}

__libunistring()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libunistring.git
    __common libunistring
}

__libxkbcommon()
{
    __dep "?"

    __git-clone https://github.com/xkbcommon/libxkbcommon.git
    __common libxkbcommon
}

__libxml2.git()
{
    __dep python2

    __git-clone git://git.gnome.org/libxml2
    __common libxml2
}

__libxml2-2.9.1()
{
    __dep python2

    __wget http://xmlsoft.org/sources/libxml2-2.9.1.tar.gz
    __wget http://www.w3.org/XML/Test/xmlts20130923.tar.gz
    __dcd libxml2-2.9.1
    tar xf $SRC_DIR/xmlts20130923.tar.gz
    __bld-common --disable-static --with-history
}

__libxml2()
{
    __libxml2-2.9.1
}

__libxslt-1.1.28()
{
    __dep libxml2

    __wget http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz
    __dcd libxslt-1.1.28
    __bld-common
}

__libxslt()
{
    __libxslt-1.1.28
}

__libva()
{
    __dep "?"

    git clone git://anongit.freedesktop.org/git/libva
    __common libva
}

__llvm-3.4()
{
    __dep libffi python2

    __wget http://llvm.org/releases/3.4/llvm-3.4.src.tar.gz
    __wget http://llvm.org/releases/3.4/clang-3.4.src.tar.gz
    __wget http://llvm.org/releases/3.4/compiler-rt-3.4.src.tar.gz
    __dcd llvm-3.4
    tar -xf $SRC_DIR/clang-3.4.src.tar.gz -C tools
    tar -xf $SRC_DIR/compiler-rt-3.4.src.tar.gz -C projects
    mv tools/clang-3.4 tools/clang &&
    mv projects/compiler-rt-3.4 projects/compiler-rt
    __bld-common CC=gcc CXX=g++ --enable-libffi --enable-optimized --enable-shared --disable-assertions
}

__llvm()
{
    __llvm-3.4
}

__lvm2-2.02.105()
{
    ### Use kernel configuration
    ### Device Drivers --->
    ###   Multiple devices driver support (RAID and LVM): Y
    ###   Device mapper support: Y or M
    ###   Crypt target support: (optional)
    ###   Snapshot target: (optional)
    ###   Mirror target: (optional) 

    __dep ""

    __wget ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.105.tgz
    __dcd LVM2.2.02.105
    __bld-common --exec-prefix= --with-confdir=/etc \
        --enable-applib --enable-cmdlib --enable-pkgconfig --enable-udev_sync
}

__lvm2()
{
    __lvm2-2.02.105
}

__libvpx()
{
    __dep "?"

    __git-clone https://chromium.googlesource.com/webm/libvpx
    __cd libvpx
    __bld-common-simple
}

__midori-0.5.7()
{
    __dep cmake libnotify webkitgtk vala

    __wget http://www.midori-browser.org/downloads/midori_0.5.7_all_.tar.bz2
    __decord midori_0.5.7_all_
    __cd midori-0.5.7
    __bld-common-simple --enable-gtk3 --disable-zeitgeist --enable-granite=no --enable-apidocs=no
}

__midori()
{
    __midori-0.5.7
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
    sudo ln -s /usr/lib/{libncursesw.so,libcurses.so}
    sudo ldconfig
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

__nftables()
{
    __dep libmnl libnftnl

    __git-clone git://git.netfilter.org/nftables
    __common nftables
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

__openssl-1.0.1g()
{
    __dep ""

    __wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.1g-fix_parallel_build-1.patch
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.1g-fix_pod_syntax-1.patch
    __dcd openssl-1.0.1g
    patch -Np1 -i $SRC_DIR/openssl-1.0.1g-fix_parallel_build-1.patch
    patch -Np1 -i $SRC_DIR/openssl-1.0.1g-fix_pod_syntax-1.patch
    ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic
    __mk
    __mkinst
}

__openssl()
{
    __openssl-1.0.1g
}

__p11-kit()
{
    __dep certificate-authority-certificates libtasn1 libffi

    __git-clone git://anongit.freedesktop.org/p11-glue/p11-kit
    __common p11-kit
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

__polkit()
{
    __dep "?"

    __git-clone git://anongit.freedesktop.org/polkit
    __cd polkit
    sudo groupadd -fg 28 polkitd
    sudo useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 28 -g polkitd -s /bin/false polkitd
    __bld-common --localstatedir=/var --libexecdir=/usr/lib/polkit-1 --with-authfw=shadow
    cat > /tmp/polkit-1 << .
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
.
    sudo install /tmp/polkit-1 /etc/pam.d/
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

__pth-2.0.7()
{
    __dep ""

    __wget ftp://ftp.ossp.org/pkg/lib/pth/pth-2.0.7.tar.gz
    __dcd pth-2.0.7
    sed -i 's#$(LOBJS): Makefile#$(LOBJS): pth_p.h Makefile#' Makefile.in
    __bld-common
}

__pth()
{
    __pth-2.0.7
}

__python-2.7.6()
{
    __dep expat libffi
}

__python-27()
{
    __python-2.7.6
}

__readline()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/readline.git
    __common readline
}

__sane-backends-1.0.24()
{
    __dep libusb

    __wget http://fossies.org/linux/misc/sane-backends-1.0.24.tar.gz
    __dcd sane-backends-1.0.24
    sudo groupadd -g 70 scanner
    __bld-common --localstatedir=/var --with-group=scanner --enable-libusb_1_0
    sudo install -m 644 -v tools/udev/libsane.rules /etc/udev/rules.d/65-scanner.rules
    sudo chgrp -v scanner /var/lock/sane
    sudo scanimage -L
}

__sane-backends()
{
    __sane-backends-1.0.24
}

__sane-frontends-1.0.14()
{
    __sane-backends gimp

    __wget ftp://ftp2.sane-project.org/pub/sane/sane-frontends-1.0.14.tar.gz
    __dcd sane-frontends-1.0.14
    sed -i -e "/SANE_CAP_ALWAYS_SETTABLE/d" src/gtkglue.c
    __bld-common
    sudo ln -v -s /usr/bin/xscanimage /usr/lib/gimp/2.0/plug-ins
}

__sane-frontends()
{
    __sane-frontends-1.0.14
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

__systemd()
{
    ### 予めArchLinx等のディストリからバイナリーのsystemd-*.so群を/usr/lib/へ手動コピーしておく必要がある。
    ### その上で dbus, linux-pam などの依存パッケージのビルドを行わなければビルドが通らない。

    ### It is necessary to validate some Linux kernel options (i.e. cgroup, fnotify, module).
    __dep libcap dbus kmod libseccomp lvm2 cryptsetup linux-pam

    __git-clone git://anongit.freedesktop.org/systemd/systemd
    __cd systemd

    sudo groupadd -g 190 systemd-journal
    sudo groupadd -g 192 systemd-journal-gateway

    sudo mkdir -p /var/log/journal
    sudo setfacl -nm g:wheel:rx,d:g:wheel:rx,g:adm:rx,d:g:adm:rx /var/log/journal/

    sudo rm -f /etc/mtab
    sudo ln -s /proc/mounts /etc/mtab

    sudo mkdir /run
    sudo rm /var/run -rf
    sudo ln -s /run /var/run

    ### --enable-compat-libs オプションを付けるとビルドが通らないので、現状ではsystemd-*.so群は
    ### 別ディストリから手動でコピーしてくる必要がある。（現在ビルド方法を調査中）
    __bld-common --config-cache --enable-split-usr --enable-shared \
        --disable-tests --enable-gtk-doc-html=no

    sudo systemd-machine-id-setup
}

__systemd-ui()
{
    __dep systemd libgee

    __git-clone git://anongit.freedesktop.org/systemd/systemd-ui
    __common systemd-ui
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

__svn-1.8.8()
{
    __dep apr-util sqlite openssl serf dbus

    __wget http://ftp.riken.jp/net/apache/subversion/subversion-1.8.8.tar.bz2
    __dcd subversion-1.8.8
    __bld-common --with-serf=/usr
}

__svn()
{
    __svn-1.8.8
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
    wget -O $SRC_DIR/tomoyo-tools-2.5.0-20140105.tar.gz 'http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/tomoyo-tools-2.5.0-20140105.tar.gz'

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

__util-linux()
{
    __dep "?"

    __git-clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
    __common util-linux
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

__webkitgtk-2.2.6()
{
    __dep gperf gst-plugin-base gtk+3 icu libsecret libsoup libwebp mesalib ruby sqlite gudev which gobject-introspection

    __wget http://webkitgtk.org/releases/webkitgtk-2.2.6.tar.xz
    __dcd webkitgtk-2.2.6
    __bld-common --enable-introspection --disable-geolocation --enable-webkit1=no
}

__webkitgtk()
{
    __webkitgtk-2.2.6
}

__wget-1.15()
{
    __dep openssl

    __wget http://ftp.gnu.org/gnu/wget/wget-1.15.tar.xz
    __dcd wget-1.15
    __bld-common --with-ssl=openssl --with-openssl --disable-ipv6
}

### wget のビルド&インストールを行う
### 名前が __wget() だと common-func-2.sh 内定義の間数名と重複してしまい、誤動作してしまうため
__wget-install()
{
    __wget-1.15
}

__which-2.20()
{
    __wget ftp://ftp.gnu.org/gnu/which/which-2.20.tar.gz
    __dcd which-2.20
    __bld-common
}

__which()
{
    __which-2.20
}

__wpa_supplicant()
{
    __wget http://hostap.epitest.fi/releases/wpa_supplicant-2.0.tar.gz
    __decord wpa_supplicant-2.0
    __cd wpa_supplicant-2.0/wpa_supplicant
    cat > .config << .
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=n
CONFIG_DEBUG_SYSLOG=n
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=n
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
.
    __mk BINDIR=/sbin LIBDIR=/lib
    sudo install -v -m755 wpa_{cli,passphrase,supplicant} /sbin/ &&
    sudo install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
    sudo install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/
    sudo ldconfig
}

__xsane-0.999()
{
    __dep sane-frontends sane-backends gimp

    __wget http://www.xsane.org/download/xsane-0.999.tar.gz
    __dcd xsane-0.999
    sed -i -e 's/netscape/xdg-open/'                   src/xsane.h
    sed -i -e 's/png_ptr->jmpbuf/png_jmpbuf(png_ptr)/' src/xsane-save.c
    __bld-common
    sudo ln -v -s firefox /usr/bin/netscape
    sudo ln -v -s /usr/bin/xsane /usr/lib/gimp/2.0/plug-ins/
}

__xsane()
{
    __xsane-0.999
}

__xz.git()
{
    __dep ""

    __git-clone http://git.tukaani.org/xz.git
    __common xz
}

__xz-5.0.5()
{
    __dep ""

    __wget http://tukaani.org/xz/xz-5.0.5.tar.xz
    __dcd xz-5.0.5
    __bld-common
}

__xz()
{
    __xz.git
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

__zlib-1.2.8()
{
    __dep ""

    __wget http://www.zlib.net/zlib-1.2.8.tar.xz
    __dcd zlib-1.2.8
    ./configure --prefix=/usr
    __mk
    __mkinst
}

__zlib()
{
    __zlib-1.2.8
}

$@
