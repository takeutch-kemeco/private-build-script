#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__perl-5.20.0()
{
    __dep ""

    __wget http://www.cpan.org/src/5.0/perl-5.20.0.tar.gz
    __dcd perl-5.20.0
    sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|" \
	-e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	    -e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|" \
	cpan/Compress-Raw-Zlib/config.in
    sh Configure -des -Dprefix=/usr -Dvendorprefix=/usr -Dman1dir=/usr/share/man/man1 -Dman3dir=/usr/share/man/man3 \
        -Dpager="/usr/bin/less -isR" -Duseshrplib
    __mk
    __mkinst
}

__perl()
{
    __perl-5.20.0
}

__perl-module-archive-zip-1.37()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/P/PH/PHRED/Archive-Zip-1.37.tar.gz
    __pl-common Archive-Zip-1.37
}

__perl-module-archive-zip()
{
    __perl-module-archive-zip-1.37
}

__perl-module-html-tagset-3.20()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/HTML-Tagset-3.20.tar.gz
    __pl-common HTML-Tagset-3.20
}

__perl-module-html-tagset()
{
    __perl-module-html-tagset-3.20
}

__perl-module-encode-locale-1.03()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/Encode-Locale-1.03.tar.gz
    __pl-common Encode-Locale-1.03
}

__perl-module-encode-locale()
{
    __perl-module-encode-locale-1.03
}

__perl-module-uri-1.60()
{
    __dep perl

    __wget http://www.cpan.org/authors/id/G/GA/GAAS/URI-1.60.tar.gz
    __pl-common URI-1.60
}

__perl-module-uri()
{
    __dep perl

    __perl-module-uri-1.60
}

__perl-module-html-parser-3.71()
{
    __dep perl perl-module-html-tagset cicle-child:perl-module-libwww-perl

    __wget http://www.cpan.org/authors/id/G/GA/GAAS/HTML-Parser-3.71.tar.gz
    __pl-common HTML-Parser-3.71
}

__perl-module-html-parser()
{
    __perl-module-html-parser-3.71
}

__perl-module-http-data-6.02()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Date-6.02.tar.gz
    __pl-common HTTP-Date-6.02
}

__perl-module-http-data()
{
    __perl-module-http-data-6.02
}

__perl-module-io-html-1.00()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/C/CJ/CJM/IO-HTML-1.00.tar.gz
    __pl-common IO-HTML-1.00
}

__perl-module-io-html()
{
    __perl-module-io-html-1.00
}

__perl-module-lwp-mediatypes-6.02()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/LWP-MediaTypes-6.02.tar.gz
    __pl-common LWP-MediaTypes-6.02
}

__perl-module-lwp-mediatypes()
{
    __perl-module-lwp-mediatypes-6.02
}

__perl-module-http-message-6.06()
{
    __dep perl perl-module-http-data perl-module-io-html perl-module-lwp-mediatypes

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Message-6.06.tar.gz
    __pl-common HTTP-Message-6.06
}

__perl-module-http-message()
{
    __perl-module-http-message-6.06
}

__perl-module-http-cookies-6.01()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Cookies-6.01.tar.gz
    __pl-common HTTP-Cookies-6.01
}

__perl-module-http-cookies()
{
    __perl-module-http-cookies-6.01
}

__perl-module-http-negotiate-6.01()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Negotiate-6.01.tar.gz
    __pl-common HTTP-Negotiate-6.01
}

__perl-module-http-negotiate()
{
    __perl-module-http-negotiate-6.01
}

__perl-module-net-http-6.06()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/Net-HTTP-6.06.tar.gz
    __pl-common Net-HTTP-6.06
}

__perl-module-net-http()
{
    __perl-module-net-http-6.06
}

__perl-module-www-robotrules-6.02()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/WWW-RobotRules-6.02.tar.gz
    __pl-common WWW-RobotRules-6.02
}

__perl-module-www-robotrules()
{
    __perl-module-www-robotrules-6.02
}

