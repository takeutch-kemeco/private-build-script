#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__autogen()
{
    aclocal --install
    libtoolize
    automake -acf
    autoheader
    autoconf
}

__libarchive()
{
    __git-clone https://github.com/libarchive/libarchive.git
    __cd libarchive
    __autogen
    __bld-common
}

__cmake()
{
    __git-clone git://cmake.org/cmake.git
    __cd cmake
    ./bootstrap
    __bld-common-simple --system-libs --mandir=/share/man --docdir=/share/doc/cmake
}

__talloc()
{
    __wget http://samba.org/ftp/talloc/talloc-2.1.0.tar.gz
    __dcd talloc-2.1.0
    __bld_common
}

__popt()
{
    __wget http://rpm5.org/files/popt/popt-1.16.tar.gz
    __dcd popt-1.16
    __bld-common
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

__nettle()
{
    __git-clone git://git.lysator.liu.se/nettle/nettle.git
    __cd nettle
    __bld-common --disable-documentation
    sudo chmod -v 755 /usr/lib/libhogweed.so.* /usr/lib/libnettle.so.*
}

__tetex() {
	echo
}

__tomoyo-tools()
{
    cd ${BASE_DIR}
    wget -O ${SRC_DIR}/tomoyo-tools-2.5.0-20140105.tar.gz 'http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/tomoyo-tools-2.5.0-20140105.tar.gz'

    __decord tomoyo-tools-2.5.0-20140105
    __cd tomoyo-tools
    __mk USRLIBDIR=/lib
    sudo make USRLIBDIR=/lib install
}

__freeglut()
{
    __svn-clone http://svn.code.sf.net/p/freeglut/code/trunk/freeglut/freeglut freeglut
    __cd freeglut
    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    __mk
    __mkinst
}

__sudo()
{
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

__curl()
{
    __git-clone git://github.com/bagder/curl.git
    __cd curl
    ./buildconf
    __bld-common --enable-threaded-resolver --with-ca-path=/etc/ssl/certs
}

__all()
{
    __libarchive
    __cmake
    __talloc
    __popt
    __gc
    __nettle
    __tetex
    __tomoyo-tools
    __freeglut
    __sudo
    __curl
}

$@

