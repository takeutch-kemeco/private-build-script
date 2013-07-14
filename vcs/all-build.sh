#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=""
#DIST_CLEAN="make distclean"

#MAKE_CLEAN=""
MAKE_CLEAN="make clean"

. ./__common-func.sh

__bld-common()
{
        $DIST_CLEAN
        ./autogen.sh
        __cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib $@

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

__openssh()
{
        __wget ftp://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/openssh-6.2p2.tar.gz
        __decord openssh-6.2p2
        __cd openssh-6.2p2

	install -v -m700 -d /var/lib/sshd
	chown -v root:sys /var/lib/sshd
	groupadd -g 50 sshd
	useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd

        $DIST_CLEAN
	__cfg --prefix=/usr --sysconfdir=/etc/ssh --datadir=/usr/share/sshd --with-md5-passwords --with-privsep-path=/var/lib/sshd

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/doc/openssh-6.2
	install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-6.2
}

__git()
{
        git clone git://git.kernel.org/pub/scm/git/git.git
        __cd git
        git pull

        $MAKE_CLEAN
	__mk prefix=/usr
	__mk prefix=/usr install
	ldconfig
}

__hg()
{
        hg clone http://selenic.com/hg
	__cd hg
        hg pull
        hg update

	python setup.py install
}

__apr1()
{
        __wget ftp://ftp.riken.jp/net/apache//apr/apr-1.4.8.tar.bz2
        __dcd apr-1.4.8

	__bld-common --with-installbuilddir=/usr/lib/apr-1 --with-devrandom=/dev/random
}

__apr1-util()
{
        __wget ftp://ftp.riken.jp/net/apache//apr/apr-util-1.5.2.tar.bz2
        __dcd apr-util-1.5.2

        $DIST_CLEAN
        __bld-common --with-apr=$PREFIX/bin/apr-1-config --with-gdbm=/usr --with-berkeley-db=/usr --with-openssl=/usr
}

__neon()
{
        __wget http://www.webdav.org/neon/neon-0.29.6.tar.gz
        __dcd neon-0.29.6

        __bld-common --enable-shared --with-ssl=openssl --with-libxml2 --with-expat
}

__serf()
{
        __wget http://serf.googlecode.com/files/serf-1.2.1.tar.bz2
        __dcd serf-1.2.1

	./buildconf
	__bld-common --with-apr=/usr/bin/apr-1-config
}

__sqlite3()
{
        __wget http://www.sqlite.org/2013/sqlite-autoconf-3071700.tar.gz
        __dcd sqlite-autoconf-3071700

	__bld-common --enable-threadsafe --enable-dynamic-extensions
}


__svn()
{
        __wget http://archive.apache.org/dist/subversion/subversion-1.8.0.tar.bz2
        __dcd subversion-1.8.0

        __bld-common --with-serf=/usr
}

__all()
{
#__rem(){
        __openssh
        __git
        __hg
        __apr1
        __apr1-util
        __neon
        __serf
        __sqlite3
        __svn
}

$@
