#!/bin/bash

__BASE_DIR__=$(pwd)

cd $__BASE_DIR__/man-pages
git pull

cd $__BASE_DIR__/zlib
git pull

#file

#cd $__BASE_DIR__/binutils
#cvs update


cd $__BASE_DIR__/gnulib
git pull

cd $__BASE_DIR__/sed
ln -s $__BASE_DIR__/gnulib $__BASE_DIR__/sed/gnulib

#wget -c http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz
#gzip -dc bzip2-1.0.6.tar.gz | tar xvf -
#mv bzip2-1.0.6 bzip2

#wget -c ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
#gzip -dc ncurses-5.9.tar.gz | tar xvf -
#mv ncurses-5.9 ncurses

cd $__BASE_DIR__/util-linux-ng
git pull

cd $__BASE_DIR__/psmisc
git pull

cd $__BASE_DIR__/e2fsprogs
git pull

cd $__BASE_DIR__/rsync
git pull

cd $__BASE_DIR__/coreutils
git pull

cd $__BASE_DIR__/iana-etc
git pull

cd $__BASE_DIR__/m4
git pull

cd $__BASE_DIR__/bison
git pull

cd $__BASE_DIR__/procps
git pull

cd $__BASE_DIR__/grep
git pull

cd $__BASE_DIR__/readline
git pull

cd $__BASE_DIR__/bash
git pull

cd $__BASE_DIR__/libtool
git pull

cd $__BASE_DIR__/gdbm
git pull

cd $__BASE_DIR__/inetutils
git pull

cd $__BASE_DIR__/perl
git pull

cd $__BASE_DIR__/autoconf
git pull

cd $__BASE_DIR__/automake
git pull

cd $__BASE_DIR__/diffutils
git pull

cd $__BASE_DIR__/gawk
git pull

cd $__BASE_DIR__/findutils
git pull

#flex

cd $__BASE_DIR__/gettext
git pull

cd $__BASE_DIR__/groff
git pull

#grub

cd $__BASE_DIR__/gzip
git pull

cd $__BASE_DIR__/iproute2
git pull

cd $__BASE_DIR__/kbd
git pull

#less

cd $__BASE_DIR__/libpipeline
git pull

cd $__BASE_DIR__/make
git pull

cd $__BASE_DIR__/xz
git pull

###git clone git://gitorious.org/baserock-morphs/man-db.git

cd $__BASE_DIR__/module-init-tools
git pull

#patch

cd $__BASE_DIR__/psmisc
git pull

cd $__BASE_DIR__/shadow
git pull

###git clone git://git.infodrom.org/infodrom/sysklogd
#wget -c http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
#gzip -dc sysklogd-1.5.tar.gz | tar xvf -
#mv sysklogd-1.5 sysklogd

#Sysvinit

cd $__BASE_DIR__/tar
git pull

#texinfo

cd $__BASE_DIR__/udev
git pull

#vim

