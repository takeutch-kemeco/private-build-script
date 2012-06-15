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