__perl-module-http-daemon-6.01()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTTP-Daemon-6.01.tar.gz
    __pl-common HTTP-Daemon-6.01
}

__perl-module-http-daemon()
{
    __perl-module-http-daemon-6.01
}

__perl-module-file-listing-6.04()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/File-Listing-6.04.tar.gz
    __pl-common File-Listing-6.04
}

__perl-module-file-listing()
{
    __perl-module-file-listing-6.04
}

__perl-module-libwww-perl-6.05()
{
    __dep perl perl-module-encode-locale perl-module-html-form perl-module-http-cookies \
        perl-module-http-negotiate perl-module-net-http perl-module-www-robotrules \
        perl-module-http-daemon perl-module-file-listing

    __wget http://cpan.org/authors/id/G/GA/GAAS/libwww-perl-6.05.tar.gz
    __pl-common libwww-perl-6.05
}

__perl-module-html-form-6.03()
{
    __dep perl perl-module-uri perl-module-html-parser perl-module-http-message

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/HTML-Form-6.03.tar.gz
    __pl-common HTML-Form-6.03
}

__perl-module-html-form()
{
    __perl-module-html-form-6.03
}

__perl-module-libwww-perl()
{
    __perl-module-libwww-perl-6.05
}

__perl-module-net-ssleay-1.58()
{
    __dep perl openssl

    __wget http://search.cpan.org/CPAN/authors/id/M/MI/MIKEM/Net-SSLeay-1.58.tar.gz
    __pl-common Net-SSLeay-1.58
}

__perl-module-net-ssleay()
{
    __perl-module-net-ssleay-1.58
}

__perl-module-io-socket-ssl-0.97()
{
    __dep perl openssl perl-module-net-ssleay

    __wget http://search.cpan.org/CPAN/authors/id/B/BE/BEHROOZI/IO-Socket-SSL-0.97.tar.gz
    __pl-common IO-Socket-SSL-0.97
}

__perl-module-io-socket-ssl()
{
    __perl-module-io-socket-ssl-0.97
}

__perl-module-mozilla-ca-20130114()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/A/AB/ABH/Mozilla-CA-20130114.tar.gz
    __pl-common Mozilla-CA-20130114
}

__perl-module-mozilla-ca()
{
    __perl-module-mozilla-ca-20130114
}

__perl-module-lwp-protocol-https-6.04()
{
    __dep perl openssl perl-module-libwww-perl perl-module-io-socket-ssl perl-module-mozilla-ca

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/LWP-Protocol-https-6.04.tar.gz
    __pl-common LWP-Protocol-https-6.04
}

__perl-module-lwp-protocol-https()
{
    __perl-module-lwp-protocol-https-6.04
}

__perl-module-socket6-0.25()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/U/UM/UMEMOTO/Socket6-0.25.tar.gz
    __pl-common Socket6-0.25
}

__perl-module-socket6()
{
    __perl-module-socket6-0.25
}

__perl-module-io-socket-inet-1.25()
{
    __dep perl perl-module-socket6

    __wget http://search.cpan.org/CPAN/authors/id/G/GB/GBARR/IO-1.25.tar.gz
    __pl-common IO-1.25
}

__perl-module-io-socket-inet()
{
    __perl-module-io-socket-inet-1.25
}

__perl-module-digest-hmac-1.03()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GA/GAAS/Digest-HMAC-1.03.tar.gz
    __pl-common Digest-HMAC-1.03
}

__perl-module-digest-hmac()
{
    __perl-module-digest-hmac-1.03
}

__perl-module-net-dns-0.74()
{
    __dep perl perl-module-digest-hmac perl-module-io-socket-inet

    __wget http://www.cpan.org/authors/id/N/NL/NLNETLABS/Net-DNS-0.74.tar.gz
    __pl-common Net-DNS-0.74
}

__perl-module-net-dns()
{
    __perl-module-net-dns-0.74
}

__perl-module-sgmlspm-1.1()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz
    __pl-common SGMLSpm-1.1
}

__perl-module-sgmlspm()
{
    __perl-module-sgmlspm-1.1
}

