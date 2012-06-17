#!/bin/bash

#libunistring
wget -c http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.3.tar.gz
gzip -dc libunistring-0.9.3.tar.gz | tar xvf -
ln -s libunistring-0.9.3 libunistring

#git clone git://git.savannah.gnu.org/gnutls.git
wget -c http://ftp.gnu.org/gnu/gnutls/gnutls-3.0.19.tar.xz
xz -dc gnutls-3.0.19.tar.xz | tar xvf -
ln -s gnutls-3.0.19 gnutls

git clone git://git.sv.gnu.org/guile.git

git clone git://git.savannah.gnu.org/gperf.git

#ed
wget -c http://ftp.gnu.org/gnu/ed/ed-1.6.tar.gz
gzip -dc ed-1.6.tar.gz | tar xvf -
ln -s ed-1.6 ed

git clone git://git.sv.gnu.org/acl.git

git clone git://git.savannah.nongnu.org/attr.git

#indent
#cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/web/indent co indent
wget -c http://ftp.jaist.ac.jp/pub/GNU/indent/indent-2.2.10.tar.gz
gzip -dc indent-2.2.10.tar.gz | tar xvf -
ln -s indent-2.2.10 indent

