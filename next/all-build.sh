#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

case $(uname -m) in
    x86_64) export ABI=64 ;;
    i686) export ABI=32 ;;
    *) echo "未サポートのCPUです" && exit ;;
esac

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

CFLAGS="-O4 -march=native -mtune=native -msse4.2"
CXXFLAGS=${CFLAGS}

MAKEFLAGS="-j4"

. ../common-func/__common-func-2.sh

### ビルド時にシステムメモリーを使いきらないように制限する
__init-build-group

__attr-git()
{
    echo attrは開発版を入れるべきではない
}

### /mnt へインストールされます。それを手動で慎重に /usr/lib へ移植してください。
### ArchLinux 等別システムと連携して上手くやる必要があります。（現システム上で完結しようとしても難しいです）
### /mnt 以下の libattr.la の内容を修正（パス修正 /mnt/usr/lib -> /usr/lib）したものを /usr/lib へコピーしてください。
__attr-2.4.47()
{
    __dep ""

    __wget http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz
    __dcd attr-2.4.47
    INSTALL_USER=root INSTALL_GROUP=root ./configure --prefix=/usr --disable-static
    __mk
    __mkinst install-dev install-lib
    sudo chmod 755 /usr/lib/libattr.so.*
    sudo ldconfig 
}

__attr()
{
    __attr-2.4.47
}

__acl-git()
{
    __dep attr

    __git-clone git://git.savannah.nongnu.org/acl.git
    __cd acl
    __bld-common INSTALL_USER=root INSTALL_GROUP=root --disable-static
}

__acl()
{
    __acl-git
}

__apr-1.5.1()
{
    __dep ""

    __wget http://archive.apache.org/dist/apr/apr-1.5.1.tar.bz2
    __dcd apr-1.5.1
    __bld-common --disable-static
}

__apr()
{
    __apr-1.5.1
}

__apr-util-1.5.4()
{
    __dep apr openssl sqlite

    __wget http://archive.apache.org/dist/apr/apr-util-1.5.4.tar.bz2
    __dcd apr-util-1.5.4
    __bld-common --with-apr=/usr --with-gdbm=/usr --with-openssl=/usr --with-crypto
}

__apr-util()
{
    __apr-util-1.5.4
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

__autoconf-2.69()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz
    __dcd autoconf-2.69
    __bld-common
}

__autoconf()
{
    __autoconf-2.69
}

__autoconf-archive-2016.09.16()
{
    __dep autoconf libtool

    __wget http://ftp.gnu.org/gnu/autoconf-archive/autoconf-archive-2016.09.16.tar.xz
    __dcd autoconf-archive-2016.09.16
    __bld-common
}

__autoconf-archive-git()
{
    __dep autoconf

    __git-clone git://git.sv.gnu.org/autoconf-archive.git
    __cd autoconf-archive
    ./bootstrap.sh
    __bld-common
}

__autoconf-archive()
{
    __autoconf-archive-2016.09.16
}

__automake-1.15()
{
    __dep autoconf

    __wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz
    __dcd automake-1.15
    __bld-common
}

__automake()
{
    __automake-1.15
}

__garcon-0.5.0()
{
    __dep libxfce4ui libxfce4util gtk+2 gtk+3 gtk-doc

    __wget http://archive.xfce.org/src/xfce/garcon/0.5/garcon-0.5.0.tar.bz2
    __dcd garcon-0.5.0
    __bld-common
}

__garcon()
{
    __garcon-0.5.0
}

__gawk-git()
{
    __dep readline

    __git-clone git://git.savannah.gnu.org/gawk.git
    __common gawk
}

__gawk()
{
    __gawk-git
}

__bash()
{
    __dep readline

    __git-clone git://git.savannah.gnu.org/bash.git
    __common bash
}

__berkeley-db-6.1.26()
{
    __dep ""

    __wget http://download.oracle.com/berkeley-db/db-6.1.26.tar.gz
    __dcd db-6.1.26
    cd build_unix
    ../dist/configure --prefix=/usr --enable-compat185 --enable-dbm --disable-static --enable-cxx
    __mk
    sudo make docdir=/usr/share/doc/db-6.1.26 install
    sudo chown -v -R root:root /usr/bin/db_* /usr/include/db{,_185,_cxx}.h /usr/lib/libdb*.{so.la} /usr/share/doc/db-6.1.26
    sudo ldconfig
}

__berkeley-db()
{
    __berkeley-db-6.1.26
}

__binutils-2.27()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.bz2
    __decord binutils-2.27
    __cdbt
    ../binutils-2.27/configure --prefix=/usr --enable-shared --enable-werror=no
    __mk tooldir=/usr
    __mkinst tooldir=/usr install
}

__binutils()
{
    __binutils-2.27
}

__bison-git()
{
    ### flex と bison は開発版を入れるべきではない
    echo
}

__bison-3.0.4()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.xz
    __dcd bison-3.0.4
    ./configure --prefix=/usr --sysconfdir=/etc
    __mk
    __mkinst
}

