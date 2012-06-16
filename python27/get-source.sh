#!/bin/bash

wget -c ftp://mirror.ovh.net/gentoo-distfiles/distfiles/PyXML-0.8.4.tar.gz
gzip -dc PyXML-0.8.4.tar.gz | tar xvf -
ln -s PyXML-0.8.4 pyxml

wget -c http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2
bzip2 -dc py2cairo-1.10.0.tar.bz2 | tar xvf -
ln -s py2cairo-1.10.0 py2cairo

wget -c ftp://ftp.gnome.org/pub/gnome/sources/pygobject/2.28/pygobject-2.28.6.tar.xz
xz -dc pygobject-2.28.6.tar.xz | tar xvf -
ln -s pygobject-2.28.6 pygobject

#wget -c ftp://ftp.gnome.org/pub/gnome/sources/pygobject/3.2/pygobject-3.2.2.tar.xz
#xz -dc pygobject-3.2.2.tar.xz | tar xvf -
#ln -s pygobject-3.2.2 pygobject

wget -c ftp://ftp.gnome.org/pub/gnome/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2
bzip2 -dc pygtk-2.24.0.tar.bz2 | tar xvf -
ln -s pygtk-2.24.0 pygtk

git clone git://github.com/numpy/numpy.git numpy

git clone git://github.com/scipy/scipy.git scipy

wget -c ftp://ftp.gnome.org/pub/gnome/sources/pygtksourceview/2.10/pygtksourceview-2.10.1.tar.bz2
bzip2 -dc pygtksourceview-2.10.1.tar.bz2 | tar xvf -
ln -s pygtksourceview-2.10.1 pygtksourceview

wget -c ftp://ftp.gnome.org/pub/gnome/sources/pyatspi/2.4/pyatspi-2.4.0.tar.xz
xz -dc pyatspi-2.4.0.tar.xz | tar xvf -
ln -s pyatspi-2.4.0 pyatspi

wget -c http://www.freedesktop.org/~lanius/pyxdg-0.19.tar.gz
gzip -dc pyxdg-0.19.tar.gz | tar xvf -
ln -s pyxdg-0.19 pyxdg

wget -c http://archive.ipython.org/release/0.12/ipython-0.12.tar.gz
gzip -dc ipython-0.12.tar.gz | tar xvf -
ln -s ipython-0.12 ipython

