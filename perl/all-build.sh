#!/bin/bash

SRC=$(pwd)

. ../common-func/__common-func.sh

__perl()
{
	__cd $SRC/perl

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

__common()
{
	__dcd $1
	perl Makefile.PL
	__mk
#	__mk test
	__mk install
}

__xmlparser()
{
	__common $SRC/XML-Parser-2.41
}

__xmlsimple()
{
	__common $SRC/XML-Simple-2.18
}

__uri()
{
	__common $SRC/URI-1.60
}

__all()
{
#__rem(){
__perl

__xmlparser
__xmlsimple
__uri
}

$@

