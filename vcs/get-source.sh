#!/bin/bash

git clone git://git.kernel.org/pub/scm/git/git.git

hg clone http://selenic.com/hg

#apr1
wget -c http://ftp.riken.jp/net/apache/apr/apr-1.4.5.tar.bz2
bzip2 -dc apr-1.4.5.tar.bz2 | tar xvf -

wget -c http://ftp.riken.jp/net/apache//apr/apr-util-1.4.1.tar.bz2
bzip2 -dc apr-util-1.4.1.tar.bz2 | tar xvf -

####apr2
###svn co http://svn.apache.org/repos/asf/apr/apr/trunk/ apr

svn checkout http://serf.googlecode.com/svn/trunk/ serf

wget -c http://www.sqlite.org/sqlite-autoconf-3071000.tar.gz
gzip -dc sqlite-autoconf-3071000.tar.gz | tar xvf -

#svn co http://svn.apache.org/repos/asf/subversion/trunk svn
wget -c http://ftp.riken.jp/net/apache/subversion/subversion-1.7.2.tar.bz2
bzip2 -dc subversion-1.7.2.tar.bz2 | tar xvf -

wget -c ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.10.tar.gz
gzip -dc gdbm-1.10.tar.gz | tar xvf -

wget -c http://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2
bzip2 -dc cvs-1.11.23.tar.bz2 | tar xvf -