__perl-module-xml-parser-2.41()
{
    __dep perl expat perl-module-libwww-perl

    __wget http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/XML-Parser-2.41.tar.gz
    __pl-common XML-Parser-2.41
}

__perl-module-xml-parser()
{
    __perl-module-xml-parser-2.41
}

__perl-module-tie-ixhash-1.23()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/C/CH/CHORNY/Tie-IxHash-1.23.tar.gz
    __pl-common Tie-IxHash-1.23
}

__perl-module-tie-ixhash()
{
    __perl-module-tie-ixhash-1.23
}

__perl-module-xml-libxml-2.0110()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0110.tar.gz
    __pl-common XML-LibXML-2.0110
}

__perl-module-xml-libxml()
{
    __perl-module-xml-libxml-2.0110
}

__perl-module-xml-sax-base-1.08()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/G/GR/GRANTM/XML-SAX-Base-1.08.tar.gz
    __pl-common XML-SAX-Base-1.08
}

__perl-module-xml-sax-base()
{
    __perl-module-xml-sax-base-1.08
}

__perl-module-xml-namespacesupport-1.11()
{
    __dep perl

    __wget http://search.cpan.org/CPAN/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.11.tar.gz
    __pl-common XML-NamespaceSupport-1.11
}

__perl-module-xml-namespacesupport()
{
    __perl-module-xml-namespacesupport-1.11
}

__perl-module-xml-sax-0.99()
{
    __dep perl perl-module-xml-namespace-support perl-module-xml-sax-base

    __wget http://search.cpan.org/CPAN/authors/id/G/GR/GRANTM/XML-SAX-0.99.tar.gz
    __pl-common XML-SAX-0.99
}

__perl-module-xml-sax()
{
    __perl-module-xml-sax-0.99
}

__perl-module-xml-sax-expat-0.51()
{
    __dep perl perl-module-xml-parser perl-module-xml-sax

    __wget http://search.cpan.org/CPAN/authors/id/B/BJ/BJOERN/XML-SAX-Expat-0.51.tar.gz
    __pl-common XML-SAX-Expat-0.51
}

__perl-module-xml-sax-expat()
{
    __perl-module-xml-sax-expat-0.51
}

__perl-module-xml-simple-2.20()
{
    __dep perl perl-module-xml-sax perl-module-xml-sax-expat perl-module-xml-libxml perl-module-tie-ixhash

    __wget http://cpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.20.tar.gz
    __pl-common XML-Simple-2.20
}

__perl-module-xml-simple()
{
    __perl-module-xml-simple-2.20
}

__perl-modules()
{
    __perl-module-archive-zip
    __perl-module-html-tagset
    __perl-module-encode-locale
    __perl-module-uri
    __perl-module-http-data
    __perl-module-io-html
    __perl-module-lwp-mediatypes
    __perl-module-http-message
    __perl-module-http-cookies
    __perl-module-http-negotiate
    __perl-module-net-http
    __perl-module-www-robotrules
    __perl-module-http-daemon
    __perl-module-file-listing
    __perl-module-net-ssleay
    __perl-module-io-socket-ssl
    __perl-module-mozilla-ca
    __perl-module-socket6
    __perl-module-io-socket-inet
    __perl-module-digest-hmac
    __perl-module-net-dns
    __perl-module-sgmlspm
    __perl-module-tie-ixhash

    ### xml-sax 系を先にした方が良いのかもしれないが
    __perl-module-xml-libxml

    __perl-module-xml-sax-base
    __perl-module-xml-namespacesupport
    __perl-module-xml-sax

    ### 1回目 (libwww-perlと循環依存)
    __perl-module-html-parser

    __perl-module-html-form
    __perl-module-libwww-perl

    ### 2回目 (libwww-perlと循環依存)
    __perl-module-html-parser

    __perl-module-lwp-protocol-https
    __perl-module-xml-parser
    __perl-module-xml-sax-expat
    __perl-module-xml-simple
}

__all()
{
    __perl
    __perl-modules
}

$@

