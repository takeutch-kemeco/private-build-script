#!/bin/bash

git clone git://github.com/madler/zlib.git

svn checkout svn://scm.gforge.inria.fr/svn/mpfr/trunk mpfr

hg clone http://gmplib.org:8000/gmp gmp

svn checkout svn://scm.gforge.inria.fr/svn/mpc/trunk mpc

svn checkout svn://gcc.gnu.org/svn/gcc/trunk gcc

cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/web/gdb co gdb

