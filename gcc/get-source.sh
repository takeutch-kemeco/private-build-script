#!/bin/bash

wget -c http://zlib.net/zlib-1.2.5.tar.bz2
bzip2 -dc zlib-1.2.5.tar.bz2 | tar xvf -

svn checkout svn://scm.gforge.inria.fr/svn/mpfr/trunk mpfr

hg clone http://gmplib.org:8000/gmp gmp

svn checkout svn://scm.gforge.inria.fr/svn/mpc/trunk mpc

#svn checkout svn://gcc.gnu.org/svn/gcc/trunk gcc
wget -c ftp://ftp.dti.ad.jp/pub/lang/gcc/releases/gcc-4.6.2/gcc-core-4.6.2.tar.bz2
bzip2 -dc gcc-core-4.6.2.tar.bz2 | tar xvf -
wget -c ftp://ftp.dti.ad.jp/pub/lang/gcc/releases/gcc-4.6.2/gcc-g++-4.6.2.tar.bz2
bzip2 -dc gcc-g++-4.6.2.tar.bz2 | tar xvf -
mv gcc-4.6.2 gcc

wget -c ftp://sourceware.org/pub/gdb/releases/gdb-7.3.1.tar.bz2
bzip2 -dc gdb-7.3.1.tar.bz2 | tar xvf -
mv gdb-7.3.1 gdb