__bison()
{
    __bison-3.0.4
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

__blfs-boot-scripts-20150924()
{
    __dep ""

    __wget http://www.linuxfromscratch.org/blfs/downloads/svn/blfs-bootscripts-20150924.tar.bz2
    __dcd blfs-bootscripts-20150924
    sudo make $@
}

__blfs-boot-scripts()
{
    __blfs-boot-scripts-20150924 $@
}

__bzip2()
{
    __bzip2-1.0.6
}

__boost-1.60.0()
{
    __dep icu python2

    __wget http://downloads.sourceforge.net/boost/boost_1_60_0.tar.bz2
    __dcd boost_1_60_0
    ./bootstrap.sh --prefix=/usr
    ./b2 stage threading=multi link=shared
    sudo ./b2 install threading=multi link=shared
}

__boost()
{
    __boost-1.60.0
}

__cairo()
{
    __dep libpng glib pixman fontconfig

    __git-clone git://anongit.freedesktop.org/git/cairo
    __cd cairo
    CFLAGS="$CFLAGS -ffat-lto-objects" \
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

__cgal-git()
{
    __git-clone https://github.com/CGAL/cgal.git
    __cd cgal
    __bld-common
}

__cgal()
{
    __cgal-git
}

__clucene-2.3.3.4()
{
    __dep cmake

    __wget http://downloads.sourceforge.net/clucene/clucene-core-2.3.3.4.tar.gz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/clucene-2.3.3.4-contribs_lib-1.patch
    __dcd clucene-core-2.3.3.4
    patch -Np1 -i $SRC_DIR/clucene-2.3.3.4-contribs_lib-1.patch
    __cdbt
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_CONTRIBS_LIB=ON ../clucene-core-2.3.3.4
    __mk
    __mkinst
}

__clucene()
{
    __clucene-2.3.3.4
}

__cmake-git()
{
    __git-clone git://cmake.org/cmake.git
    __cd cmake
    ./bootstrap --prefix=/usr --system-libs --mandir=/share/man --no-system-jsoncpp --docdir=/share/doc/cmaek
}

__cmake-3.7.2()
{
    __dep curl libarchive

    __wget http://www.cmake.org/files/v3.7/cmake-3.7.2.tar.gz
    __dcd cmake-3.7.2
    sed -i '/CMAKE_USE_LIBUV 1/s/1/0/' CMakeLists.txt     &&
    sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake &&
    ./bootstrap --prefix=/usr --system-libs --mandir=/share/man --no-system-jsoncpp --docdir=/share/doc/cmake-3.7.2
    __mk
    __mkinst
}

__cmake()
{
    __cmake-3.7.2
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

__coreutils-8.24()
{
    __dep acl attr

    __wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.24.tar.xz
    __dcd coreutils-8.24
    __bld-common
}

__coreutils()
{
    __coreutils-8.24
}

__colord()
{
    __dep glib intltool lcms2 sqlite dbus

    __git-clone git://github.com/hughsie/colord.git
    __cd colord
    sudo groupadd -g 71 colord
    sudo useradd -c "Color Daemon Owner" -d /var/lib/colord -u 71 -g colord -s /bin/false colord
    __bld-common --localstatedir=/var --with-daemon-user=colord --enable-vala \
                 --disable-argyllcms-sensor --disable-bash-completion \
                 --enable-systemd-login=no --disable-static --enable-gusb=no
}

__cpio-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/cpio.git
    __cd cpio
    ./bootstrap
    __bld-common --bindir=/bin --enable-mt --with-rmt=/usr/libexec/rmt
}

__cpio-2.12()
{
    __dep ""

    __wget http://ftp.gnu.org/pub/gnu/cpio/cpio-2.12.tar.bz2
    __dcd cpio-2.12
    __bld-common --bindir=/bin --enable-mt --with-rmt=/usr/libexec/rmt
}

__cpio()
{
    __cpio-2.12
}

__cryptsetup()
{
    __dep LVM2

    __git-clone https://github.com/mbroz/cryptsetup.git
    __common cryptsetup
}

__curl()
{
    __dep openssl certificate-authority-certificates

    __git-clone git://github.com/bagder/curl.git
    __cd curl
    __git-pull
    ./buildconf
    __bld-common --disable-static --enable-threaded-resolver --with-ca-path=/etc/ssl/certs
}

__cups-2.1.2()
{
    __dep gnutls colord dbus libusb

    __wget http://www.cups.org/software/2.1.2/cups-2.1.2-source.tar.bz2
    __decord cups-2.1.2-source
    __cd cups-2.1.2
    sudo useradd -c "Print Service User" -d /var/spool/cups -g lp -s /bin/false -u 9 lp
    sudo groupadd -g 19 lpadmin
    __bld-common CC=gcc --libdir=/usr/lib --disable-systemd --with-rcdir=/tmp/cupsinit --with-docdir=/usr/share/cups/doc-2.1.2 --with-system-groups=lpadmin
    sudo rm -rf /tmp/cupsinit
    sudo ln -svnf ../cups/doc-2.1.2 /usr/share/doc/cups-2.1.2
    echo "ServerName /var/run/cups/cups.sock" > /tmp/client.conf
    sudo mv /tmp/client.conf /etc/cups/
    sudo rm -rf /usr/share/cups/banners
    sudo rm -rf /usr/share/cups/date/testprint
    sudo gtk-update-icon-cache
    cat > /tmp/cups << "EOF"
# Begin /etc/pam.d/cups

auth    include system-auth
account include system-account
session include system-session

# End /etc/pam.d/cups
EOF
    sudo mv /tmp/cups /etc/pam.d/cups

    __blfs-boot-scripts install-cups
}

__cups()
{
    __cups-2.1.2
}

__cyrus-sasl-2.1.26()
{
    __dep openssl berkeley-db

    __wget ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz
    __wget  http://www.linuxfromscratch.org/patches/blfs/svn/cyrus-sasl-2.1.26-fixes-3.patch
    __dcd cyrus-sasl-2.1.26
    patch -Np1 -i $SRC_DIR/cyrus-sasl-2.1.26-fixes-3.patch
    autoreconf -fi
    __bld-common --enable-auth-sasldb --with-dbpath=/var/lib/sasl/sasldb2 --with-saslauthd=/var/run/saslauthd
    install -v -dm755 /usr/share/doc/cyrus-sasl-2.1.26
    install -v -m644  doc/{*.{html,txt,fig},ONEWS,TODO} saslauthd/LDAP_SASLAUTHD /usr/share/doc/cyrus-sasl-2.1.26
    install -v -dm700 /var/lib/sasl
}

__cyrus-sasl()
{
    __cyrus-sasl-2.1.26
}

__cython-0.23.2()
{
    __dep python2

    __wget http://cython.org/release/Cython-0.23.2.tar.gz
    __dcd Cython-0.23.2
    sudo python2 ./setup.py install
}

__cython()
{
    __cython-0.23.2
}

__dbus()
{
    __dep expat

    __git-clone git://anongit.freedesktop.org/dbus/dbus
    sudo groupadd -g 18 messagebus
    sudo useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 18 \
                 -g messagebus -s /bin/false messagebus
    __cd dbus
    __bld-common --localstatedir=/var                   \
                 --libexecdir=/usr/lib/dbus-1.0         \
                 --with-console-auth-dir=/run/console/  \
                 --enable-systemd=yes                   \
                 --disable-Werror                       \
                 --disable-tests                        \
                 --enable-xml-docs=no

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

__dhcpcd-6.10.1()
{
    __dep ""

    __wget http://roy.marples.name/downloads/dhcpcd/dhcpcd-6.10.1.tar.xz
    __dcd dhcpcd-6.10.1
    __bld-common --libexecdir=/lib/dhcpcd --dbdir=/var/tmp

#    cat > /tmp/ifconfig.wlan0 << .
#ONBOOT="yes"
#IFACE="wlan0"
#SERVICE="dhcpcd"
#DHCP_START=""
#DHCP_STOP="-k"
#.
#    sudo install /tmp/ifconfig.wlan0 /etc/sysconfig/network-devices/

#    cat > /tmp/resolv.conf << .
#nameserver 192.168.11.1
#.
#    sudo install /tmp/resolv.conf /etc/resolv.conf
}

__dhcpcd()
{
    __dhcpcd-6.10.1
}

__dbus-glib()
{
    __dep "?"

    git clone git://anongit.freedesktop.org/dbus/dbus-glib
    __cd dbus-glib
    __bld-common --libexecdir=/usr/lib/dbus-1.0
}

__docbook-4.5()
{
    __dep sgml-common unzip

    __wget http://www.docbook.org/sgml/4.5/docbook-4.5.zip
    mkdir $BASE_DIR/docbook-4.5
    __cd docbook-4.5
    sudo cp $SRC_DIR/docbook-4.5.zip .
    sudo unzip docbook-4.5.zip

    sudo sed -i -e '/ISO 8879/d' -e '/gml/d' docbook.cat

    sudo install -v -d /usr/share/sgml/docbook/sgml-dtd-4.5
    sudo chown -R root:root .
    sudo install -v docbook.cat /usr/share/sgml/docbook/sgml-dtd-4.5/catalog
    sudo cp -v -af *.dtd *.mod *.dcl /usr/share/sgml/docbook/sgml-dtd-4.5
    sudo install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat /usr/share/sgml/docbook/sgml-dtd-4.5/catalog
    sudo install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat /etc/sgml/sgml-docbook.cat

    cat > /tmp/a << EOF
  -- Begin Single Major Version catalog changes --

PUBLIC "-//OASIS//DTD DocBook V4.4//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.3//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.2//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.1//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.0//EN" "docbook.dtd"

  -- End Single Major Version catalog changes --
EOF

    cat /usr/share/sgml/docbook/sgml-dtd-4.5/catalog /tmp/a > /tmp/b
    sudo cp /tmp/b /usr/share/sgml/docbook/sgml-dtd-4.5/catalog
}

__docbook()
{
    __docbook-4.5
}

__docbook-xml-4.3()
{
    __dep libxml2 unzip

    __wget http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip
    mkdir $BASE_DIR/docbook-xml-4.3
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
    mkdir $BASE_DIR/docbook-xml-4.5
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

    for DTDVERSION in 4.1.2 4.2 4.3 4.4
    do
	sudo xmlcatalog --noout --add "public" \
	    "-//OASIS//DTD DocBook XML V$DTDVERSION//EN" \
	    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/docbookx.dtd" \
	    /etc/xml/docbook
	sudo xmlcatalog --noout --add "rewriteSystem" \
	    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
	    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
	    /etc/xml/docbook
	sudo xmlcatalog --noout --add "rewriteURI" \
	    "http://www.oasis-open.org/docbook/xml/$DTDVERSION" \
	    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
	    /etc/xml/docbook
	sudo xmlcatalog --noout --add "delegateSystem" \
	    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
	    "file:///etc/xml/docbook" \
	    /etc/xml/catalog
	sudo xmlcatalog --noout --add "delegateURI" \
	    "http://www.oasis-open.org/docbook/xml/$DTDVERSION/" \
	    "file:///etc/xml/docbook" \
	    /etc/xml/catalog
    done
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

__doxygen-1.8.12()
{
    __dep cmake ghostscript python2

    __wget http://ftp.stack.nl/pub/doxygen/doxygen-1.8.12.src.tar.gz
    __dcd doxygen-1.8.12
    mkdir -v build
    cd build

    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..
    __mk
    sed -i 's:man/man1:share/&:' ../doc/CMakeLists.txt &&
    cmake -DDOC_INSTALL_DIR=share/doc/doxygen-1.8.12 -Dbuild_doc=ON ..
    __mk docs
    __mkinst
    sudo install -vm644 ../doc/*.1 /usr/share/man/man1
}

__doxygen()
{
    __doxygen-1.8.12
}

__emacs-24.5()
{
    __dep "?"

    __wget http://core.ring.gr.jp/pub/GNU/emacs/emacs-24.5.tar.xz
    __dcd emacs-24.5
    __bld-common --localstatedir=/var --libexecdir=/usr/lib --without-gif --with-x-toolkit=yes
}

__emacs()
{
    __emacs-24.5
}

__enchant-1.6.0()
{
    __dep glib

    __wget http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz
    __dcd enchant-1.6.0
    __bld-common
}

__enchant()
{
    __enchant-1.6.0
}

__epoxy-git()
{
    __dep mesa-lib

    __git-clone https://github.com/anholt/libepoxy.git
    __cd libepoxy
    __bld-common
}

__epoxy()
{
    __epoxy-git
}

__eudev()
{
    __dep "?"

    __git-clone git://github.com/gentoo/eudev.git
    __cd eudev
    __git-pull
    ./autogen.sh
    ./configure --prefix=/usr --exec-prefix= --sysconfdir=/etc --enable-libkmod \
	--with-rootprefix= --with-rootlibdir=/lib --enable-legacylib
    __mk
    __mkinst
}

__exo-0.10.6()
{
    __dep libxfce4ui libxfce4util uri gtk-doc

    __wget http://archive.xfce.org/src/xfce/exo/0.10/exo-0.10.6.tar.bz2
    __dcd exo-0.10.6
    __bld-common
}

__exo()
{
    __exo-0.10.6
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

__expat-2.1.1()
{
    __dep ""

    __wget http://prdownloads.sourceforge.net/expat/expat-2.1.1.tar.bz2
    __dcd expat-2.1.1
    __bld-common
    sudo  install -v -dm755 /usr/share/doc/expat-2.1.1
    sudo install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.1.1
}

__expat()
{
    __expat-2.1.1
}

__fdk-aac-0.1.4()
{
    __dep ""

    __wget http://downloads.sourceforge.net/opencore-amr/fdk-aac-0.1.4.tar.gz
    __dcd fdk-aac-0.1.4
    __bld-common
}

__fdk-aac()
{
    __fdk-aac-0.1.4
}

__ffmpeg-2.8.1()
{
    __dep libass fdk-aac freetype lame libtheora libvorbis libvpx opus x264 yasm

    __wget http://ffmpeg.org/releases/ffmpeg-2.8.1.tar.bz2
    __dcd ffmpeg-2.8.1
    __bld-common-simple --enable-gpl --enable-version3 --enable-nonfree --disable-static --enable-shared --disable-debug --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-x11grab --docdir=/usr/share/doc/ffmpeg-2.8.1
}

__ffmpeg()
{
    __ffmpeg-2.8.1
}

__file()
{
    __dep ""

    __git-clone https://github.com/file/file.git
    __cd file
    __self-autogen
    __bld-common
}

__findutils-4.6.0()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/findutils/findutils-4.6.0.tar.gz
    __dcd findutils-4.6.0
    __bld-common --localstatedir=/var/lib/locate
}

__findutils()
{
    __findutils-4.6.0
}

__flex-git()
{
    ### flex と bison は開発版を入れるべきではない
    echo
}

__flex-2.6()
{
### __dep "texlive"
    __dep ""

    __wget http://downloads.sourceforge.net/project/flex/flex-2.6.tar.bz2
    __dcd flex-2.6
    ./configure --prefix=/usr --sysconfdir=/etc
    __mk
    __mkinst
}

__flex()
{
    __flex-2.6
}

__firefox-41.0.2()
{
    __dep alsa-lib gtk+2 nss yasm zip unzip icu libevent libvpx sqlite

    __wget https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/41.0.2/source/firefox-41.0.2.source.tar.xz
    __decord firefox-41.0.2.source
    __cd mozilla-release
    
    cat > mozconfig << "EOF"
# If you have a multicore machine, all cores will be used by default.
# If desired, you can reduce the number of cores used, e.g. to 1, by
# uncommenting the next line and setting a valid number of CPU cores.
#mk_add_options MOZ_MAKE_FLAGS="-j1"

# If you have installed DBus-Glib comment out this line:
ac_add_options --disable-dbus

# If you have installed dbus-glib, and you have installed (or will install)
# wireless-tools, and you wish to use geolocation web services, comment out
# this line
ac_add_options --disable-necko-wifi

# If you have installed libnotify comment out this line:
ac_add_options --disable-libnotify

# GStreamer is necessary for H.264 video playback in HTML5 Video Player;
# to be enabled, also remember to set "media.gstreamer.enabled" to "true"
# in about:config. If you have GStreamer 1.x.y, comment out this line and
# uncomment the following one:
ac_add_options --disable-gstreamer
#ac_add_options --enable-gstreamer=1.0

# Uncomment these lines if you have installed optional dependencies:
#ac_add_options --enable-system-hunspell
#ac_add_options --enable-startup-notification

# Comment out following option if you have PulseAudio installed
ac_add_options --disable-pulseaudio

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --enable-system-sqlite
ac_add_options --with-system-libevent
ac_add_options --with-system-libvpx
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-icu

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=/usr
ac_add_options --enable-application=browser

ac_add_options --disable-crashreporter
ac_add_options --disable-updater
ac_add_options --disable-tests

ac_add_options --enable-optimize
ac_add_options --enable-strip
ac_add_options --enable-install-strip

ac_add_options --enable-gio
ac_add_options --enable-official-branding
ac_add_options --enable-safe-browsing
ac_add_options --enable-url-classifier

ac_add_options --enable-system-cairo
ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-pthreads

ac_add_options --with-system-bz2
ac_add_options --with-system-jpeg
# ac_add_options --with-system-png
ac_add_options --with-system-zlib

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

        make -f client.mk

        sudo make -f client.mk install INSTALL_SDK=
	sudo chown -R 0:0 /usr/lib/firefox-41.0.2
        sudo mkdir -pv /usr/lib/mozilla/plugins
        sudo ln -sfv ../../mozilla/plugins /usr/lib/firefox-41.0.2/browser
}

__firefox-hg()
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

__firefox()
{
    __firefox-41.0.2
}

__fontconfig()
{
    __dep freetype2 expat

    __git-clone git://anongit.freedesktop.org/fontconfig
    __cd fontconfig
    __bld-common --localstatedir=/var --disable-docs PYTHON=/usr/bin/python3
}

__freeglut-3.0.0()
{
    __dep "?"

    __wget http://downloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz
    __dcd freeglut-3.0.0
    __cdbt
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DFREEGLUT_BUILD_DEMOS=OFF -DFREEGLUT_BUILD_STATIC_LIBS=OFF ../freeglut-3.0.0
    __mk
    __mkinst
}

__freeglut-svn()
{
    __dep "?"

    __svn-clone http://svn.code.sf.net/p/freeglut/code/trunk/freeglut/freeglut freeglut
    __cd freeglut
    __svn-pull
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DFREEGLUT_BUILD_STATIC_LIBS=OFF .
    __mk
    __mkinst
}

__freeglut()
{
    __freeglut-3.0.0
}

__freetype2()
{
    __dep which libpng

    __git-clone git://git.sv.gnu.org/freetype/freetype2.git
    __cd freetype2
    __git-pull
    cp include/config/{ftoption.h,ftoption.h.orig}
    sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/config/ftoption.h
    __bld-common
    cp include/config/{ftoption.h.orig,ftoption.h}
}

__fribidi-0.19.7()
{
    __dep glib

    __wget http://fribidi.org/download/fribidi-0.19.7.tar.bz2
    __dcd fribidi-0.19.7
    __bld-common
}

__fribidi()
{
    __fribidi-0.19.7
}

__gc()
{
    __libatomic_ops()
    {
        __git-clone git://github.com/ivmai/libatomic_ops.git
        __cd libatomic_ops
        __git-pull
    }

    __libatomic_ops
    __git-clone git://github.com/ivmai/bdwgc.git
    __cd bdwgc
    __git-pull
    ln -sf ${BASE_DIR}/libatomic_ops ${BASE_DIR}/bdwgc/libatomic_ops
    ./autoreconf -vif
    ./automake --add-missing
    __bld-common
}

__gconf-git()
{
    __dep libxml2

    __git-clone git://git.gnome.org/gconf
    __cd gconf
    __bld-common --disable-orbit
    sudo ln -s gconf.xml.defaults /etc/gconf.xml.system
}

__gconf()
{
    __gconf-git
}

__gconf-editor-git()
{
    __dep gconf

    __git-clone git://git.gnome.org/gconf-editor
    __cd gconf-editor
    __bld-common
}

__gconf-editor()
{
    __gconf-editor-git
}

__gcc-java-5.3.0()
{
    __dep unzip which zip dejagnu gtk libart

    __wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-5.3.0/gcc-5.3.0.tar.bz2
    __wget http://www.antlr.org/download/antlr-4.5-complete.jar
    __wget ftp://sourceware.org/pub/java/ecj-latest.jar
    __decord gcc-5.3.0
    __cdbt
    sed -i 's/\(install.*:\) install-.*recursive/\1/' libffi/Makefile.in
    sed -i 's/\(install-data-am:\).*/\1/'             libffi/include/Makefile.in
    cp $SRC_DIR/ecj-latest.jar ./ecj.jar
    ../gcc-5.3.0/configure --prefix=/usr --disable-multilib --with-system-zlib --disable-bootstrap --enable-java-home --with-jvm-root-dir=/opt/gcj --with-antlr-jar=$SRC_DIR/antlr-4.5-complete.jar --enable-languages=java
    ulimit -s 32768
    __mk
    __mkinst

    sudo mkdir -pv /usr/share/gdb/auto-load/usr/lib
    sudo mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

    sudo chown -v -R root:root /usr/lib/gcc/*linux-gnu/5.3.0/include{,-fixed}
    sudo gcj -o ecj $SRC_DIR/ecj-latest.jar --main=org.eclipse.jdt.internal.compiler.batch.Main
    sudo mv ecj /usr/bin
    sudo ln -sfv /usr/bin/ecj /opt/gcj/bin/javac

    echo 'シェルに以下の環境変数を手動で設定してください'
    echo 'JAVA_HOME="/opt/gcj"'
    echo 'JAVA_CLASSPATH="/usr/share/java"'
    echo 'JAVA_PATH=$JAVA_HOME/bin:$JAVA_HOME/man:$JAVA_HOME/include:$JAVA_HOME/include/linux:$JAVA_CLASSPATH'
}

__gcc-java()
{
    __gcc-java-5.3.0
}

__gcc-6.3.0()
{
    __dep gmp mpfr mpc

    __wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-6.3.0/gcc-6.3.0.tar.bz2
    __decord gcc-6.3.0
    __cdbt
    ../gcc-6.3.0/configure --prefix=/usr --enable-languages=c,c++,fortran,go,objc,obj-c++ --disable-multilib --with-system-zlib
    __mk
    __mkinst
    sudo mkdir -pv /usr/share/gdb/auto-load/usr/lib
    sudo mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
    sudo ldconfig
}

__gcc()
{
    __gcc-6.3.0
}

__gcr()
{
    __dep glib intltool libgcrypt libtasn1 p11-kit gnupg gobject-introspection gtk+3

    __git-clone git://git.gnome.org/gcr
    __common gcr
}

__gdb-7.10()
{
    __dep python2

    __wget http://ftp.gnu.org/gnu/gdb/gdb-7.10.tar.xz
    __dcd gdb-7.10
    __cfg --prefix=/usr --disable-werror
    __mk
    __mkinst -C gdb install
}

__gdb()
{
    __gdb-7.10
}

__geany()
{
    __dep gtk+3

    __git-clone git://github.com/geany/geany.git
    __cd geany
    __bld-common --enable-gtk3 --enable-html-docs=no --enable-pdf-docs=no --enable-api-docs=no 
}

__geoclue-git()
{
    __git-clone git://anongit.freedesktop.org/git/geoclue
    __cd geoclue
    __bld-common
}

__geoclue-0.12.0()
{
    __wget https://launchpad.net/geoclue/trunk/0.12/+download/geoclue-0.12.0.tar.gz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/geoclue-0.12.0-gpsd_fix-1.patch

    __dcd geoclue-0.12.0
    __patch -Np1 -i $SRC_DIR/geoclue-0.12.0-gpsd_fix-1.patch
    sed -i "s@ -Werror@@" configure
    sed -i "s@libnm_glib@libnm-glib@g" configure
    sed -i "s@geoclue/libgeoclue.la@& -lgthread-2.0@g" providers/skyhook/Makefile.in
    __bld-common
}

__geoclue()
{
    __geoclue-0.12.0
}

__geoclue2()
{
    __geoclue-git
}

__gettext-0.19.8.1()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.gz
    __dcd gettext-0.19.8.1
    ./autogen.sh
    ./configure --prefix=/usr
    __mk
    __mkinst
}

__gettext-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/gettext.git
    __cd gettext
    ./autogen.sh
    ./configure --prefix=/usr
    __mk
    __mkinst
}

__gettext()
{
    __gettext-0.19.8.1
}

__gdbm-git()
{
    __dep "?"

    __git-clone git://git.gnu.org.ua/gdbm.git
    __cd gdbm
    __git-pull
    ./bootstrap
    __bld-common --enable-libgdbm-compat
}

__gdbm-1.11()
{
    __dep "?"

    __wget http://ftp.gnu.org/gnu/gdbm/gdbm-1.11.tar.gz
    __dcd gdbm-1.11
    __bld-common --enable-libgdbm-compat
}

__gdbm()
{
    __gdbm-1.11
}

__gdk-pixbuf()
{
    __dep glib libjpeg libpng libtiff gobject-introspection

    __git-clone git://git.gnome.org/gdk-pixbuf
    __cd gdk-pixbuf
    __bld-common --with-x11
    sudo gdk-pixbuf-query-loaders --update-cache
}

__ghostscript-git()
{
    __dep lcms ipafont

    __git-clone git://git.ghostscript.com/ghostpdl.git
    __cd ghostpdl
    __git-pull
    __cd ghostpdl/gs
cat > $BASE_DIR/ghostpdl/gs/Resource/Init/cidfmap << "EOF"
/Adobe-Japan1 << /FileType /TrueType /Path (ipag.ttf) /CSI [(Japan1) 6] >> ;
EOF
    __bld-common
    __mk so
    sudo make soinstall
    sudo ldconfig
    sudo mkdir -p /usr/share/ghostscript/fonts
    sudo cp /usr/share/fonts/IPAfont00303/*.ttf /usr/share/ghostscript/fonts
}

__ghostscript()
{
    __ghostscript-git
}

__giflib-5.1.1()
{
    __dep xmlto

    __wget http://downloads.sourceforge.net/giflib/giflib-5.1.1.tar.bz2
    __dcd giflib-5.1.1
    __bld-common --disable-static

    sudo find doc \( -name Makefile\* -o -name \*.1 -o -name \*.xml \) -exec rm -v {} \;
    sudo install -v -dm755 /usr/share/doc/giflib-5.1.1
    sudo cp -v -R doc/* /usr/share/doc/giflib-5.1.1
}

__giflib()
{
    __giflib-5.1.1
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
    __bld-common --with-pcre=system --enable-debug=no --disable-compile-warnings --with-python=/usr/bin/python3
}

__glibc-2.24-opt()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/libc/glibc-2.24.tar.xz
    __decord glibc-2.24
    __cdbt
    cat > configparms << .
ASFLAGS-config=-O4 -march=native -mtune=native -msse4.2
.
    $BASE_DIR/glibc-2.24/configure --prefix=/opt/glibc --sysconfdir=/opt/glibc/etc  --disable-profile --enable-kernel=3.14 --libexecdir=/opt/glibc/usr/lib/glibc --enable-obsolete-rpc --disable-werror --enable-mathvec
    __mk
    __mkinst
    sudo cp -v $BASE_DIR/glibc-2.24/nscd/nscd.conf /opt/glibc/etc/nscd.conf
    sudo mkdir -pv /opt/glibc/var/cache/nscd
    sudo mkdir -pv /opt/glibc/usr/lib/locale
    sudo localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
#   sudo make localedata/install-locales
}

__glibc-2.24-root()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/libc/glibc-2.24.tar.xz
    __decord glibc-2.24
    __cdbt
    cat > configparms << .
ASFLAGS-config=-O4 -march=native -mtune=native -msse4.2
.
     $BASE_DIR/glibc-2.24/configure --prefix=/ --sysconfdir=/etc  --disable-profile --enable-kernel=3.14 --libexecdir=/usr/lib/glibc --enable-obsolete-rpc --disable-werror --enable-mathvec
    __mk
    __mkinst
    sudo cp -v $BASE_DIR/glibc-2.24/nscd/nscd.conf /etc/nscd.conf
    sudo mkdir -pv /var/cache/nscd
    sudo mkdir -pv /usr/lib/locale
    sudo localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
#   sudo make localedata/install-locales
}

__glib-networking()
{
    __dep gnutls gsettings-desktop-schemas p11-kit

    __git-clone git://git.gnome.org/glib-networking
    __common glib-networking
}

__glibc()
{
    echo "__glibc-2.24-root か __glibc-2.24-opt を選択してください。"
    echo "手順:"
    echo "    1. /etc/ld.so.conf にて、ライブラリ参照の優先度を 『先=/lib 後=/opt/glibc/lib』 となるように設定し、sudo ldconfig にてキャッシュ更新する。"
    echo "    2. all-build.sh __glibc-2.24-opt にて /opt/glibc/lib へライブラリをインストールする。"
    echo "    3. /etc/ld.so.conf にて、ライブラリ参照の優先度を 『先=/opt/glibc/lib 後=/lib』 となるように設定し、sudo ldconfig にてキャッシュ更新する。"
    echo "    4. all-build.sh __glibc-2.24-root にて /lib へライブラリをインストールする。"
    echo "    5. /etc/ld.so.conf にて、ライブラリ参照の優先度を 『先=/lib 後=/opt/glibc/lib』 となるように設定し、sudo ldconfig にてキャッシュ更新する。"
    echo "    6. これで正常に動くようならば、/opt/glibc は消してもよい。/etc/ld.so.conf の /opt/glibc/lib 行を削除してもよい。"
    echo ""
    echo "問題が発生した場合は起動不能となります。動きを十分に考えながら慎重に、またいつでもリカバリーできるように準備しながら進めてください。"
}

__glu-9.0.0()
{
    __dep masa

    __wget ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2
    __dcd glu-9.0.0
    __bld-common --disable-static
}

__glu()
{
    __glu-9.0.0
}

__gobject-introspection()
{
    __dep "?"

    __git-clone git://git.gnome.org/gobject-introspection
    __cd gobject-introspection
    __bld-common --disable-static
}

__gmp-6.1.2()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz
    __decord gmp-6.1.2
    __cd gmp-6.1.2

    case $(uname -m) in
    x86_64) ./configure --prefix=/usr --enable-cxx --docdir=/usr/share/doc/gmp-6.1.2 --build=x86_64-unknown-linux-gnu ;;
    i686)      ./configure --prefix=/usr --enable-cxx --docdir=/usr/share/doc/gmp-6.1.2  ;;
    *) echo "未サポートのCPUです" && exit ;;
    esac

    __mk
    __mkinst
    __mk html
    sudo make install-html
}

__gmp()
{
    __gmp-6.1.2
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

__gnupg.git()
{
    __dep pth libassuan libgcrypt libksba

    __git-clone git://git.gnupg.org/gnupg.git
    __cd gnupg
    __bld-common --enable-maintainer-mode  --with-readline=/usr/lib
}

__gnupg-2.1.15()
{
    __dep pth libassuan libgcrypt libksba

    __wget ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.15.tar.bz2
    __dcd gnupg-2.1.15
    __bld-common --enable-symcryptrun --with-readline=/usr/lib
}

__gnupg()
{
    __gnupg-2.1.15
}

__gnutls.git()
{
    __dep nettle libtasn1 certificate-authority-certificates

    __git-clone git://git.savannah.gnu.org/gnutls.git
    __cd gnutls
    __git-pull
    __self-autogen
    __bld-common --with-default-trust-store-file=/etc/ssl/ca-bundle.crt
}

__gnutls-3.5.8()
{
    __dep nettle gmp libtasn1 p11-kit libidn libunbound zlib certificate-authority-certificates

    __wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.5/gnutls-3.5.8.tar.xz
    __dcd gnutls-3.5.8
    __bld-common --with-default-trust-store-file=/etc/ssl/ca-bundle.crt --enable-gtk-doc-thml=no
}

__gnutls()
{
    __gnutls-3.5.8
}

__grub-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/grub.git
    __cd grub
    __bld-common --sbindir=/sbin --disable-werror
    echo "grub2-install を手動で行ってください"
    echo "例: sudo ln -sf /dev/sda6 /dev/root"
    echo "    sudo /usr/sbin/grub2-install /dev/sda"
}

__grub()
{
    __grub-git
}

__graphite2-1.3.3()
{
    __dep cmake

    __wget  http://downloads.sourceforge.net/silgraphite/graphite2-1.3.3.tgz
    __decord graphite2-1.3.3
    __cdbt
    cmake -DCMAKE_INSTALL_PREFIX=/usr ../graphite2-1.3.3
    __mk
    __mkinst
}

__graphite2()
{
    __graphite2-1.3.3
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

__grep-2.25()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/grep/grep-2.25.tar.xz
    __dcd grep-2.25
    __bld-common
}

__grep()
{
    __grep-2.25
}

__gsettings-desktop-schemas()
{
    __dep glib libtool gobject-introspection

    __git-clone git://git.gnome.org/gsettings-desktop-schemas
    __common gsettings-desktop-schemas
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas
}

__gstreamer-1.6.3()
{
    __dep glib

    __wget http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.6.3.tar.xz
    __dcd gstreamer-1.6.3
    __bld-common
}

__gstreamer()
{
    __gstreamer-1.6.3
}

__gst-libav-1.6.3()
{
    __wget http://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.6.3.tar.xz
    __dcd gst-libav-1.6.3
    __bld-common
}

__gst-libav()
{
    __gst-libav-1.6.3
}

__gst-plugins-bad-1.6.3()
{
    __dep gst-plugins-base libdvdread libdvdnav llvm soundtouch

    __wget http://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.6.3.tar.xz
    __dcd gst-plugins-bad-1.6.3
    __bld-common
}

__gst-plugins-bad()
{
    __gst-plugins-bad-1.6.3
}

__gst-plugins-base-1.6.3()
{
    __dep gstreamer

    __wget http://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.6.3.tar.xz
    __dcd gst-plugins-base-1.6.3
    __bld-common
}

__gst-plugins-base()
{
    __gst-plugins-base-1.6.3
}

__gst-plugins-good-1.6.3()
{
    __dep gst-plugins-base cairo flac gdk-pixbuf libjpeg-turbo libpng libsoup libvpx xorg

    __wget http://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.6.3.tar.xz
    __dcd gst-plugins-good-1.6.3
    __bld-common
}

__gst-plugins-good()
{
    __gst-plugins-good-1.6.3
}

__gst-plugins-ugly-1.6.3()
{
    __dep gst-plugins-base lame libdvdread x264

    __wget http://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.6.3.tar.xz
    __dcd gst-plugins-ugly-1.6.3
    __bld-common
}

__gst-plugins-ugly()
{
    __gst-plugins-ugly-1.6.3
}

__gtk+2()
{
    __dep atk gdk-pixbuf pango gobject-introspection

    __git-clone git://git.gnome.org/gtk+ gtk+-2.24.git
    __cd gtk+-2.24.git

    GTK2VERSION=2.24.31
    make distclean
    git checkout master
    git pull
    git branch -D $GTK2VERSION
    git checkout $GTK2VERSION
    git checkout -b $GTK2VERSION
    __bld-common --with-xinput --with-gdktarget=x11 --with-x --disable-papi
    sudo gtk-query-immodules-2.0 --update-cache

cat > /tmp/t << "EOF"
include "/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
gtk-icon-theme-name = "Mist"
EOF
    sudo cp /tmp/t /etc/gtk-2.0/gtkrc
}

__gtk+3()
{
    __dep at-spi2-atk gdk-pixbuf pango wayland wayland-protocols

    __git-clone git://git.gnome.org/gtk+
    __cd gtk+
    __bld-common --enable-broadway-backend --enable-x11-backend --enable-wayland-backend
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

__gtk-doc-1.21()
{
    __dep docbook-xml docbook-xsl Itstool libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/gtk-doc/1.21/gtk-doc-1.21.tar.xz
    __dcd gtk-doc-1.21
    __bld-common
}

__gtk-doc()
{
    __gtk-doc-1.21
}

__gtk-engines2()
{
    __dep "?"

    __git-clone git://git.gnome.org/gtk-engines
    __git-clone gtk-engines gtk-engines2
    __cd gtk-engines2
    __git-pull
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
    __git-pull
    __autogen.sh
    __cfg --prefix=/usr --sysconfdir=/etc
    # 必ずエラーとなるので
    make
    __mkinst
}

__gtk-xfce-engine-3.2.0()
{
    __dep gtk+2 gtk+3

    __wget http://archive.xfce.org/src/xfce/gtk-xfce-engine/3.2/gtk-xfce-engine-3.2.0.tar.bz2
    __dcd gtk-xfce-engine-3.2.0
    __bld-common --enable-gtk3
}

__gtk-xfce-engine()
{
    __gtk-xfce-engine-3.2.0
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

__gzip-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/gzip.git
    __cd gzip
    ./bootstrap
    __bld-common
   sudo  mv /usr/bin/zip /bin/zip
}

__gzip()
{
    __gzip-git
}

__harfbuzz()
{
    __dep ragel glib icu freetype2 cairo gobject-introspection

    git clone git://anongit.freedesktop.org/harfbuzz
    __common harfbuzz
}

__haskell-mode()
{
    __dep emacs

    __git-clone git://github.com/haskell/haskell-mode.git
    __cd haskell-mode
    __git-pull
    sudo cp ../haskell-mode /usr/share/emacs/site-lisp/ -rf
}

__haskell-mode-config()
{
    __dep haskell-mode

    __mes haskell-mode-config

    grep "haskell-mode" /etc/emacs.el
    if [ $? -ne 0 ]
    then
        cat >> /etc/emacs.el << .
(load "/usr/lib/emacs/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq haskell-program-name "/usr/bin/ghci")
.
    fi
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

__icu-58.2()
{
    __dep llvm

    __wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz
    __decord icu4c-58_2-src
    __cd icu/source
    __bld-common-simple
}

__icu()
{
    __icu-58.2
}

__imagemagick-6.9.2.5()
{
    __dep "?"

    __wget http://www.imagemagick.org/download/ImageMagick-6.9.2-5.tar.xz
    __dcd ImageMagick-6.9.2-5
    __bld-common --enable-hdri --with-modules --with-perl --disable-static
    __mkinst DOCUMENTATION_PATH=/usr/share/doc/imagemagick-6.9.2.5
}

__imagemagick()
{
    __imagemagick-6.9.2.5
}

__inetutils()
{
    __dep syslog.conf

    __git-clone git://git.savannah.gnu.org/inetutils.git
    __cd inetutils
    __git-pull
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

__intltool-0.51.0()
{
    __dep perl-module-xml-parser

    __wget http://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
    __dcd intltool-0.51.0
    __bld-common
}

__intltool()
{
    __intltool-0.51.0
}

__iproute2()
{
    __dep ""

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git
    __cd iproute2
    __git-pull
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

__java-1.8.0.66()
{
    __dep ""

    __wget http://anduin.linuxfromscratch.org/BLFS/OpenJDK/OpenJDK-1.8.0.66/OpenJDK-1.8.0.66-i686-bin.tar.xz
    __dcd OpenJDK-1.8.0.66-i686-bin
    sudo install -vdm755 /opt/OpenJDK-1.8.0.66-bin
    sudo mv -v * /opt/OpenJDK-1.8.0.66-bin
    sudo chown -R root:root /opt/OpenJDK-1.8.0.66-bin
    sudo ln -sfn OpenJDK-1.8.0.66-bin /opt/jdk

    echo 'シェルに以下の環境変数を手動で設定してください'
    echo 'JAVA_HOME="/opt/OpenJDK-1.8.0.66-bin"'
    echo 'JAVA_CLASSPATH=""'
    echo 'JAVA_PATH=$JAVA_HOME/bin:$JAVA_HOME/man:$JAVA_HOME/include:$JAVA_HOME/include/linux:$JAVA_CLASSPATH'
}

__java()
{
    __java-1.8.0.66
}

__json-c-0.12()
{
    __dep ""

    __wget https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.tar.gz
    __dcd json-c-0.12
    sed -i s/-Werror// Makefile.in
    ./configure --prefix=/usr --disable-static
    __mk
    __mkinst
}

__json-c()
{
    __json-c-0.12
}

__json-glib-git()
{
    __dep ""

    __git-clone git://git.gnome.org/json-glib
    __cd json-glib
    __bld-common
}

__json-glib()
{
    __json-glib-git
}

__junit-4.11()
{
    __dep apache-ant unzip

    __wget https://launchpad.net/debian/+archive/primary/+files/junit4_4.11.orig.tar.gz
    __wget http://hamcrest.googlecode.com/files/hamcrest-1.3.tgz
    __decord junit4_4.11.orig
    __cd junit4-4.11
    sed -i '\@/docs/@a<arg value="-Xdoclint:none"/>' build.xml
    tar -xf $SRC_DIR/hamcrest-1.3.tgz
    cp -v hamcrest-1.3/hamcrest-core-1.3{,-sources}.jar lib/
    ant populate-dist
    sudo install -v -m755 -d /usr/share/{doc,java}/junit-4.11
    sudo chown -R root:root .
    sudo cp -v -R junit*/javadoc/*             /usr/share/doc/junit-4.11
    sudo cp -v junit*/junit*.jar               /usr/share/java/junit-4.11
    sudo cp -v hamcrest-1.3/hamcrest-core*.jar /usr/share/java/junit-4.11
}

__junit()
{
    __junit-4.11
}

__make-4.1()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/make/make-4.1.tar.bz2
    __dcd make-4.1
    __bld-common
}

__make()
{
    __make-4.1
}

__mako()
{
    __dep python

    __wget https://pypi.python.org/packages/source/M/Mako/Mako-1.0.2.tar.gz
    __dcd Mako-1.0.2
    sudo python2 setup.py install --optimize=1
    sudo python3 setup.py install --optimize=1
}

__mesalib-18.1.6()
{
    __dep xorg-lib libdrm

    __wget https://mesa.freedesktop.org/archive/mesa-18.1.6.tar.xz
    __dcd mesa-18.1.6
    GLL_DRV="nouveau,swrast,virgl,i915"
    ./autogen.sh CFLAGS='-O4' CXXFLAGS='-O4'     \
		 --prefix=/usr                   \
		 --sysconfdir=/etc               \
		 --enable-texture-float          \
		 --enable-gles1                  \
		 --enable-gles2                  \
		 --enable-osmesa                 \
		 --enable-xa                     \
		 --enable-gbm                    \
		 --enable-glx-tls                \
		 --with-egl-platforms="drm,x11,wayland"  \
		 --with-gallium-drivers=$GLL_DRV
    unset GLL_DRV
    __mk
    __mkinst
}

__mesalib()
{
    __mesalib-18.1.6
}

__krita-git()
{
    __dep ""

    __git-clone https://github.com/KDE/krita.git
    __cd krita

    mkdir -v build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr ..
    __mk
    __mkinst
}

__krita()
{
    __krita-git
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

__mozjs-17.0.0()
{
    __dep libffi nspr python27 zip

    __wget http://ftp.mozilla.org/pub/mozilla.org/js/mozjs17.0.0.tar.bz2
    __dcd mozjs17.0.0
    cd js/src
    __bld-common --enable-threadsafe --with-system-ffi --with-system-nspr
    sudo find /usr/include/mozjs-17.0/ /usr/lib/libmozjs-17.0.a /usr/lib/pkgconfig/mozjs-17.0.pc -type f -exec chmod -v 644 {} \;
}

__mozjs-24.2.0()
{
    __dep libffi nspr python27 zip

    __wget http://ftp.mozilla.org/pub/mozilla.org/js/mozjs-24.2.0.tar.bz2
    __dcd mozjs-24.2.0
    cd js/src
    __bld-common --enable-threadsafe --with-system-ffi --with-system-nspr
    sudo find /usr/include/mozjs-24/ /usr/lib/libmozjs-24.a /usr/lib/pkgconfig/mozjs-24.pc -type f -exec chmod -v 644 {} \;
}

__mozjs()
{
    __mozjs-24.2.0
}

__lame-3.99.5()
{
    __dep dmalloc electric-fence libsndfile nasm

    __wget http://downloads.sourceforge.net/lame/lame-3.99.5.tar.gz
    __dcd lame-3.99.5
    __bld-common --enable-mp3rtp --disable-static
}

__lame()
{
    __lame-3.99.5
}

__linux-pam-config()
{
    __dep ""

    cat > /tmp/other << "EOF"
# Begin /etc/pam.d/other

auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok

# End /etc/pam.d/other
EOF

    cat > /tmp/system-account << "EOF"
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

    cat > /tmp/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

    cat > /tmp/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

    sudo mkdir /etc/pam.d
    sudo cp /tmp/{other,system-account,system-auth,system-session} /etc/pam.d/

    sudo cat /etc/pam.d/*
}


__linux-pam-git()
{
    __dep ""

    __git-clone https://git.fedorahosted.org/git/linux-pam.git
    __cd linux-pam
    __bld-common --enable-securedir=/lib/security --disable-regenerate-docu --enable-debug=no
}

__linux-pam-1.3.0()
{
    __dep ""

    __wget http://linux-pam.org/library/Linux-PAM-1.3.0.tar.bz2
    __dcd Linux-PAM-1.3.0
    __bld-common --libdir=/usr/lib --enable-securedir=/lib/security --docdir=/usr/share/doc/Linux-PAM-1.3.0
    sudo chmod -v 4755 /sbin/unix/chkpwd
    for file in pam pam_misc pamc
    do
        sudo mv -v /usr/lib/lib${file}.so.* /lib
        sudo ln -sfv ../../lib/$(readlink /usr/lib/lib${file}.so) /usr/lib/lib${file}.so
    done
}

__linux-pam()
{
    __linux-pam-1.3.0
}

__lcms2()
{
    __dep libjpeg libtiff

    __git-clone https://github.com/mm2/Little-CMS.git lcms2
    __cd lcms2
    __git-pull
    __self-autogen
    __bld-common
}

__libarchive()
{
    __dep "?"

    __git-clone https://github.com/libarchive/libarchive.git
    __cd libarchive
    __git-pull
    aclocal
    libtoolize
    autoconf
    autoheader
    automake -acf
    ./configure --prefix=/usr --disable-static
    __mk DEV_CFLAGS=""
    __mkinst
}

__libass-0.12.3()
{
    __dep freetype fribidi fontconfig harfbuzz enca

    __wget http://anduin.linuxfromscratch.org/sources/other/libass-0.12.3.tar.gz
    __dcd libass-0.12.3
    sh autogen.sh
    __bld-common
}

__libass()
{
    __libass-0.12.3
}

__libassuan-2.4.3()
{
    __dep "?"

    __wget ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.4.3.tar.bz2
    __dcd libassuan-2.4.3
    __bld-common
}

__libassuan()
{
    __libassuan-2.4.3
}

__libcanberra-git()
{
    __dep "?"

    __git-clone git://git.0pointer.de/libcanberra
    __cd libcanberra
    __bld-common --disable-oss
}

__libcanberra()
{
    __libcanberra-git
}

__libcap()
{
    __dep attr linux-pam

    __git-clone git://git.kernel.org/pub/scm/linux/kernel/git/morgan/libcap.git
    __cd libcap
    __git-pull
    __mk prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
    __mkinst prefix=/usr SBINDIR=/sbin PAM_LIBDIR=/lib RAISE_SETFCAP=no
}

__libcg()
{
    __dep linux-pam

    __git-clone git://git.code.sf.net/p/libcg/libcg
    __cd libcg
    __git-pull
    ./bootstrap.sh
    __bld-common
}

__libcroco()
{
    __dep glib libxml2

    __git-clone git://git.gnome.org/libcroco
    __common libcroco
}

__libcrypt-1.6.2()
{
    __dep libpgp-error

    __wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.2.tar.bz2
    __dcd libgcrypt-1.6.2
    __bld_common
}

__libcrypt()
{
    __libcrypt-1.6.2
}

__libdrm-2.4.93()
{
    __dep meson

    __wget http://dri.freedesktop.org/libdrm/libdrm-2.4.93.tar.bz2
    __dcd libdrm-2.4.93
    mkdir build
    cd build
    meson --prefix=/usr -Dudev=true
    ninja
    sudo ninja install
}

__libdrm()
{
    __libdrm-2.4.93
}

__libdvdread-5.0.3()
{
    __dep ""

    __wget http://download.videolan.org/videolan/libdvdread/5.0.3/libdvdread-5.0.3.tar.bz2
    __dcd libdvdread-5.0.3
    __bld-common --disable-static --docdir=/usr/share/doc/libdvdread-5.0.3
}

__libdvdread()
{
    __libdvdread-5.0.3
}

__libepoxy-git()
{
    __dep mesa-lib

    __git-clone https://github.com/anholt/libepoxy.git
    __common libepoxy
}

__libepoxy()
{
    __libepoxy-git
}

__libevent-git()
{
    __dep openssl

    __git-clone https://github.com/libevent/libevent.git
    __common libevent
}

__libevent()
{
    __libevent-git
}

__libffi()
{
    __dep ""

    __git-clone https://github.com/atgreen/libffi.git
    __common libffi
}

__libgcrypt.git()
{
    __dep libgpg-error libcap pth

    __git-clone git://git.gnupg.org/libgcrypt.git
    __cd libgcrypt
    __git-pull

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

__libgcrypt-1.7.3()
{
    __dep libgpg-error libcap pth

    __wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.7.3.tar.bz2
    __dcd libgcrypt-1.7.3
    __bld-common --enable-maintainer-mode
}

__libgcrypt()
{
    __libgcrypt-1.7.3
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

__libgpg-error-git()
{
    __dep ""

    __git-clone git://git.gnupg.org/libgpg-error.git
    __cd libgpg-error
    __self-autogen
    __bld-common --enable-maintainer-mode
}

__libgpg-error-1.24()
{
    __dep ""

    __wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.24.tar.bz2
    __dcd libgpg-error-1.24
    __bld-common --enable-maintainer-mode
}

__libgpg-error()
{
    __libgpg-error-1.24
}

__libgudev-git()
{
    __dep glib gobject-introspection gtk-doc

    __git-clone git://git.gnome.org/libgudev
    __cd libgudev
    __autogen
    __bld-common-simple
}

__libgudev()
{
    __libgudev-git
}

__libgusb-0.2.3()
{
    __dep libusb

    __wget http://people.freedesktop.org/~hughsient/releases/libgusb-0.2.3.tar.xz
    __dcd libgusb-0.2.3
    __bld-common --disable-static
}

__libgusb()
{
    __libgusb-0.2.3
}

__libidn-git()
{
    __dep pth

    __git-clone git clone git://git.savannah.gnu.org/libidn.git
    __cd libidn
    __bld-common --disable-static
}

__libidn-1.32()
{
    __dep pth

    __wget http://ftp.gnu.org/gnu/libidn/libidn-1.32.tar.gz
    __dcd libidn-1.32
    __bld-common --disable-static
}

__libidn()
{
    __libidn-1.32
}

__libinput-git()
{
    __dep mtdev

    __git-clone git://anongit.freedesktop.org/wayland/libinput
    __cd libinput
    __bld-common --disable-static
}

__libinput()
{
    __libinput-git
}

__libksba-1.3.5()
{
    __dep libgpg-error

    __wget ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.5.tar.bz2
    __dcd libksba-1.3.5
    __bld-common
}

__libksba()
{
    __libksba-1.3.5
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

__libjpeg-turbo-1.4.2()
{
    __dep yasm

    __wget http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.4.2.tar.gz
    __dcd libjpeg-turbo-1.4.2
    __bld-common --mandir=/usr/share/man --with-jpeg8 --disable-static
}

__libjpeg-turbo()
{
    __libjpeg-turbo-1.4.2
}

__libnotify-git()
{
    __dep gtk+3

    __git-clone git://git.gnome.org/libnotify
    __cd libnotify
    __bld-common
}

__libnotify()
{
    __libnotify-git
}

__libogg-1.3.2()
{
    __dep ""

    __wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz
    __dcd libogg-1.3.2
    __bld-common --docdir=/usr/share/doc/libogg-1.3.2 --disable-static
}

__libogg-git()
{
    __dep ""

    __git-clone https://git.xiph.org/ogg.git
    __cd ogg
    __bld-common --docdir=/usr/share/doc/libogg-1.3.2 --disable-static
}

__libogg()
{
    __libogg-git
}

__libreoffice-5.0.3()
{
    __dep boost clucene cups curl dbus-glib libjpeg-turbo glu graphite2 gst-plugins-base gtk+2 harfbuzz icu littlecms librsvg libxml2 libxslt mesalib neon npapi-sdk nss openldap openssl poppler python-3 redland unixodbc

    __wget http://download.documentfoundation.org/libreoffice/src/5.0.3/libreoffice-5.0.3.2.tar.xz
    __wget http://download.documentfoundation.org/libreoffice/src/5.0.3/libreoffice-dictionaries-5.0.3.2.tar.xz
    __wget http://download.documentfoundation.org/libreoffice/src/5.0.3/libreoffice-help-5.0.3.2.tar.xz
    __wget http://download.documentfoundation.org/libreoffice/src/5.0.3/libreoffice-translations-5.0.3.2.tar.xz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/libreoffice-5.0.3.2-boost_1_59_0-1.patch
    __dcd libreoffice-5.0.3.2
    install -dm755 external/tarballs
    ln -sv $SRC_DIR/libreoffice-dictionaries-5.0.3.2.tar.xz external/tarballs/
    ln -sv $SRC_DIR/libreoffice-help-5.0.3.2.tar.xz         external/tarballs/
    ln -sv $SRC_DIR/libreoffice-translations-5.0.3.2.tar.xz external/tarballs/
    LO_PREFIX=/usr

    CPPUNITTRACE="gdb --args"    # for interactive debugging on Linux

    patch -Np1 -i $SRC_DIR/libreoffice-5.0.3.2-boost_1_59_0-1.patch

    sed -e "/gzip -f/d" -e "s|.1.gz|.1|g" -i bin/distro-install-desktop-integration
    sed -e "/distro-install-file-lists/d" -i Makefile.in

    sed -e "/ustrbuf/a #include <algorithm>" -i svl/source/misc/gridprinter.cxx

    chmod -v +x bin/unpack-sources

    ./autogen.sh --prefix=$LO_PREFIX     \
             --sysconfdir=/etc           \
             --with-vendor="BLFS"        \
             --with-lang="ja"            \
             --with-help                 \
             --with-myspell-dicts        \
             --with-alloc=system         \
             --without-java              \
             --without-system-dicts      \
             --disable-gconf             \
             --disable-odk               \
             --disable-postgresql-sdbc   \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-cairo         \
             --with-system-curl          \
             --with-system-expat         \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-mesa-headers  \
             --with-system-neon          \
             --with-system-npapi-headers \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-redland       \
             --with-system-zlib          \
             --with-parallelism=$(getconf _NPROCESSORS_ONLN)

    __mk build
    sudo make distro-pack-install
    sudo install -v -m755 -d $LO_PREFIX/share/appdata
    sudo install -v -m644    sysui/desktop/appstream-appdata/*.xml $LO_PREFIX/share/appdata

    update-desktop-database
}

__libreoffice()
{
    __libreoffice-5.0.3
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

    __git-clone https://github.com/seccomp/libseccomp.git
    __common libseccomp
}

__libsecret()
{
    __dep glib gobject-introspection libgcrypt vala

    __git-clone git://git.gnome.org/libsecret
    __common libsecret
}

__libsndfile-1.2.25()
{
    __dep alsa-lib flac libogg sqlite

    __wget http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.25.tar.gz
    __dcd libsndfile-1.0.25
    __bld-common
}

__libsndfile()
{
    __libsndfile-1.2.25
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
    __bld-common-simple --enable-static=no
}

__libtasn1-4.10()
{
    __dep "libidn"

    __wget http://ftp.gnu.org/gnu/libtasn1/libtasn1-4.10.tar.gz
    __dcd libtasn1-4.10
    __bld-common --enable-static=no
}

__libtasn1()
{
    __libtasn1-4.10
}

__libtheora-1.1.1()
{
    __dep libogg libvorbis sdl1 libpng doxygen texlive bidtex transfig valgrind

    __wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.xz
    __dcd libtheora-1.1.1
    sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c
    __bld-common --disable-static
}

__libtheora-git()
{
    __dep libogg libvorbis sdl1 libpng doxygen texlive bidtex transfig valgrind

    __git-clone https://git.xiph.org/theora.git
    __cd theora
    sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c
    __bld-common --disable-static
}

__libtheora()
{
    __libtheora-git
}

__libtiff-4.0.4()
{
    __dep libjpeg-8

    __wget ftp://ftp.remotesensing.org/libtiff/tiff-4.0.4.tar.gz
    __dcd tiff-4.0.4
    __bld-common
}

__libtiff()
{
    __libtiff-4.0.4
}

__libtool.git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libtool.git
    __cd libtool
    __git-pull
    ./bootstrap
    __bld-common
}

__libtool-2.4.6()
{
    __dep ""

    __wget http://ftp.jaist.ac.jp/pub/GNU/libtool/libtool-2.4.6.tar.xz
    __dcd libtool-2.4.6
    __bld-common
}

__libtool()
{
    __libtool-2.4.6
}

__libunbound-1.5.3()
{
    __dep ""

    __wget http://unbound.net/downloads/unbound-1.5.3.tar.gz
    __dcd unbound-1.5.3
    __bld-common
}

__libunbound()
{
    __libunbound-1.5.3
}

__libunistring()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libunistring.git
    __common libunistring
}

__libusb-1.0.19()
{
    __wget http://downloads.sourceforge.net/libusb/libusb-1.0.19.tar.bz2
    __dcd libusb-1.0.19
    __bld-common --disable-static
}

__libusb()
{
    __libusb-1.0.19
}

__libwacom-git()
{
    __git-clone git://git.code.sf.net/p/linuxwacom/libwacom
    __common libwacom
}

__libwacom()
{
    __libwacom-git
}

__libwebp-git()
{
    __dep libjpeg-turbo libpng libtiff freeglut giflib

    __git-clone https://chromium.googlesource.com/webm/libwebp
    __cd libwebp
    __autogen
    __bld-common --disable-static --enable-experimental --enable-libwebpdecoder \
		 --enable-libwebpdemux --enable-libwebpmux
}

__libwebp-0.5.0()
{
    __dep libjpeg-turbo libpng libtiff freeglut giflib

    __wget http://downloads.webmproject.org/releases/webp/libwebp-0.5.0.tar.gz
    __dcd libwebp-0.5.0
    __bld-common --disable-static --enable-experimental --enable-libwebpdecoder \
		 --enable-libwebpdemux --enable-libwebpmux
}

__libwebp()
{
    __libwebp-0.5.0
}

__libwnck-2.30.7()
{
    __dep gtk+2 startup-notification gobject-introspection gtk-doc

    __wget http://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
    __dcd libwnck-2.30.7
    __bld-common --disable-static --program-suffix=-1
}

__libwnck()
{
    __libwnck-2.30.7
}

__libwpd-0.9.9()
{
    __dep ""

    __wget http://downloads.sourceforge.net/libwpd/libwpd-0.9.9.tar.xz
    __dcd libwpd-0.9.9
    __bld-common
}

__libwpd()
{
    __libwpd-0.9.9
}

__libwpg-0.2.2()
{
    __dep ""

    __wget http://downloads.sourceforge.net/libwpg/libwpg-0.2.2.tar.xz
    __dcd libwpg-0.2.2
    __bld-common --disable-static
}

__libwpg()
{
    __libwpg-0.2.2
}

__libxkbcommon()
{
    __dep "?"

    __git-clone https://github.com/xkbcommon/libxkbcommon.git
    __common libxkbcommon
}

__libxklavier-git()
{
    __dep iso-codes

    __git-clone git://anongit.freedesktop.org/libxklavier
    __cd libxklavier
    __bld-common
}

__libxklavier()
{
    __libxklavier-git
}

__libxfce4ui-4.12.1()
{
    __dep gtk+2 gtk+3 xfconf gdk-doc

    __wget http://archive.xfce.org/src/xfce/libxfce4ui/4.12/libxfce4ui-4.12.1.tar.bz2
    __dcd libxfce4ui-4.12.1
    __bld-common
}

__libxfce4ui()
{
    __libxfce4ui-4.12.1
}

__libxfce4util-4.12.1()
{
    __dep glib gtk-doc

    __wget http://archive.xfce.org/src/xfce/libxfce4util/4.12/libxfce4util-4.12.1.tar.bz2
    __dcd libxfce4util-4.12.1
    __bld-common
}

__libxfce4util()
{
    __libxfce4util-4.12.1
}

__libxml2-git()
{
    __dep python2

    __git-clone git://git.gnome.org/libxml2
    __cd libxml2
    __bld-common --disable-static --with-history --with-python=/usr/bin/python3
}

__libxml2-2.9.4()
{
    __dep python2

    __wget http://xmlsoft.org/sources/libxml2-2.9.4.tar.gz
    __wget http://www.w3.org/XML/Test/xmlts20130923.tar.gz
    __dcd libxml2-2.9.4
    tar xf $SRC_DIR/xmlts20130923.tar.gz
    sed \
	-e /xmlInitializeCatalog/d \
	-e 's/((ent->checked =.*&&/(((ent->checked == 0) ||\
          ((ent->children == NULL) \&\& (ctxt->options \& XML_PARSE_NOENT))) \&\&/' \
	-i parser.c
    __bld-common --disable-static --with-history --with-python=/usr/bin/python3
}

__libxml2()
{
    __libxml2-2.9.4
}

__libxslt-1.1.28()
{
    __dep libxml2

    __wget http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz
    __dcd libxslt-1.1.28
    PYTHON=/usr/bin/python2 ./configure --prefix=/usr --disable-static --with-python=/usr/lib/python2.7/
    __mk
    __mkinst
}

__libxslt-git()
{
    __dep libxml2

    __git-clone git://git.gnome.org/libxslt
    __cd libxslt
    PYTHON=/usr/bin/python2 ./configure --prefix=/usr  --disable-static --with-python=/usr/lib/python2.7/
    __mk
    __mkinst
}

__libxslt()
{
    __libxslt-git
}

__libva()
{
    __dep "?"

    git clone git://anongit.freedesktop.org/git/libva
    __common libva
}

__libvorbis-1.3.5()
{
    __dep libogg doxygen texlive

    __wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz
    __dcd libvorbis-1.3.5
    __bld-common --disable-static
    sudo install -v -m644 doc/Vorbis* /usr/share/doc/libvorbis-1.3.5
}

__libvorbis-git()
{
    __dep libogg doxygen texlive

    __git-clone https://git.xiph.org/vorbis.git
    __cd vorbis
    __bld-common --disable-static
    sudo install -v -m644 doc/Vorbis* /usr/share/doc/libvorbis
}

__libvorbis()
{
    __libvorbis-git
}

__llvm-3.9.0()
{
    __dep libffi python2 zip libxml2

    __wget http://llvm.org/releases/3.9.0/llvm-3.9.0.src.tar.xz
    __wget http://llvm.org/releases/3.9.0/cfe-3.9.0.src.tar.xz
    __wget http://llvm.org/releases/3.9.0/compiler-rt-3.9.0.src.tar.xz
    __dcd llvm-3.9.0.src
    tar -xf $SRC_DIR/cfe-3.9.0.src.tar.xz -C tools
    tar -xf $SRC_DIR/compiler-rt-3.9.0.src.tar.xz -C projects

    mv tools/cfe-3.9.0.src tools/clang
    mv projects/compiler-rt-3.9.0.src projects/compiler-rt

    mkdir -v build
    cd build

    CC=gcc CXX=g++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DLLVM_ENABLE_FFI=ON -DCMAKE_BUILD_TYPE=Release -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_TARGETS_TO_BUILD="host;AMDGPU" -Wno-dev ..
   __mk
    __mkinst
}

__llvm()
{
    __llvm-3.9.0
}

__lm-sensors-svn()
{
    __dep ""

    __svn-clone http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors
    __cd lm-sensors
    __svn-pull
    make PREFIX=/usr
    sudo make PREFIX=/usr install
}

__lm-sensors()
{
    __lm-sensors-svn
}

__lvm2-2.02.152()
{
    ### Use kernel configuration
    ### Device Drivers --->
    ###   Multiple devices driver support (RAID and LVM): Y
    ###   Device mapper support: Y or M
    ###   Crypt target support: (optional)
    ###   Snapshot target: (optional)
    ###   Mirror target: (optional) 

    __dep ""

    __wget ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.152.tgz
    __dcd LVM2.2.02.152
    __bld-common --exec-prefix= --with-confdir=/etc \
        --enable-applib --enable-cmdlib --enable-pkgconfig --enable-udev_sync
}

__lvm2()
{
    __lvm2-2.02.152
}

__libvpx-git()
{
    __dep yasm which doxygen php

    __git-clone https://chromium.googlesource.com/webm/libvpx
    __cd libvpx
    mkdir ../libvpx-build
    cd ../libvpx-build
    ../configure --prefix=/usr --enable-shared --disable-static
    __mk
    __mkinst
}

__libvpx()
{
    __libvpx-git
}

__ls2ch-git()
{
    __dep bison flex wget

    __git-clone https://github.com/takeutch-kemeco/ls2ch.git
    __cd ls2ch
    __bld-common
}

__ls2ch()
{
    __ls2ch-git
}

__lxml-git()
{
    __dep python

    __git-clone https://github.com/lxml/lxml.git
    __cd lxml    
    sudo python2 setup.py install
    sudo python3 setup.py install
}

__lxml()
{
    __lxml-git
}

__m4-1.4.18()
{
    __dep ""

    __wget http://ftp.jaist.ac.jp/pub/GNU/m4/m4-1.4.18.tar.xz
    __dcd m4-1.4.18
    __bld-common
}

__m4()
{
    __m4-1.4.18
}

__maco-1.0.1()
{
    __dep "?"

    __wget http://
    __dcd Mako-1.0.1
    python2.7 setup.py build
    sudo python2.7 setup.py install
}

__maco()
{
    __maco-1.0.1
}

### .tar.bz2 がディレクトリにパックされてない（各ファイルが直に展開される）ので注意
__midori-0.5.10()
{
    __dep cmake libnotify webkitgtk vala

    __wget http://www.midori-browser.org/downloads/midori_0.5.10_all_.tar.bz2
    mkdir $BASE_DIR/midori-0.5.10
    __cd midori-0.5.10
    bzip2 -dc $SRC_DIR/midori_0.5.10_all_.tar.bz2 | tar xvf -
    __bld-common-simple --enable-gtk3 --disable-zeitgeist --enable-granite=no --enable-apidocs=no
}

__midori()
{
    __midori-0.5.10
}

__mpc-1.0.3()
{
    __dep mpfr

    __wget http://www.multiprecision.org/mpc/download/mpc-1.0.3.tar.gz
    __dcd mpc-1.0.3
    __cfg --prefix=/usr
    __mk
    __mkinst
}

__mpc()
{
    __mpc-1.0.3
}

__mpfr-3.1.5()
{
    __dep gmp

    __wget http://www.mpfr.org/mpfr-current/mpfr-3.1.5.tar.xz
    __dcd mpfr-3.1.5
    ./configure --prefix=/usr --enable-thread-safe --docdir=/usr/share/doc/mpfr-3.1.5
    __mk
    __mkinst
}

__mpfr()
{
    __mpfr-3.1.5
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

__mtdev-git()
{
    __dep "?"

    __git-clone http://bitmath.org/git/mtdev.git
    __cd mtdev
    __bld-common
}

__mtdev()
{
    __mtdev-git
}

__ncurses-6.0()
{
    __dep "?"

    __wget http://ftp.gnu.org/gnu//ncurses/ncurses-6.0.tar.gz
    __dcd ncurses-6.0
    sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
    __bld-common --mandir=/usr/share/man --with-shared --without-debug --without-normal --enable-pc-files --enable-widec
    sudo mv -v /usr/lib/libncursesw.so.6* /lib
    sudo ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so
    for A in ncurses form panel menu ; do
        sudo rm -vf /usr/lib/lib${lib}.so
        sudo sh -C 'echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so'
        sudo ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
    done
    sudo rm -vf /usr/lib/libcursesw.so
    sudo sh -C 'echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so'
    sudo ln -sfv libncurses.so /usr/lib/libcurses.so
    sudo mkdir -v /usr/share/doc/ncurses-6.0
    sudo cp -v -R doc/* /usr/share/doc/ncurses-6.0
}

__ncurses-5.7()
{
    __dep ""

    __wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.7.tar.gz
    __dcd ncurses-5.7
    __bld-common --with-shared --without-debug --enable-widec
    sudo mv -v /usr/lib/libncursesw.so.5* /lib
    sudo ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so
    for lib in ncurses form panel menu ; do \
	sudo rm -vf /usr/lib/lib${lib}.so ; \
	sudo echo "INPUT(-l${lib}w)" >/usr/lib/lib${lib}.so ; \
	sudo ln -sfv lib${lib}w.a /usr/lib/lib${lib}.a ; \
    done
    sudo ln -sfv libncurses++w.a /usr/lib/libncurses++.a
    sudo rm -vf /usr/lib/libcursesw.so
    sudo echo "INPUT(-lncursesw)" >/usr/lib/libcursesw.so
    sudo ln -sfv libncurses.so /usr/lib/libcurses.so
    sudo ln -sfv libncursesw.a /usr/lib/libcursesw.a
    sudo ln -sfv libncurses.a /usr/lib/libcurses.a
    sudo mkdir -v       /usr/share/doc/ncurses-5.7
    sudo cp -v -R doc/* /usr/share/doc/ncurses-5.7
}

__ncurses()
{
    __ncurses-6.0
}

__neon-0.30.1()
{
    __dep opnessl gnutls

    __wget http://www.webdav.org/neon/neon-0.30.1.tar.gz
    __dcd neon-0.30.1
    __bld-common --enable-shared --with-ssl
}

__neon()
{
    __neon-0.30.1
}

__nettle-3.3()
{
    __dep openssl

    __wget https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz
    __dcd nettle-3.3
    __bld-common
    sudo chmod -v 755 /usr/lib/libhogweed.so.* /usr/lib/libnettle.so.*
}

__nettle()
{
    __nettle-3.3
}

__nftables()
{
    __dep libmnl libnftnl

    __git-clone git://git.netfilter.org/nftables
    __cd nftables
    __bld-common LDFLAGS=-lncurses
}

__nilfs-utils()
{
    __dep ""

    __git-clone git://github.com/nilfs-dev/nilfs-utils.git
    __common nilfs-utils
}

__npapi-sdk-0.27.2()
{
    __dep ""

    __wget https://bitbucket.org/mgorny/npapi-sdk/downloads/npapi-sdk-0.27.2.tar.bz2
    __dcd npapi-sdk-0.27.2
    __bld-common
}

__npapi-sdk()
{
    __npapi-sdk-0.27.2
}

__npth-1.2()
{
    __dep ""

    __wget ftp://ftp.gnupg.org/gcrypt/npth/npth-1.2.tar.bz2
    __dcd npth-1.2
    __bld-common
}

__npth()
{
    __npth-1.2
}


__nspr-4.10.10()
{
    __dep ""
    
    __wget http://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.10/src/nspr-4.10.10.tar.gz
    __dcd nspr-4.10.10
    cd nspr
    __bld-common --with-mozilla --with-pthreads
}

__nspr()
{
    __nspr-4.10.10
}

__nss-3.20.1()
{
    __dep nspr sqlite

    __wget http://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_20_1_RTM/src/nss-3.20.1.tar.gz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/nss-3.20.1-standalone-1.patch
    __dcd nss-3.20.1
    patch -Np1 -i $SRC_DIR/nss-3.20.1-standalone-1.patch
    cd nss
    make BUILD_OPT=1 NSPR_INCLUDE_DIR=/usr/include/nspr USE_SYSTEM_ZLIB=1 ZLIB_LIBS=-lz NSS_USE_SYSTEM_SQLITE=1

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
    __nss-3.20.1
}

__openjdk-1.8.0.66()
{
    __dep alsa-lib cpio cups unzip which xorg-lib zip certificate-authority giflib wget

    __wget http://hg.openjdk.java.net/jdk8u/jdk8u/archive/jdk8u66-b17.tar.bz2
    __wget http://anduin.linuxfromscratch.org/BLFS/OpenJDK/OpenJDK-1.8.0.66/jtreg-4.1-b12-420.tar.gz
    __wget http://icedtea.classpath.org/download/source/icedtea-web-1.6.1.tar.gz
    __decord jdk8u66-b17
    __cd jdk8u-jdk8u66-b17

#rem(){
    cat > subprojects.md5 << EOF
c99a63dfaf2b2f8cc549e65b790a2e7a  corba.tar.bz2
d15561707ce64419f36c18e4fba6cbbe  hotspot.tar.bz2
5b32371928b7aa67646b560e5c89dcde  jaxp.tar.bz2
05f7c3c91f3a6a38316bb4f406798b61  jaxws.tar.bz2
07223640c22b3ea75f3df81876622ba5  langtools.tar.bz2
6d737d1623b83a7acca8c18d0e08dd3d  jdk.tar.bz2
d5e109b7e2b2daab5874d650293321c8  nashorn.tar.bz2
EOF

    for subproject in corba hotspot jaxp jaxws langtools jdk nashorn; do
	wget -c http://hg.openjdk.java.net/jdk8u/jdk8u/${subproject}/archive/jdk8u66-b17.tar.bz2 -O ${subproject}.tar.bz2
    done

    md5sum -c subprojects.md5
#}

    for subproject in corba hotspot jaxp jaxws langtools jdk nashorn; do
	mkdir -pv ${subproject}
	tar -xf ${subproject}.tar.bz2 --strip-components=1 -C ${subproject}
    done

    tar -xf $SRC_DIR/jtreg-4.1-b12-420.tar.gz
#   unset JAVA_HOME
    chmod 755 configure
    ./configure --with-update-version=66 --with-build-number=b17 --with-milestone=BLFS --enable-unlimited-crypto --with-zlib=system --with-giflib=system --disable-ccache --with-boot-jdk="/opt/jdk1.8.0_66"
    __mk DEBUG_BINARIES=true -j 1 all
    find build/*/images/j2sdk-image -iname \*.diz -delete

    if [ -n "$DISPLAY" ]; then
	OLD_DISP=$DISPLAY
    fi

    export DISPLAY=:20
    nohup Xvfb $DISPLAY -fbdir $(pwd) -pixdepths 8 16 24 32 > Xvfb.out 2>&1
    echo $! > Xvfb.pid
    echo Waiting for Xvfb to initialize; sleep 1
    nohup twm -display $DISPLAY -f /dev/null > twm.out 2>&1
    echo $! > twm.pid
    echo Waiting for twm to initialize; sleep 1
    xhost +

    echo -e "
jdk_all = :jdk_core           \\
          :jdk_svc            \\
          :jdk_beans          \\
          :jdk_imageio        \\
          :jdk_sound          \\
          :jdk_sctp           \\
          com/sun/awt         \\
          javax/accessibility \\
          javax/print         \\
          sun/pisces          \\
          com/sun/java/swing" >> jdk/test/TEST.groups
    sed -e 's/all:.*jck.*/all: jtreg/' -e '/^JTREG /s@\$(JT_PLATFORM)/@@' -i langtools/test/Makefile

    JT_JAVA=$(type -p javac | sed 's@/bin.*@@')
    JT_HOME=$(pwd)/jtreg
    PRODUCT_HOME=$(echo $(pwd)/build/*/images/j2sdk-image)

   LANG=C make -k -C test JT_HOME=${JT_HOME} JT_JAVA=${JT_JAVA} PRODUCT_HOME=${PRODUCT_HOME} all
   LANG=C ${JT_HOME}/bin/jtreg -a -v:fail,error -dir:$(pwd)/hotspot/test -k:\!ignore -jdk:${PRODUCT_HOME} :jdk

   kill -9 `cat twm.pid`
   kill -9 `cat Xvfb.pid`
   rm -f Xvfb.out twm.out
   rm -f Xvfb.pid twm.pid
   if [ -n "$OLD_DISP" ]; then
       DISPLAY=$OLD_DISP
   fi

   sudo cp -RT build/*/images/j2sdk-image /opt/OpenJDK-1.8.0.66
   sudo chown -R root:root /opt/OpenJDK-1.8.0.66

   sudo ln -v -nsf OpenJDK-1.8.0.66 /opt/jdk

   tar -xf $SRC_DIR/icedtea-web-1.6.1.tar.gz icedtea-web-1.6.1/javaws.png --strip-components=1

   sudo mkdir -pv /usr/share/applications

   sudo sh 'cat > /usr/share/applications/openjdk-8-policytool.desktop << "EOF" &&
[Desktop Entry]
Name=OpenJDK Java Policy Tool
Name[pt_BR]=OpenJDK Java - Ferramenta de Política
Comment=OpenJDK Java Policy Tool
Comment[pt_BR]=OpenJDK Java - Ferramenta de Política
Exec=/opt/jdk/bin/policytool
Terminal=false
Type=Application
Icon=javaws
Categories=Settings;
EOF'

   install -v -Dm0644 javaws.png /usr/share/pixmaps/javaws.png

cat > /tmp/mkcacerts << "EOF"
#!/bin/sh
# Simple script to extract x509 certificates and create a JRE cacerts file.

function get_args()
    {
        if test -z "${1}" ; then
            showhelp
            exit 1
        fi

        while test -n "${1}" ; do
            case "${1}" in
                -f | --cafile)
                    check_arg $1 $2
                    CAFILE="${2}"
                    shift 2
                    ;;
                -d | --cadir)
                    check_arg $1 $2
                    CADIR="${2}"
                    shift 2
                    ;;
                -o | --outfile)
                    check_arg $1 $2
                    OUTFILE="${2}"
                    shift 2
                    ;;
                -k | --keytool)
                    check_arg $1 $2
                    KEYTOOL="${2}"
                    shift 2
                    ;;
                -s | --openssl)
                    check_arg $1 $2
                    OPENSSL="${2}"
                    shift 2
                    ;;
                -h | --help)
                    showhelp
                    exit 0
                    ;;
                *)
                    showhelp
                    exit 1
                    ;;
            esac
        done
    }

