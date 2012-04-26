#!/bin/bash

git clone git://github.com/mkerrisk/man-pages.git

git clone git://github.com/madler/zlib.git

#file

cvs -z 9 -d :pserver:anoncvs@sourceware.org:/cvs/src co binutils
mv src binutils

git clone git://git.savannah.gnu.org/gnulib.git
git clone git://git.savannah.gnu.org/sed.git
ln -s gnulib sed/gnulib

wget -c http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz
gzip -dc bzip2-1.0.6.tar.gz | tar xvf -
mv bzip2-1.0.6 bzip2

wget -c ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
gzip -dc ncurses-5.9.tar.gz | tar xvf -
mv ncurses-5.9 ncurses

git clone git://gitorious.org/util-linux-ng/util-linux-ng.git

git clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc

git clone git://e2fsprogs.git.sourceforge.net/gitroot/e2fsprogs/e2fsprogs

git clone git://git.samba.org/rsync.git

git clone git://git.sv.gnu.org/coreutils

git clone git://gitorious.org/baserock-morphs/iana-etc.git

git clone git://git.sv.gnu.org/m4.git

git clone git://git.sv.gnu.org/bison.git

git clone git://gitorious.org/procps/procps.git

git clone git://git.savannah.gnu.org/grep.git

git clone git://git.savannah.gnu.org/readline.git

git clone git://git.savannah.gnu.org/bash.git

git clone git://git.savannah.gnu.org/libtool.git

git clone git://git.sv.gnu.org/gdbm.git

git clone git://git.sv.gnu.org/inetutils.git

git clone git://perl5.git.perl.org/perl.git perl

git clone git://git.sv.gnu.org/autoconf.git

git clone git://git.sv.gnu.org/automake.git

git clone git://git.sv.gnu.org/diffutils.git

git clone git://git.sv.gnu.org/gawk.git

git clone git://git.sv.gnu.org/findutils.git

#flex

git clone git://git.sv.gnu.org/gettext.git

git clone git://gitorious.org/baserock-morphs/groff.git

#grub

git clone git://git.sv.gnu.org/gzip.git

git clone git://github.com/shemminger/iproute2.git

git clone git://github.com/gooselinux/kbd.git

#less

git clone git://gitorious.org/baserock-morphs/libpipeline.git

git clone git://git.savannah.gnu.org/make.git

git clone http://git.tukaani.org/xz.git

###git clone git://gitorious.org/baserock-morphs/man-db.git

git clone git://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git

#patch

git clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc

git clone git://github.com/TheBreeze/shadow.git

###git clone git://git.infodrom.org/infodrom/sysklogd
wget -c http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
gzip -dc sysklogd-1.5.tar.gz | tar xvf -
mv sysklogd-1.5 sysklogd

#Sysvinit

git clone git://git.savannah.gnu.org/tar.git

#texinfo

git clone git://vcs.progress-linux.org/packages/udev.git

#vim

