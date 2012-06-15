#!/bin/bash

#gc
wget -c http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc-7.2.tar.gz
gzip -dc gc-7.2.tar.gz | tar xvf -
ln -s gc-7.2 gc

#popt
wget -c http://rpm5.org/files/popt/popt-1.16.tar.gz
gzip -dc popt-1.16.tar.gz | tar xvf -
ln -s popt-1.16 popt