function check_arg()
    {
        echo "${2}" | grep -v "^-" > /dev/null
        if [ -z "$?" -o ! -n "$2" ]; then
            echo "Error:  $1 requires a valid argument."
            exit 1
        fi
    }

# The date binary is not reliable on 32bit systems for dates after 2038
function mydate()
    {
        local y=$( echo $1 | cut -d" " -f4 )
        local M=$( echo $1 | cut -d" " -f1 )
        local d=$( echo $1 | cut -d" " -f2 )
        local m

        if [ ${d} -lt 10 ]; then d="0${d}"; fi

        case $M in
            Jan) m="01";;
            Feb) m="02";;
            Mar) m="03";;
            Apr) m="04";;
            May) m="05";;
            Jun) m="06";;
            Jul) m="07";;
            Aug) m="08";;
            Sep) m="09";;
            Oct) m="10";;
            Nov) m="11";;
            Dec) m="12";;
        esac

        certdate="${y}${m}${d}"
    }

function showhelp()
    {
        echo "`basename ${0}` creates a valid cacerts file for use with IcedTea."
        echo ""
        echo "        -f  --cafile     The path to a file containing PEM"
        echo "                         formated CA certificates. May not be"
        echo "                         used with -d/--cadir."
        echo ""
        echo "        -d  --cadir      The path to a directory of PEM formatted"
        echo "                         CA certificates. May not be used with"
        echo "                         -f/--cafile."
        echo ""
        echo "        -o  --outfile    The path to the output file."
        echo ""
        echo "        -k  --keytool    The path to the java keytool utility."
        echo ""
        echo "        -s  --openssl    The path to the openssl utility."
        echo ""
        echo "        -h  --help       Show this help message and exit."
        echo ""
        echo ""
    }

