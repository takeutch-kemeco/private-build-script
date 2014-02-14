#!/bin/bash

BASE_DIR=$(pwd)

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__libcap()
{
    __wget http://ftp.de.debian.org/debian/pool/main/libc/libcap2/libcap2_2.22.orig.tar.gz
    __decord libcap2_2.22
    __cd libcap-2.22
    __mk
    __mkinst RAISE_SETFCAP=no prefix=/usr
    sudo chmod -v 755 /usr/lib/libcap.so
    sudo mv -v /usr/lib/libcap.so.* /lib
    sudo ln -sfv ../../lib/libcap.so.2 /usr/lib/libcap.so
}

__libsndfile()
{
    __git-clone https://github.com/erikd/libsndfile.git
    __cd libsndfile
    __self-autogen
    __bld-common
}

__pulseaudio()
{
    __git-clone http://anongit.freedesktop.org/git/pulseaudio/pulseaudio.git
    __cd pulseaudio

    sudo groupadd -g 58 pulse
    sudo groupadd -g 59 pulse-access
    sudo useradd -c "Pulseaudio User" -d /var/run/pulse -g pulse -s /bin/false -u 58 pulse
    sudo usermod -a -G audio pulse

    find . -name "Makefile.in" | xargs sed -i "s|(libdir)/@PACKAGE@|(libdir)/pulse|"

    __bld-common --localstatedir=/var --libexecdir=/usr/lib \
                 --with-module-dir=/usr/lib/pulse/modules --without-caps
}

__all()
{
### __libcap
    __libsndfile
    __pulseaudio
}

$@

