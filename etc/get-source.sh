#!/bin/bash

#gc
wget -c http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc-7.2.tar.gz
gzip -dc gc-7.2.tar.gz | tar xvf -
ln -s gc-7.2 gc

#popt
wget -c http://rpm5.org/files/popt/popt-1.16.tar.gz
gzip -dc popt-1.16.tar.gz | tar xvf -
ln -s popt-1.16 popt

#nettle
wget -c http://www.lysator.liu.se/~nisse/archive/nettle-2.4.tar.gz
gzip -dc nettle-2.4.tar.gz | tar xvf -
ln -s nettle-2.4 nettle