# Initialize empty variables so that the shell does not pollute the script
CAFILE=""
CADIR=""
OUTFILE=""
OPENSSL=""
KEYTOOL=""
certdate=""
date=""
today=$( date +%Y%m%d )

# Process command line arguments
get_args ${@}

# Handle common errors
if test "${CAFILE}x" == "x" -a "${CADIR}x" == "x" ; then
    echo "ERROR!  You must provide an x509 certificate store!"
    echo "\'$(basename ${0}) --help\' for more info."
    echo ""
    exit 1
fi

if test "${CAFILE}x" != "x" -a "${CADIR}x" != "x" ; then
    echo "ERROR!  You cannot provide two x509 certificate stores!"
    echo "\'$(basename ${0}) --help\' for more info."
    echo ""
    exit 1
fi

if test "${KEYTOOL}x" == "x" ; then
    echo "ERROR!  You must provide a valid keytool program!"
    echo "\'$(basename ${0}) --help\' for more info."
    echo ""
    exit 1
fi

if test "${OPENSSL}x" == "x" ; then
    echo "ERROR!  You must provide a valid path to openssl!"
    echo "\'$(basename ${0}) --help\' for more info."
    echo ""
    exit 1
fi

if test "${OUTFILE}x" == "x" ; then
    echo "ERROR!  You must provide a valid output file!"
    echo "\'$(basename ${0}) --help\' for more info."
    echo ""
    exit 1
