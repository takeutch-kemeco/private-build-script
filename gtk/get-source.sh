#!/bin/bash

__BASE_DIR__=$(pwd)

git clone git://github.com/atgreen/libffi.git

wget -c ftp://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz
gzip -dc pth-2.0.7.tar.gz | tar xvf -

git clone git://git.gnome.org/glib

git clone git://git.gnome.org/libsigc++2

git clone git://git.gnome.org/glibmm

git clone git://git.sv.gnu.org/freetype/freetype2.git

cvs -z3 -d:pserver:anonymous@expat.cvs.sourceforge.net:/cvsroot/expat co expat

git clone git://git.gnome.org/libxml2

git clone git://anongit.freedesktop.org/dbus/dbus

git clone git://anongit.freedesktop.org/dbus/dbus-glib

git clone git://anongit.freedesktop.org/fontconfig

svn co http://freeglut.svn.sourceforge.net/svnroot/freeglut/trunk/freeglut/freeglut freeglut
#wget -c http://prdownloads.sourceforge.net/freeglut/freeglut-2.8.0.tar.gz
#gzip -dc freeglut-2.8.0.tar.gz | tar xvf -

git clone git://libpng.git.sourceforge.net/gitroot/libpng/libpng

wget -c http://www.ijg.org/files/jpegsrc.v8d.tar.gz
gzip -dc jpegsrc.v8d.tar.gz | tar xvf -

wget -c ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.0.tar.gz
gzip -dc tiff-4.0.0.tar.gz | tar xvf -

git clone git://anongit.freedesktop.org/git/cairo

git clone git://git.cairographics.org/git/cairomm

git clone git://git.gnome.org/pango

git clone git://git.gnome.org/pangomm

git clone git://git.gnome.org/atk

git clone git://git.gnome.org/atkmm

git clone git://git.gnome.org/gdk-pixbuf

git clone git://git.gnome.org/gtk+ gtk+-2.24
cd gtk+-2.24
if [ $? -eq 0 ]
then
	git checkout 2.24.10
	git checkout -b 2.24.10
	git branch --set-upstream 2.24.10 origin/gtk-2-24
fi
cd $__BASE_DIR__

git clone git://git.gnome.org/gtk+

git clone git://git.gnome.org/gtkmm

wget -c ftp://ftp.gnome.org/pub/gnome/sources/gtkmm/2.24/gtkmm-2.24.2.tar.xz
xz -dc gtkmm-2.24.2.tar.xz | tar xvf -
ln -s gtkmm-2.24.2 gtkmm-2.24

git clone git://git.gnome.org/gobject-introspection

git clone git://git.gnome.org/mm-common

