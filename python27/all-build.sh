#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

__python27() {
	cd $BASE_DIR/python27
	./configure --prefix=$PREFIX --enable-shared
	make
	make install
	ldconfig
}

__pyxml() {
	cd $BASE_DIR/pyxml
	python setup.py build
	
	python setup.py install --prefix=/usr	
	install -v -m644 doc/man/xmlproc_*.1 /usr/share/man/man1
	install -v -m755 -d /usr/share/doc/PyXML-0.8.4
	cp -v -R doc demo test /usr/share/doc/PyXML-0.8.4
	install -v -m644 README* /usr/share/doc/PyXML-0.8.4

#	cd test
#	python regrtest.py
}

__py2cairo() {
	cd $BASE_DIR/py2cairo
	./waf configure --prefix=/usr
	./waf build
	./waf install
}

__pygobject2() {
	cd $BASE_DIR/pygobject2
	patch -p1 < ../pygobject-2.28.6-introspection-1.patch
	./configure --prefix=/usr
	make

	make install
}

__pygobject3() {
	cd $BASE_DIR/pygobject3
	./configure --prefix=/usr
	make

	make install
}
__numpy() {
	cd $BASE_DIR/numpy
	python setup.py install --prefix=/usr	
}

__scipy() {
	cd $BASE_DIR/scipy
	python setup.py install --prefix=/usr	
}

__pygtk() {
	cd $BASE_DIR/pygtk
	./configure --prefix=/usr
	make
	make install
}

__pygtksourceview() {
	cd $BASE_DIR/pygtksourceview
	./configure --prefix=/usr
	make
	make install
}

__pyatspi() {
	cd $BASE_DIR/pyatspi
	./configure --prefix=/usr
	make
	make install
}

__pyxdg() {
	cd $BASE_DIR/pyxdg
	python setup.py install --prefix=/usr
}

__ipython() {
	cd $BASE_DIR/ipython
	python setup.py install --prefix=/usr
}

__tcl() {
	$BASE_DIR/tcl
	tar -xf ../tcl8.5.11-html.tar.gz --strip-components=1
	cd unix
	./configure --prefix=$PREFIX \
           	--enable-threads \
            	--mandir=$PREFIX/share/man
	make

sed -e "s@^\(TCL_SRC_DIR='\).*@\1/usr/include'@" \
    -e "/TCL_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    -i tclConfig.sh

	make install
	make install-private-headers
	ln -v -sf tclsh8.5 /usr/bin/tclsh
	chmod -v 755 /usr/lib/libtcl8.5.so

	mkdir -v -p /usr/share/doc/tcl-8.5.11
	cp -v -r  ../html/* /usr/share/doc/tcl-8.5.11

	ldconfig
}

__tk() {
	cd $BASE_DIR/tk
	cd unix
	./configure --prefix=$PREFIX \
            	--enable-threads \
            	--mandir=$PREFIX/share/man
	make
sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
    -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    -i tkConfig.sh

	make install
	make install-private-headers
	ln -v -sf wish8.5 /usr/bin/wish
	chmod -v 755 /usr/lib/libtk8.5.so

	ldconfig
}

__test__() {

	exit
}
#__test__

__python27
__tcl
__tk

__pyxml
__py2cairo
__pygobject2
__pygobject3
__numpy
__scipy
__pygtk
__pygtksourceview
__pyatspi
__pyxdg
__ipython