fi

# Get on with the work

# If using a CAFILE, split it into individual files in a temp directory
if test "${CAFILE}x" != "x" ; then
    TEMPDIR=`mktemp -d`
    CADIR="${TEMPDIR}"

    # Get a list of staring lines for each cert
    CERTLIST=`grep -n "^-----BEGIN" "${CAFILE}" | cut -d ":" -f 1`

    # Get a list of ending lines for each cert
    ENDCERTLIST=`grep -n "^-----END" "${CAFILE}" | cut -d ":" -f 1`

    # Start a loop
    for certbegin in `echo "${CERTLIST}"` ; do
        for certend in `echo "${ENDCERTLIST}"` ; do
            if test "${certend}" -gt "${certbegin}"; then
                break
            fi
        done
        sed -n "${certbegin},${certend}p" "${CAFILE}" > "${CADIR}/${certbegin}.pem"
        keyhash=`${OPENSSL} x509 -noout -in "${CADIR}/${certbegin}.pem" -hash`
        echo "Generated PEM file with hash:  ${keyhash}."
    done
fi

# Write the output file
for cert in `find "${CADIR}" -type f -name "*.pem" -o -name "*.crt"`
do

    # Make sure the certificate date is valid...
    date=$( ${OPENSSL} x509 -enddate -in "${cert}" -noout | sed 's/^notAfter=//' )
    mydate "${date}"
    if test "${certdate}" -lt "${today}" ; then
        echo "${cert} expired on ${certdate}! Skipping..."
        unset date certdate
        continue
    fi
    unset date certdate
    ls "${cert}"
    tempfile=`mktemp`
    certbegin=`grep -n "^-----BEGIN" "${cert}" | cut -d ":" -f 1`
    certend=`grep -n "^-----END" "${cert}" | cut -d ":" -f 1`
    sed -n "${certbegin},${certend}p" "${cert}" > "${tempfile}"
    echo yes | env LC_ALL=C "${KEYTOOL}" -import                     \
                                         -alias `basename "${cert}"` \
                                         -keystore "${OUTFILE}"      \
                                         -storepass 'changeit'       \
                                         -file "${tempfile}"
    rm "${tempfile}"
