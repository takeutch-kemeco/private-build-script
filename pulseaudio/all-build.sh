#!/bin/bash

BASE_DIR=$(pwd)

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__libsndfile()
{
    __git-clone https://github.com/erikd/libsndfile.git
    __common libsndfile
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
    __libsndfile
    __pulseaudio
}

$@

