#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="__mk clean"
IPA_FONT_DIR="/usr/share/fonts/IPAfont00303"

. ../common-func/__common-func.sh

lcms()
{
	__cd $BASE_DIR/Little-CMS
	autoreconf -vfi
	./configure --prefix=$PREFIX --sysconfdir=/etc
	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

ghostscript()
{
        __cd $BASE_DIR/ghostpdl/gs

cat > $BASE_DIR/ghostpdl/gs/Resource/Init/cidfmap << "EOF"
/Adobe-Japan1 << /FileType /TrueType /Path (ipag.ttf) /CSI [(Japan1) 6] >> ;
EOF

        ./autogen.sh --prefix=$PREFIX --sysconfdir=/etc
        $MAKE_CLEAN
        __mk
        __mk install
	__mk so
	__mk soinstall
        ldconfig

	mkdir -p $PREFIX/share/ghostscript/fonts
	cp $IPA_FONT_DIR/*.ttf $PREFIX/share/ghostscript/fonts
}

lcms
ghostscript