done

if test "${TEMPDIR}x" != "x" ; then
    rm -rf "${TEMPDIR}"
fi
exit 0
EOF

    sudo cp /tmp/mkcacerts /opt/jdk/bin/mkcacerts
    chmod -c 0755 /opt/jdk/bin/mkcacerts

    if [ -f /opt/jdk/jre/lib/security/cacerts ]; then
	sudo mv /opt/jdk/jre/lib/security/cacerts /opt/jdk/jre/lib/security/cacerts.bak
    fi
    /opt/jdk/bin/mkcacerts -d "/etc/ssl/certs/" -k "/opt/jdk/bin/keytool" -s "/usr/bin/openssl" -o "/opt/jdk/jre/lib/security/cacerts"
}

__openjdk()
{
    __openjdk-1.8.0.66
}

__openjpeg-1.5.2()
{
    __dep ""

    __wget http://downloads.sourceforge.net/openjpeg.mirror/openjpeg-1.5.2.tar.gz
    __dcd openjpeg-1.5.2
    autoreconf -f -i
    __bld-common --disable-static
}

__openjpeg()
{
    __openjpeg-1.5.2
}

__openldap-2.4.42()
{
    __dep berkeley-db

    __wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.42.tgz
    __dcd openldap-2.4.42
    autoconf
    __bld-common --disable-static --enable-dynamic --disable-debug --disable-slapd
}

__openldap()
{
    __openldap-2.4.42
}

__openmpi-1.10.0()
{
    __dep "?"

    __wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.0.tar.bz2
    __dcd openmpi-1.10.0
    __bld-common
}

__openmpi()
{
    __openmpi-1.10.0
}

__openscad-git()
{
    __dep "cmake flex"

    __git-clone https://github.com/openscad/openscad.git

    __cd openscad
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr .
     __mk
    __mkinst
}

__openscad()
{
    __openscad-git
}

__openssh-7.4p1()
{
    __dep openssl linux-pam

    __wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.4p1.tar.gz
    __decord openssh-7.4p1
    __cd openssh-7.4p1

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
    sudo install -v -m755 -d /usr/share/doc/openssh-7.4p1
    sudo install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-7.4p1
}

__openssh-git()
{
    __dep openssl linux-pam

    __git-clone git://anongit.mindrot.org/openssh.git
    __cd openssh

    sudo install -v -m700 -d /var/lib/sshd
    sudo chown -v root:sys /var/lib/sshd
    sudo groupadd -g 50 sshd
    sudo useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd

    __self-autogen
    $DIST_CLEAN
    __cfg --prefix=/usr --libexecdir=/usr/lib/openssh --sysconfdir=/etc/ssh --datadir=/usr/share/sshd \
        --with-md5-passwords --with-privsep-path=/var/lib/sshd

    $MAKE_CLEAN
    __mk
    __mkinst

    sudo install -v -m755 contrib/ssh-copy-id /usr/bin
    sudo install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
    sudo install -v -m755 -d /usr/share/doc/openssh
    sudo install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh
}

__openssh()
{
    __openssh-git
}

__openssl-1.0.2j()
{
    __dep ""

    __wget http://www.openssl.org/source/openssl-1.0.2j.tar.gz
    __dcd openssl-1.0.2j
    ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic
    make -j1
    sudo make uninstall
    sudo make install
    sudo rm /usr/lib/libssl.a

    sudo rm /usr/lib/libssl3.so
    sudo ln -s /usr/lib/libssl.so /usr/lib/libssl3.so
}

__openssl()
{
    __openssl-1.0.2j
}

__opus-1.1()
{
    __dep ""
    
    __wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
    __dcd opus-1.1
    __bld-common --disable-static
}

__opus()
{
    __opus-1.1
}

__p11-kit-git()
{
    __dep certificate-authority-certificates libtasn1 libffi

    __git-clone git://anongit.freedesktop.org/p11-glue/p11-kit
    __common p11-kit
}

__p11-kit()
{
    __p11-kit-git
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

__patch-git-install()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/patch.git
    __cd patch
    ./bootstrap
    __bld-common
}

__patch-install()
{
    __patch-git-install
}

__pcre-8.38()
{
    __dep ""

    __wget http://downloads.sourceforge.net/pcre/pcre-8.38.tar.bz2
    __dcd  pcre-8.38
    __bld-common --docdir=/usr/share/doc/pcre-8.38 --enable-unicode-properties \
                 --enable-pcre16 --enable-pcre32 \
                 --enable-pcregrep-libz --enable-pcregrep-libbz2 \
                 --enable-pcretest-libreadline
}

__pcre()
{
    __pcre-8.38
}

__perl-5.22.1()
{
    __dep ""

    __wget http://www.cpan.org/src/5.0/perl-5.22.1.tar.gz
    __dcd perl-5.22.1
    sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|" \
	-e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	    -e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|" \
	cpan/Compress-Raw-Zlib/config.in
    sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 \
        -Dpager="/usr/bin/less -isR" -Duseshrplib
    __mk
    __mkinst
}

__perl()
{
    __perl-5.22.1
}

__pixman()
{
    __dep ""

    __git-clone git://anongit.freedesktop.org/pixman
    __common pixman
}

__pkg-config()
{
    __dep ""

    __git-clone git://anongit.freedesktop.org/pkg-config
    __common pkg-config
}

