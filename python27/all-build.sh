#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__python27() {
	__cd $BASE_DIR/python27
	./configure --prefix=/usr --enable-shared --with-system-ffi
	__mk
	__mk install
	ldconfig
}

__pmk() {
	python setup.py $@
	if [ $? -ne 0 ]
	then
		__err
	fi
}

__pyxml() {
	__cd $BASE_DIR/pyxml
	__pmk build
	
	__pmk install --prefix=/usr	
	install -v -m644 doc/man/xmlproc_*.1 /usr/share/man/man1
	install -v -m755 -d /usr/share/doc/PyXML-0.8.4
	cp -v -R doc demo test /usr/share/doc/PyXML-0.8.4
	install -v -m644 README* /usr/share/doc/PyXML-0.8.4

#	__cd test
#	python regrtest.py
}

__py2cairo() {
	__cd $BASE_DIR/py2cairo
	./waf configure --prefix=/usr
	./waf build
	./waf install
}

__pygobject2() {
	__cd $BASE_DIR/pygobject2
	patch -p1 < ../pygobject-2.28.6-introspection-1.patch
	./configure --prefix=/usr
	__mk
	__mk install
}

__pygobject3() {
	__cd $BASE_DIR/pygobject3
	./configure --prefix=/usr
	__mk
	__mk install
}
__numpy() {
	__cd $BASE_DIR/numpy
	__pmk install --prefix=/usr	
}

__scipy() {
	__cd $BASE_DIR/scipy
	__pmk install --prefix=/usr	
}

__pygtk() {
	__cd $BASE_DIR/pygtk
	./configure --prefix=/usr
	__mk
	__mk install
}

__pygtksourceview() {
	__cd $BASE_DIR/pygtksourceview
	./configure --prefix=/usr
	__mk
	__mk install
}

__pyatspi() {
	__cd $BASE_DIR/pyatspi
	./configure --prefix=/usr
	__mk
	__mk install
}

__pyxdg() {
	__cd $BASE_DIR/pyxdg
	__pmk install --prefix=/usr
}

__ipython() {
	__cd $BASE_DIR/ipython
	__pmk install --prefix=/usr
}

__matplotlib() {
	__cd $BASE_DIR/matplotlib
	__pmk install --prefix=/usr
}

#__rem(){
__python27

__pyxml
__py2cairo
__pygobject2
__pygobject3
__numpy
__scipy
__matplotlib
__pygtk
###__pygtksourceview
__pyatspi
__pyxdg
__ipython

