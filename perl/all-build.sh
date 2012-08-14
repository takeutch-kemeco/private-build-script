#!/bin/bash

SRC=$(pwd)

. ../common-func/__common-func.sh

__perl()
{
	__dcd $SRC/perl-5.16.0

	echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

	sed -i  -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|"           \
       		-e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
       		-e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|"         \
    		cpan/Compress-Raw-Zlib/config.in

	sh Configure -des -Dprefix=/usr		\
        	-Dvendorprefix=/usr           	\
        	-Dman1dir=/usr/share/man/man1 	\
        	-Dman3dir=/usr/share/man/man3 	\
        	-Dpager="/usr/bin/less -isR"  	\
        	-Duseshrplib

	sed -i '/test-installation.pl/d' Makefile

	__mk

#	__mk -k test

	__mk install

	ldconfig
}

__perl