__polkit()
{
    __dep "?"

    __git-clone git://anongit.freedesktop.org/polkit
    __cd polkit
    sudo groupadd -fg 28 polkitd
    sudo useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 28 -g polkitd -s /bin/false polkitd
    __bld-common --localstatedir=/var --disable-static --libexecdir=/usr/lib/polkit-1 --with-authfw=shadow --enable-libsystemd-login=yes
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

__poppler-0.37.0()
{
    __dep fontconfig openjpeg

    __wget http://poppler.freedesktop.org/poppler-0.37.0.tar.xz
    __dcd poppler-0.37.0
    __bld-common --disable-static --enable-xpdf-headers --with-testdatadir=$PWD/testfiles
    __poppler-data
}

__poppler()
{
    __poppler-0.37.0
}

__poppler-data-0.4.7()
{
    __dep poppler

    __wget http://poppler.freedesktop.org/poppler-data-0.4.7.tar.gz
    __dcd poppler-data-0.4.7
    __mk
    __mkinst
}

__poppler-data()
{
    __poppler-data-0.4.7
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

    __wget ftp://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz
    __dcd pth-2.0.7
    sed -i 's#$(LOBJS): Makefile#$(LOBJS): pth_p.h Makefile#' Makefile.in
    __bld-common
}

__pth()
{
    __pth-2.0.7
}

__pulseaudio-6.0()
{
    __dep json-c libsndfile

    __wget http://freedesktop.org/software/pulseaudio/releases/pulseaudio-6.0.tar.xz
    __dcd pulseaudio-6.0
    find . -name "Makefile.in" | xargs sed -i "s|(libdir)/@PACKAGE@|(libdir)/pulse|"
    __bld-common --localstatedir=/var --disable-bluez4 --disable-rpath --with-module-dir=/usr/lib/pulse/modules
}

__pulseaudio()
{
    __pulseaudio-6.0
}

__python-2.7.12()
{
    __dep expat libffi

    __wget http://www.python.org/ftp/python/2.7.12/Python-2.7.12.tar.xz
    __wget http://docs.python.org/ftp/python/doc/2.7.11/python-2.7.12-docs-html.tar.bz2
    __dcd Python-2.7.12
    __bld-common --enable-shared --with-system-expat --with-system-ffi --enable-unicode=ucs4
    sudo chmod -v 755 /usr/lib/libpython2.7.so.1.0
    sudo install -v -dm755 /usr/share/doc/python-2.7.12
    sudo tar --strip-components=1 -C /usr/share/doc/python-2.7.12 --no-same-owner -xvf $SRC_DIR/python-2.7.12-docs-html.tar.bz2
    sudo find /usr/share/doc/python-2.7.12 -type d -exec chmod 0755 {} \;
    sudo find /usr/share/doc/python-2.7.12 -type f -exec chmod 0644 {} \;
}

__python-27()
{
    __python-2.7.12
}

__python-3.5.1()
{
    __dep libffi

    __wget http://www.python.org/ftp/python/3.5.1/Python-3.5.1.tar.xz
    __wget http://docs.python.org/3/archives/python-3.5.1-docs-html.tar.bz2
    __dcd Python-3.5.1
    __bld-common CXX="/usr/bin/g++" --enable-shared --with-system-expat --with-system-ffi --without-ensurepip
    sudo chmod -v 755 /usr/lib/libpython3.5m.so
    sudo chmod -v 755 /usr/lib/libpython3.so
    sudo install -v -dm755 /usr/share/doc/python-3.5.1/html
    sudo tar --strip-components=1 --no-same-owner --no-same-permissions -C /usr/share/doc/python-3.5.1/html -xvf $SRC_DIR/python-3.5.1-docs-html.tar.bz2
}

__python-3()
{
    __python-3.5.1
}

__dbus-python-1.2.0()
{
    __dep dbus-glib python-27 python-3

    __wget http://dbus.freedesktop.org/releases/dbus-python/dbus-python-1.2.0.tar.gz
    __dcd dbus-python-1.2.0

    mkdir python2
    pushd python2
    PYTHON=/usr/bin/python2 ../configure --prefix=/usr --docdir=/usr/share/doc/dbus-python-1.2.0
    make
    popd

    mkdir python3
    pushd python3
    PYTHON=/usr/bin/python3 ../configure --prefix=/usr --docdir=/usr/share/doc/dbus-python-1.2.0
    make
    popd

    sudo make -C python2 install
    sudo make -C python3 install
}

__dbus-python()
{
    __dbus-python-1.2.0
}

__procps-ng-3.3.11()
{
    __dep ""

    __wget http://sourceforge.net/projects/procps-ng/files/Production/procps-ng-3.3.11.tar.xz
    __dcd procps-ng-3.3.11
    __cfg --prefix=/usr --exec-prefix= --libdir=/usr/lib --docdir=/usr/share/doc/procps-ng-3.3.11 --disable-static --disable-kill
    __mk
    __mkinst
   sudo  mv -v /usr/lib/libprocps.so.* /lib
   sudo ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so
}
__procps-ng()
{
    __procps-ng-3.3.11
}

__psmisc-22.21()
{
    __dep ""

    __wget http://downloads.sourceforge.net/project/psmisc/psmisc/psmisc-22.21.tar.gz
    __dcd psmisc-22.21
    __bld-common
   sudo  mv -v /usr/bin/fuser /bin
   sudo mv -v /usr/bin/killall /bin
}

__psmisc()
{
    __psmisc-22.21
}

__py2cairo-1.10.0()
{
    __dep python-27 cairo

    __wget http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2
    __dcd py2cairo-1.10.0
    ./waf configure --prefix=/usr
    ./waf build
    sudo ./waf install
}

__py2cairo()
{
    __py2cairo-1.10.0
}

__pycairo-1.10.0()
{
    __dep python-3 cairo

    __wget http://cairographics.org/releases/pycairo-1.10.0.tar.bz2
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/pycairo-1.10.0-waf_unpack-1.patch
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/pycairo-1.10.0-waf_python_3_4-1.patch
    __dcd pycairo-1.10.0
    patch -Np1 -i $SRC_DIR/pycairo-1.10.0-waf_unpack-1.patch
    wafdir=$(./waf unpack)
    pushd $wafdir
    patch -Np1 -i $SRC_DIR/pycairo-1.10.0-waf_python_3_4-1.patch
    popd
    unset wafdir
    PYTHON=/usr/bin/python3 ./waf configure --prefix=/usr
    ./waf build
    sudo ./waf install
}

__pycairo()
{
    __pycairo-1.10.0
}

__pygobject-2.28.6()
{
    __dep glib py2cairo gobject-introspection libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/pygobject-2.28.6.tar.xz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/pygobject-2.28.6-fixes-1.patch
    __dcd pygobject-2.28.6
    patch -Np1 -i $SRC_DIR/pygobject-2.28.6-fixes-1.patch
    ./configure --prefix=/usr
    make
    sudo make install
}

__pygobject-2()
{
    __pygobject-2.28.6
}

__pygobject-3.16.1()
{
    __dep gobject-introspection py2cairo pycairo

    __wget http://ftp.gnome.org/pub/gnome/sources/pygobject/3.16/pygobject-3.16.1.tar.xz
    __dcd pygobject-3.16.1
    sed -i '/test_out_glist/ i\    @unittest.expectedFailure' tests/test_atoms.py

    mkdir python2
    pushd python2
    ../configure --prefix=/usr --with-python=/usr/bin/python2
    make
    popd

    mkdir python3
    pushd python3
    ../configure --prefix=/usr --with-python=/usr/bin/python3
    make
    popd

    sudo make -C python2 install
    sudo make -C python3 install
}

__pygobject-3()
{
    __pygobject-3.16.1
}

__pygtk-2.24.0()
{
    __dep pygobject atk pango py2cairo gtk-2 libglade numpy libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2
    __dcd pygtk-2.24.0
    ./configure --prefix=/usr
    make
    sudo make install
}

__pygtk()
{
    __pygtk-2.24.0
}

__pyxdg-0.25()
{
    __dep python-27 python-3

    __wget http://people.freedesktop.org/~takluyver/pyxdg-0.25.tar.gz
    __dcd pyxdg-0.25
    sudo python2 setup.py install --optimize=1
    sudo python3 setup.py install --optimize=1
}

__pyxdg()
{
    __pyxdg-0.25
}

__pyxml-0.84()
{
    __dep python-27

    __wget http://downloads.sourceforge.net/pyxml/PyXML-0.8.4.tar.gz
    __dcd  PyXML-0.8.4
    sudo python2 setup.py install --optimize=1
}

__pyxml()
{
    __pyxml-0.84
}

__python-modules()
{
    __dbus-python
    __py2ciro
    __pycairo
    __pygobject-2
    __pygobject-3
    __pygtk
    __pyxdg
    __pyxml
    __mako
    __lxml
}

__qemu-3.0.0()
{
    __dep glib python27 sdl xorg alsa check curl mesalib

    __wget https://download.qemu.org/qemu-3.0.0.tar.xz
    __dcd qemu-3.0.0
    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --docdir=/usr/share/doc/qemu-3.0.0 \
	--audio-drv-list="alsa sdl" \
        --target-list="x86_64-softmmu arm-softmmu x86_64-linux-user arm-linux-user armeb-linux-user" \
	--enable-tools \
	--enable-kvm \
	--enable-libusb \
	--disable-xen \
	--disable-werror \
	--enable-sdl --with-sdlabi=2.0 \
	--enable-gtk --with-gtkabi=3.0 \
	--enable-opengl --enable-virglrenderer \
	--enable-spice \

    __mk
    __mkinst
}

__qemu-2.10.2()
{
    __dep glib python27 sdl xorg alsa check curl mesalib

    __wget https://download.qemu.org/qemu-2.10.2.tar.xz
    __dcd qemu-2.10.2
    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --docdir=/usr/share/doc/qemu-3.0.0 \
	--audio-drv-list="alsa sdl" \
        --target-list="x86_64-softmmu arm-softmmu x86_64-linux-user arm-linux-user armeb-linux-user" \
	--enable-kvm \
	--enable-libusb \
	--disable-xen \
	--disable-werror \
	--enable-sdl --with-sdlabi=2.0 \
	--enable-gtk --with-gtkabi=3.0 \
	--enable-opengl --enable-virglrenderer \

    __mk
    __mkinst
}

__qemu-2.4.1()
{
    __dep glib python27 sdl xorg alsa check curl mesalib

    __wget https://download.qemu.org/qemu-2.4.1.tar.xz
    __dcd qemu-2.4.1
    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --docdir=/usr/share/doc/qemu-3.0.0 \
	--audio-drv-list="alsa sdl" \
        --target-list="x86_64-softmmu arm-softmmu x86_64-linux-user arm-linux-user armeb-linux-user" \
	--enable-kvm \
	--enable-libusb \
	--disable-xen \
	--disable-werror \
	--enable-sdl --with-sdlabi=2.0 \
	--enable-gtk --with-gtkabi=3.0 \
	--enable-opengl \

    __mk
    __mkinst
}

__qemu-2.3.1()
{
    __dep glib python27 sdl xorg alsa check curl mesalib

    __wget https://download.qemu.org/qemu-2.3.1.tar.xz
    __dcd qemu-2.3.1
    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --docdir=/usr/share/doc/qemu-3.0.0 \
	--audio-drv-list="alsa sdl" \
        --target-list="x86_64-softmmu arm-softmmu x86_64-linux-user arm-linux-user armeb-linux-user" \
	--enable-kvm \
	--enable-libusb \
	--disable-xen \
	--disable-werror \
	--enable-sdl --with-sdlabi=2.0 \
	--enable-gtk --with-gtkabi=3.0 \
	--enable-opengl \

    __mk
    __mkinst
}

__qemu()
{
    __qemu-3.0.0
}

__raptor-2.0.15()
{
    __dep curl libxslt

    __wget http://download.librdf.org/source/raptor2-2.0.15.tar.gz
    __dcd raptor2-2.0.15
    __bld-common --disable-static
}

__raptor()
{
    __raptor-2.0.15
}

__rasqal-0.9.33()
{
    __dep raptor

    __wget http://download.librdf.org/source/rasqal-0.9.33.tar.gz
    __dcd rasqal-0.9.33
    __bld-common --disable-static
}

__rasqal()
{
    __rasqal-0.9.33
}

__ragel-6.9()
{
    __dep ""

    __wget http://www.colm.net/files/ragel/ragel-6.9.tar.gz
    __dcd ragel-6.9
    __bld-common
}

__ragel()
{
    __ragel-6.9
}

__readline()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/readline.git
    __cd readline
    grep -s "^char PC, *UP, *BC;" terminal.c
    if [ $? -ne 0 ]
    then
	echo "char PC, *UP, *BC;" >> terminal.c
    fi
    __bld-common --disable-static
}

__redland-1.0.17()
{
    __dep rasqal

    __wget http://download.librdf.org/source/redland-1.0.17.tar.gz
    __dcd redland-1.0.17
    __bld-common --disable-static
}

__redland()
{
    __redland-1.0.17
}

