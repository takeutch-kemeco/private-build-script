#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ./__common-func.sh

__gmp()
{
    __wget ftp://ftp.gmplib.org/pub/gmp/gmp-5.1.3.tar.xz
    __dcd gmp-5.1.3

    __cfg --prefix=/usr --enable-cxx
    __mk
    __mk install
    ldconfig

    mkdir -v /usr/share/doc/gmp-5.1.3
    cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp-5.1.3
}

__mpfr()
{
    __wget http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.xz
    __dcd mpfr-3.1.2

    __cfg --prefix=/usr --enable-thread-safe --docdir=/usr/share/doc/mpfr-3.1.2
    __mk
    __mk install
    ldconfig

    __mk html
    __mk install-html
}

__mpc()
{
    __wget http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz
    __dcd mpc-1.0.1

    __cfg --prefix=/usr
    __mk
    __mk install
    ldconfig
}

__gcc()
{
    __wget http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
    __dcd gcc-4.8.2

    __cfg --prefix=/usr --libexecdir=/usr/lib --enable-shared \
          --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu \
          --enable-languages=c,c++,fortran --disable-multilib \
          --disable-bootstrap --with-system-zlib

#         --disable-libstdcxx-pch --enable-c99 --enable-cloog-backend=isl \
#         --enable-long-long

    __mk
    __mk install
    rm /usr/lib/libstdc++.so.6.0.18-gdb.py
    ldconfig
}

__gdb()
{
    __wget http://ftp.jaist.ac.jp/pub/GNU/gdb/gdb-7.6.2.tar.bz2
    __dcd gdb-7.6.2

    __cfg --prefix=/usr --disable-werror
    __mk
    __mk install
    ldconfig
}

__all()
{
#__rem(){
    __gmp
    __mpfr
    __mpc
    __gcc
    __gdb
}

$@

