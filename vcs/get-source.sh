#!/bin/bash

#git
git clone git://git.kernel.org/pub/scm/git/git.git
git clone git://git.gnome.org/gitg

#hg
hg clone http://selenic.com/hg

#apr1
wget -c http://ftp.riken.jp/net/apache/apr/apr-1.4.6.tar.bz2
bzip2 -dc apr-1.4.6.tar.bz2 | tar xvf -
ln -s apr-1.4.6 apr1

wget -c http://ftp.riken.jp/net/apache//apr/apr-util-1.4.1.tar.bz2
bzip2 -dc apr-util-1.4.1.tar.bz2 | tar xvf -
ln -s apr-util-1.4.1 apr1-util

#apr2
svn co http://svn.apache.org/repos/asf/apr/apr/trunk/ apr2

#serf
svn checkout http://serf.googlecode.com/svn/trunk/ serf

#svn
wget -c http://ftp.kddilabs.jp/infosystems/apache/subversion/subversion-1.7.5.tar.bz2
bzip2 -dc subversion-1.7.5.tar.bz2 | tar xvf -
ln -s subversion-1.7.5 svn

#sqlite
wget -c http://www.sqlite.org/sqlite-autoconf-3071201.tar.gz
gzip -dc sqlite-autoconf-3071201.tar.gz | tar xvf -
ln -s sqlite-autoconf-3071201 sqlite3

#gdbm
git clone git://git.gnu.org.ua/gdbm.git

#cvs
cvs -z3 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/cvs co ccvs
cvs -z3 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/cvs co diffutils

#bazaar
wget -c https://launchpadlibrarian.net/96882740/bzr-2.6b1.tar.gz
gzip -dc bzr-2.6b1.tar.gz | tar xvf -
ln -s bzr-2.6b1 bzr

