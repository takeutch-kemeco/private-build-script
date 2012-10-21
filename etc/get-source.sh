#!/bin/bash

#talloc
wget -c http://samba.org/ftp/talloc/talloc-2.0.7.tar.gz
gzip -dc talloc-2.0.7.tar.gz | tar xvf -
ln -s talloc-2.0.7 talloc

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

#tetex
#wget -c ftp://tug.ctan.org/tex-archive/systems/unix/teTeX/3.0/distrib/tetex-src-3.0.tar.gz
#gzip -dc tetex-src-3.0.tar.gz | tar xvf -
#wget -c ftp://tug.ctan.org/tex-archive/systems/unix/teTeX/3.0/distrib/tetex-texmf-3.0.tar.gz
#wget -c ftp://tug.ctan.org/tex-archive/systems/unix/teTeX/3.0/distrib/tetex-texmfsrc-3.0.tar.gz
#wget -c http://anduin.linuxfromscratch.org/sources/BLFS/6.3/t/tetex-cm-super.tar.bz2
#wget -c ftp://anduin.linuxfromscratch.org/BLFS/6.3/t/tetex-cm-super.tar.bz2

###pcre
wget -c ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.30.tar.bz2
bzip2 -dc pcre-8.30.tar.bz2 | tar xvf -
ln -s pcre-8.30 pcre

###tcl
wget -c http://prdownloads.sourceforge.net/tcl/tcl8.6b2-src.tar.gz 
gzip -dc tcl8.6b2-src.tar.gz | tar xvf -
ln -s tcl8.6b2 tcl

###tk
wget -c http://prdownloads.sourceforge.net/tcl/tk8.6b2-src.tar.gz
gzip -dc tk8.6b2-src.tar.gz | tar xvf -
ln -s tk8.6b2 tk

wget -c -O tomoyo-tools-2.5.0-20120414.tar.gz 'http://sourceforge.jp/frs/redir.php?m=jaist&f=/tomoyo/53357/tomoyo-tools-2.5.0-20120414.tar.gz'
gzip -dc tomoyo-tools-2.5.0-20120414.tar.gz | tar xvf -

git clone git://git.fedorahosted.org/linux-pam.git

###freeglut
svn co http://freeglut.svn.sourceforge.net/svnroot/freeglut freeglut.svn
rm freeglut
ln -s freeglut.svn/trunk/freeglut/freeglut