__rsync-3.1.2()
{
    __dep popt

    __wget https://www.samba.org/ftp/rsync/src/rsync-3.1.2.tar.gz
    __dcd rsync-3.1.2
    sudo  groupadd -g 48 rsyncd
    sudo useradd -c "rsyncd Daemon" -d /home/rsync -g rsyncd -s /bin/false -u 48 rsyncd
    __bld-common --without-included-zlib
    sudo install -v -m755 -d          /usr/share/doc/rsync-3.1.2/api
    sudo install -v -m644 dox/html/*  /usr/share/doc/rsync-3.1.2/api

    cat > /tmp/rsyncd.conf << "EOF"
# This is a basic rsync configuration file
# It exports a single module without user authentication.

motd file = /home/rsync/welcome.msg
use chroot = yes

[localhost]
    path = /home/rsync
    comment = Default rsync module
    read only = yes
    list = yes
    uid = rsyncd
    gid = rsyncd

EOF
    sudo mv {/tmp,/etc}/rsyncd.conf
}

__rsync()
{
    __rsync-3.1.2
}

__ruby-2.3.0()
{
    __dep ""

    __wget http://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.0.tar.xz
    __dcd ruby-2.3.0
    ./configure --prefix=/usr --enable-shared --docdir=/usr/share/doc/ruby-2.3.0
    __mk
    __mkinst
}

__ruby()
{
    __ruby-2.3.0
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

__screen-4.2.1()
{
    __dep "?"

    __wget http://ftp.gnu.org/gnu/screen/screen-4.2.1.tar.gz
    __dcd screen-4.2.1
    __bld-common
}

__screen()
{
    __screen-4.2.1
}

__sdl-1.2.15()
{
    __dep "?"

    __wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz
    __dcd SDL-1.2.15
    sed -i '/_XData32/s:register long:register _Xconst long:' src/video/x11/SDL_x11sym.h &&
    __bld-common --disable-static
}

__sdl1()
{
    __sdl-1.2.15
}

__sdl-2.0.3()
{
    __dep "?"

    __wget https://www.libsdl.org/release/SDL2-2.0.3.tar.gz
    __dcd SDL2-2.0.3
    __bld-common
}

__sdl2()
{
    __sdl-2.0.3
}

__sed-4.2.2()
{
    __dep ""

    __wget http://ftp.gnu.org/gnu/sed/sed-4.2.2.tar.bz2
    __dcd sed-4.2.2
    __bld-common
}

__sed()
{
    __sed-4.2.2
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

__sgml-common-0.6.3()
{
    __dep ""

    __wget ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/sgml-common-0.6.3-manpage-1.patch
    __dcd sgml-common-0.6.3
    patch -Np1 -i $SRC_DIR/sgml-common-0.6.3-manpage-1.patch
    autoreconf -f -i
    __bld-common
    __mkinst docdir=/usr/share/doc

    sudo install-catalog --add /etc/sgml/sgml-ent.cat /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
    sudo install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/sgml-ent.cat
}

__sgml-common()
{
    __sgml-common-0.6.3
}

__shadow-4.2.1()
{
    __dep linux-pam

    __wget http://pkg-shadow.alioth.debian.org/releases/shadow-4.2.1.tar.xz
    __dcd shadow-4.2.1
    
    sed -i 's/groups$(EXEEXT) //' src/Makefile.in
    find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
    sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@'  -e 's@/var/spool/mail@/var/mail@' etc/login.defs
    sed -i 's/1000/999/' etc/useradd
    ./configure --sysconfdir=/etc --with-group-name-max-length=32
    __mk
    __mkinst
    sudo mv -v /usr/bin/passwd /bin

    sudo install -v -m644 /etc/login.defs /etc/login.defs.orig
    for FUNCTION in FAIL_DELAY               \
                FAILLOG_ENAB             \
                LASTLOG_ENAB             \
                MAIL_CHECK_ENAB          \
                OBSCURE_CHECKS_ENAB      \
                PORTTIME_CHECKS_ENAB     \
                QUOTAS_ENAB              \
                CONSOLE MOTD_FILE        \
                FTMP_FILE NOLOGINS_FILE  \
                ENV_HZ PASS_MIN_LEN      \
                SU_WHEEL_ONLY            \
                CRACKLIB_DICTPATH        \
                PASS_CHANGE_TRIES        \
                PASS_ALWAYS_WARN         \
                CHFN_AUTH ENCRYPT_METHOD \
                ENVIRON_FILE
    do
	sudo sed -i "s/^${FUNCTION}/# &/" /etc/login.defs
    done

    mkdir /tmp/pam.d
    cat > /tmp/pam.d/login << "EOF"
# Begin /etc/pam.d/login

# Set failure delay before next prompt to 3 seconds
auth      optional    pam_faildelay.so  delay=3000000

# Check to make sure that the user is allowed to login
auth      requisite   pam_nologin.so

# Check to make sure that root is allowed to login
# Disabled by default. You will need to create /etc/securetty
# file for this module to function. See man 5 securetty.
#auth      required    pam_securetty.so

# Additional group memberships - disabled by default
#auth      optional    pam_group.so

# include the default auth settings
auth      include     system-auth

# check access for the user
account   required    pam_access.so

# include the default account settings
account   include     system-account

# Set default environment variables for the user
session   required    pam_env.so

# Set resource limits for the user
session   required    pam_limits.so

# Display date of last login - Disabled by default
#session   optional    pam_lastlog.so

# Display the message of the day - Disabled by default
#session   optional    pam_motd.so

# Check user's mail - Disabled by default
#session   optional    pam_mail.so      standard quiet

# include the default session and password settings
session   include     system-session
password  include     system-password

# End /etc/pam.d/login
EOF
    sudo mv {/tmp,/etc}/pam.d/login
    

    cat > /tmp/pam.d/passwd << "EOF"
# Begin /etc/pam.d/passwd

password  include     system-password

# End /etc/pam.d/passwd
EOF
    sudo mv {/tmp,/etc}/pam.d/passwd

    cat > /tmp/pam.d/su << "EOF"
# Begin /etc/pam.d/su

# always allow root
auth      sufficient  pam_rootok.so
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/su
EOF
    sudo mv {/tmp,/etc}/pam.d/su

    cat > /tmp/pam.d/chage << "EOF"
#Begin /etc/pam.d/chage

# always allow root
auth      sufficient  pam_rootok.so

# include system defaults for auth account and session
auth      include     system-auth
account   include     system-account
session   include     system-session

# Always permit for authentication updates
password  required    pam_permit.so

# End /etc/pam.d/chage
EOF
    sudo mv {/tmp,/etc}/pam.d/chage

    for PROGRAM in chfn chgpasswd chpasswd chsh groupadd groupdel  groupmems groupmod newusers useradd userdel usermod
    do
	sudo install -v -m644 /etc/pam.d/chage /etc/pam.d/${PROGRAM}
	sudo sed -i "s/chage/$PROGRAM/" /etc/pam.d/${PROGRAM}
    done

    [ -f /etc/login.access ] && sudo mv -v /etc/login.access{,.NOUSE}
    [ -f /etc/limits ] &&sudo  mv -v /etc/limits{,.NOUSE}
}

__shadow()
{
    __shadow-4.2.1
}

__libsigsegv-git()
{
    __dep ""

    __git-clone git://git.savannah.gnu.org/libsigsegv.git
    __cd libsigsegv
    __bld-common --enable-shared --disable-static
}

__libsigsegv()
{
    __libsigsegv-git
}

__soundtouch-1.9.2()
{
    __dep ""

    __wget http://www.surina.net/soundtouch/soundtouch-1.9.2.tar.gz
    __dcd soundtouch
    ./bootstrap
    __bld-common --docdir=/usr/share/doc/soundtouch-1.9.2
}

__soundtouch-git()
{
    __dep ""

    __svn-clone http://svn.code.sf.net/p/soundtouch/code/trunk soundtouch
    __cd soundtouch
    ./bootstrap
    __bld-common --docdir=/usr/share/doc/soundtouch
}

__soundtouch()
{
    __soundtouch-git
}

__source-code-pro-git()
{
    __dep "makeotf"

    __git-clone https://github.com/adobe-fonts/source-code-pro.git
    __cd source-code-pro
    ./build.sh
}

__source-code-pro()
{
    __source-code-pro-git
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

    ./autogen.sh
    ./configure CFLAGS='-g -O0 -ftrapv' --enable-compat-libs --enable-kdbus --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64
    
    __mk
    __mkinst
    sudo mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib
    sudo rm -rfv /usr/lib/rpm
    sudo systemd-machine-id-setup

    mkdir /tmp/pam.d
    cat >> /tmp/pam.d/system-session << "EOF"
# Begin Systemd addition
    
session   required    pam_loginuid.so
session   optional    pam_systemd.so

# End Systemd addition
EOF
    sudo mv {/tmp,/etc}/pam.d/system-session
    
    cat > /tmp/pam.d/systemd-user << "EOF"
# Begin /etc/pam.d/systemd-user

account  required pam_access.so
account  include  system-account

session  required pam_env.so
session  required pam_limits.so
session  include  system-session

auth     required pam_deny.so
password required pam_deny.so

# End /etc/pam.d/systemd-user
EOF
    sudo mv {/tmp,/etc}/pam.d/systemd-user
}

__systemd-ui()
{
    __dep systemd libgee

    __git-clone git://anongit.freedesktop.org/systemd/systemd-ui
    __common systemd-ui
}

__sqlite-3.14.2()
{
    __dep unzip

    __wget http://sqlite.org/2016/sqlite-autoconf-3140200.tar.gz
    __dcd sqlite-autoconf-3140200
    ./configure --prefix=/usr --sysconfdir=/etc \
	CFLAGS="-DSQLITE_ENABLE_FTS3=1 -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                -DSQLITE_ENABLE_UNLOCK_NOTIFY=1 -DSQLITE_SECURE_DELETE=1"
    __mk
    __mkinst
}

__sqlite()
{
    __sqlite-3.14.2
}

__svn-1.9.2()
{
    __dep apr-util sqlite openssl serf dbus

    __wget http://ftp.riken.jp/net/apache/subversion/subversion-1.9.2.tar.bz2
    __dcd subversion-1.9.2
    __bld-common --with-serf=/usr
}

__svn()
{
    __svn-1.9.2
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

__tar-1.28()
{
    __dep acl attr

    __wget http://ftp.gnu.org/gnu/tar/tar-1.28.tar.xz
    __dcd tar-1.28
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
    __tar-1.28
}

__tcl-8.6.6()
{
    __dep ""

    __wget http://downloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz
    __wget http://downloads.sourceforge.net/tcl/tcl8.6.6-html.tar.gz
    __decord tcl8.6.6-src
    __cd tcl8.6.6
    gzip -dc tcl8.6.6-html.tar.gz | tar xvf -

    export SRCDIR=`pwd`

    cd unix

    __bld-common --mandir=/usr/share/man $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
    __mk

    sed -e "s#$SRCDIR/unix#/usr/lib#" -e "s#$SRCDIR#/usr/include#" -i tclConfig.sh

    sed -e "s#$SRCDIR/unix/pkgs/tdbc1.0.4#/usr/lib/tdbc1.0.4#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.4/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/tdbc1.0.4/library#/usr/lib/tcl8.6#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.4#/usr/include#"            \
    -i pkgs/tdbc1.0.4/tdbcConfig.sh

    sed -e "s#$SRCDIR/unix/pkgs/itcl4.0.5#/usr/lib/itcl4.0.5#" \
    -e "s#$SRCDIR/pkgs/itcl4.0.5/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/itcl4.0.5#/usr/include#"            \
    -i pkgs/itcl4.0.5/itclConfig.sh

    unset SRCDIR

    __mkinst
    sudo make install-private-headers
    sudo ln -v -sf tclsh8.6 /usr/bin/tclsh
    sudo chmod -v 755 /usr/lib/libtcl8.6.so

    sudo mkdir -v -p /usr/share/doc/tcl-8.6.6
    sudo cp -v -r  ../html/* /usr/share/doc/tcl-8.6.6
}

__tcl()
{
    __tcl-8.6.6
}

__texinfo-5.2()
{
    __dep "?"

    __wget http://ftp.gnu.org/gnu/texinfo/texinfo-5.2.tar.xz
    __dcd texinfo-5.2
    __bld-common
    __mkinst TEXMF=/usr/share/texmf install-tex
}

__texinfo()
{
    __texinfo-5.2
}

__thunar-1.6.10()
{
    __dep exo libxfce4ui gnome-icon-theme libgudev libnotify xfce4-panel libexif tumbler

    __wget http://archive.xfce.org/src/xfce/thunar/1.6/Thunar-1.6.10.tar.bz2
    __dcd Thunar-1.6.10
    __bld-common
}

__thunar()
{
    __thunar-1.6.10
}

__thunar-volman-0.8.1()
{
    __dep exo libgudev libxfce4ui libnotify startup-notification polkit-gnome

    __wget http://archive.xfce.org/src/xfce/thunar-volman/0.8/thunar-volman-0.8.1.tar.bz2
    __dcd thunar-volman-0.8.1
    __bld-common
}

__thunar-volman()
{
    __thunar-volman-0.8.1
}

__tk-8.6.6()
{
    __dep tcl xorg

    __wget http://downloads.sourceforge.net/tcl/tk8.6.6-src.tar.gz
    __decord tk8.6.6-src
    __cd tk8.6.6

    cd unix
    __bld-common --mandir=/usr/share/man $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
    __mk

    sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
    -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    -i tkConfig.sh

    __mkinst
    sudo make install-private-headers
    sudo ln -v -sf wish8.6 /usr/bin/wish
    sudo chmod -v 755 /usr/lib/libtk8.6.so
}

__tk()
{
    __tk-8.6.6
}

__tumbler-0.1.31()
{
    __dep dbus-glib curl ffmpegthumbnailer freetype gdk-pixbuf gst-plugins-base gtk-doc libjpeg-turbo libgsf libopewnraw libpng poppler

    __wget http://archive.xfce.org/src/xfce/tumbler/0.1/tumbler-0.1.31.tar.bz2
    __dcd tumbler-0.1.31
    __bld-common
}

__tumbler()
{
    __tumbler-0.1.31
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

__iso-codes-3.59()
{
    __dep ""

    __wget http://pkg-isocodes.alioth.debian.org/downloads/iso-codes-3.59.tar.xz
    __dcd iso-codes-3.59
    __bld-common
}

__iso-codes()
{
    __iso-codes-3.59
}

__tomoyo-tools-2.5.0()
{
    __dep "?"

    cd ${BASE_DIR}
    wget -O $SRC_DIR/tomoyo-tools-2.5.0-20170102.tar.gz 'http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/tomoyo-tools-2.5.0-20170102.tar.gz'

    __decord tomoyo-tools-2.5.0-20170102
    __cd tomoyo-tools
    __mk USRLIBDIR=/lib
    __mkinst USRLIBDIR=/lib install
}

__tomoyo-tools()
{
    __tomoyo-tools-2.5.0
}

__unixodbc-2.3.2()
{
    __dep ""

    __wget http://www.unixodbc.org/unixODBC-2.3.2.tar.gz
    __dcd unixODBC-2.3.2
    ./configure --prefix=/usr --sysconfdir=/etc/unixODBC
    __mk
    __mkinst
}

__unixodbc()
{
    __unixodbc-2.3.2
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

__uri-1.69()
{
    __dep perl

    __wget http://www.cpan.org/authors/id/E/ET/ETHER/URI-1.69.tar.gz
    __dcd URI-1.69
    perl Makefile.PL
    __mk
    __mkinst
}

__uri()
{
    __uri-1.69
}

__usbutils-008()
{
    __dep libusb python-2

    __wget http://ftp.kernel.org/pub/linux/utils/usb/usbutils/usbutils-008.tar.xz
    __dcd usbutils-008
    sed -i '/^usbids/ s:usb.ids:hwdata/&:' lsusb.py
    __bld-common --datadir=/usr/share/hwdata
    sudo install -dm755 /usr/share/hwdata/
    sudo wget http://www.linux-usb.org/usb.ids -O /usr/share/hwdata/usb.ids
}

__usbutils()
{
    __usbutils-008
}

__util-linux()
{
    __dep "?"

    __git-clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
    __common util-linux
}

__vala-0.28.0()
{
    __dep glib dbus libxslt

    __wget http://ftp.gnome.org/pub/gnome/sources/vala/0.28/vala-0.28.0.tar.xz
    __dcd vala-0.28.0
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
    __vala-0.28.0
}

__valgrind-3.12.0()
{
    __dep boost llvm gdb openmp libxslt texlive
    
    __wget http://valgrind.org/downloads/valgrind-3.12.0.tar.bz2
    __dcd valgrind-3.12.0
    sed -e 's#|3.\*#&|4.\*#' -e 's/-mt//g' -e 's/2\.20)/2.2[0-9])/' -i configure
    sed -i 's|/doc/valgrind||' docs/Makefile.in
    __bld-common --datadir=/usr/share/doc/valgrind-3.12.0
}

__valgrind()
{
    __valgrind-3.12.0
}

__vc-git()
{
    __dep cmake

    __git-clone https://github.com/VcDevel/Vc.git
    __cd Vc
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTING=OFF ..
    __mk
    __mkinst
}

__vc()
{
    __vc-git
}

__vte()
{
    __dep gtk-introspection

    __git-clone git://git.gnome.org/vte
    __cd vte
    __bld-common --enable-introspection --enable-maintainer-mode
}

__wine-git()
{
    __dep "?"

    __git-clone git://source.winehq.org/git/wine.git
    __cd wine
    case $(uname -m) in
	x86_64) PKG_CONFIG_PATH="${PKG_CONFIG_PATH64}" USE_ARCH=64 ./configure --prefix=/usr --sysconfdir=/etc --enable-win64 ;;
	i686) ./configure --prefix=/usr --sysconfdir=/etc ;;
	*) echo "未サポートのCPUです" && exit ;;
    esac
    __mk
    __mkinst
}

__wine()
{
    __wine-git
}

__winetricks-git()
{
    __dep "?"

    __git-clone https://github.com/Winetricks/winetricks.git
    __cd winetricks
    __mk
    __mkinst
}

__winetricks()
{
    __winetricks-git
}

__wayland-git()
{
    __dep libffi libinput

    __git-clone git://anongit.freedesktop.org/wayland/wayland
    __cd wayland
    __bld-common --disable-static --disable-documentation
}

__wayland()
{
    __wayland-git
}

__wayland-protocols-git()
{
    __dep wayland

    __git-clone git://anongit.freedesktop.org/wayland/wayland-protocols
    __common wayland-protocols
}

__wayland-protocols()
{
    __wayland-protocols-git
}

__webkitgtk-2.14.3()
{
    __dep cairo cmake enchant gst-plugins-base gtk+2 gtk+3 icu libgudev libsecret libsoup libwebp mesa ruby sqlite which

    __wget http://webkitgtk.org/releases/webkitgtk-2.14.3.tar.xz
    __dcd webkitgtk-2.14.3
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_SKIP_RPATH=ON \
	  -DPORT=GTK -DLIB_INSTALL_DIR=/usr/lib -DUSE_LIBHYPHEN=OFF -DENABLE_MINIBROWSER=ON -Wno-dev ..
    __mk
    __mkinst
}

__webkitgtk()
{
    __webkitgtk-2.14.3
}

__weston-git()
{
    __dep wayland

    __git-clone git://anongit.freedesktop.org/wayland/weston
    __cd weston
    __bld-common --disable-static
}

__weston()
{
    __weston-git
}

__wget-1.16.3()
{
    __dep openssl

    __wget http://ftp.gnu.org/gnu/wget/wget-1.16.3.tar.xz
    __dcd wget-1.16.3
    __bld-common --with-ssl=openssl --with-openssl --disable-ipv6
}

### wget のビルド&インストールを行う
### 名前が __wget() だと common-func-2.sh 内定義の間数名と重複してしまい、誤動作してしまうため
__wget-install()
{
    __wget-1.16.3
}

__which-2.21()
{
    __wget ftp://ftp.gnu.org/gnu/which/which-2.21.tar.gz
    __dcd which-2.21
    __bld-common
}

__which()
{
    __which-2.21
}

__wpa_supplicant-2.2()
{
    __dep libnl openssl

    __wget http://hostap.epitest.fi/releases/wpa_supplicant-2.2.tar.gz
    __decord wpa_supplicant-2.2
    __cd wpa_supplicant-2.2/wpa_supplicant
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

__wpa_supplicant()
{
    __wpa_supplicant-2.2
}

__x264-20150908-2245()
{
    __dep yasm

    __wget http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20150908-2245-stable.tar.bz2
    __dcd x264-snapshot-20150908-2245-stable
    __bld-common --enable-shared --disable-cli
}

__x264()
{
    __x264-20150908-2245
}

__xf86-input-wacom-git()
{
    __git-clone git://git.code.sf.net/p/linuxwacom/xf86-input-wacom
    __common xf86-input-wacom
}

__xf86-input-wacom()
{
    __xf86-input-wacom-git
}

__xfce()
{
    __libxfce4util
    __xfconf
    __libxfce4ui
    __exo
    __garcon
    __gtk-xfce-engine
    __libwnck
    __xfce4-panel
    __xfce4-xkb-plugin
    __thunar
    __thunar-volman
    __tumbler
    __xfce4-appfinder
    __xfce4-power-manager
    __xfce4-settings
    __xfdesktop
    __xfwm4
    __xfce4-session
    __xfce4-screenshooter
}

__xfce4-appfinder-4.12.0()
{
    __dep garcon libxfce4ui

    __wget http://archive.xfce.org/src/xfce/xfce4-appfinder/4.12/xfce4-appfinder-4.12.0.tar.bz2
    __dcd xfce4-appfinder-4.12.0
    __bld-common
}

__xfce4-appfinder()
{
    __xfce4-appfinder-4.12.0
}

__xfce4-panel-4.12.0()
{
    __dep exo garacon libwnck libxfce4ui gtk-doc

    __wget http://archive.xfce.org/src/xfce/xfce4-panel/4.12/xfce4-panel-4.12.0.tar.bz2
    __dcd xfce4-panel-4.12.0
    __bld-common --enable-gtk3
}

__xfce4-panel()
{
    __xfce4-panel-4.12.0
}

__xfce4-power-manager-1.4.4()
{
    __dep libnotify upower xfce4-panel udisks

    __wget http://archive.xfce.org/src/xfce/xfce4-power-manager/1.4/xfce4-power-manager-1.4.4.tar.bz2
    __dcd xfce4-appfinder-4.12.0
    __bld-common
}

__xfce4-power-manager()
{
    __xfce4-power-manager-1.4.4
}

__xfce4-screenshooter-1.8.2()
{
    __dep "?"

    __wget http://archive.xfce.org/src/apps/xfce4-screenshooter/1.8/xfce4-screenshooter-1.8.2.tar.bz2
    __dcd xfce4-screenshooter-1.8.2
    __bld-common
}

__xfce4-screenshooter()
{
    __xfce4-screenshooter-1.8.2
}

__xfce4-session-4.12.1()
{
    __dep libwnck libxfce4ui which desktop-file-utils shared-mime-info xfdesktop

    __wget http://archive.xfce.org/src/xfce/xfce4-session/4.12/xfce4-session-4.12.1.tar.bz2
    __dcd xfce4-session-4.12.1
    __bld-common --disable-legacy-sm
}

__xfce4-session()
{
    __xfce4-session-4.12.1
}

__xfce4-settings-4.12.0()
{
    __dep exo garcon libxfce4ui gnome-icon-theme libcanberra libnotify libxklavier

    __wget http://archive.xfce.org/src/xfce/xfce4-settings/4.12/xfce4-settings-4.12.0.tar.bz2
    __dcd xfce4-settings-4.12.0
    __bld-common
}

__xfce4-settings()
{
    __xfce4-settings-4.12.0
}

__xfce4-xkb-plugin-0.7.1()
{
    __dep librsvg libxklavier xfce4-panel

    __wget http://archive.xfce.org/src/panel-plugins/xfce4-xkb-plugin/0.7/xfce4-xkb-plugin-0.7.1.tar.bz2
    __dcd xfce4-xkb-plugin-0.7.1
    __bld-common --disable-debug
}

__xfce4-xkb-plugin()
{
    __xfce4-xkb-plugin-0.7.1
}

__xfconf-4.12.0()
{
    __dep dbus-glib libxfce4util gtk-doc

    __wget http://archive.xfce.org/src/xfce/xfconf/4.12/xfconf-4.12.0.tar.bz2
    __dcd xfconf-4.12.0
    __bld-common
}

__xfconf()
{
    __xfconf-4.12.0
}

__xfdesktop-4.12.2()
{
    __dep exo libwnck libxfce4ui libnotify startup-notification thunar

    __wget http://archive.xfce.org/src/xfce/xfdesktop/4.12/xfdesktop-4.12.2.tar.bz2
    __dcd xfdesktop-4.12.2
    __bld-common
}

__xfdesktop()
{
    __xfdesktop-4.12.2
}

__xfwm4-4.12.3()
{
    __dep libwnck libxfce4ui libxfce4util startup-notification

    __wget http://archive.xfce.org/src/xfce/xfwm4/4.12/xfwm4-4.12.3.tar.bz2
    __dcd xfwm4-4.12.3
    __bld-common
}

__xfwm4()
{
    __xfwm4-4.12.3
}

__xml-parser-2.44()
{
    __dep ""

    __wget http://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44.tar.gz
    __dcd XML-Parser-2.44
    perl Makefile.PL
    make
    __mkinst
}

__xml-parser()
{
    __xml-parser-2.44
}

__xmlto-0.0.26()
{
    __dep docbook-xml docbook-xsl libxslt dblatex passivetex fop

    __wget https://fedorahosted.org/releases/x/m/xmlto/xmlto-0.0.26.tar.bz2
    __dcd xmlto-0.0.26
    __bld-common
}

__xmlto()
{
    __xmlto-0.0.26
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

__yasm-1.3.0()
{
    __dep python2 python3 cython

    __wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
    __dcd yasm-1.3.0
    __bld-common
}

__yasm()
{
    __yasm-1.3.0
}

__zip-3.0()
{
    __dep ""

    __wget http://downloads.sourceforge.net/infozip/zip30.tar.gz
    __dcd  zip30
    __mk -f unix/Makefile generic_gcc
    sudo make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install
}

__zip()
{
    __zip-3.0
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
