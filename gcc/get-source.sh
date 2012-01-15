#!/bin/bash

wget -c http://zlib.net/zlib-1.2.5.tar.bz2
bzip2 -dc zlib-1.2.5.tar.bz2 | tar xvf -

svn checkout svn://scm.gforge.inria.fr/svn/mpfr/trunk mpfr

hg clone http://gmplib.org:8000/gmp gmp

svn checkout svn://scm.gforge.inria.fr/svn/mpc/trunk mpc

svn checkout svn://gcc.gnu.org/svn/gcc/trunk gcc
