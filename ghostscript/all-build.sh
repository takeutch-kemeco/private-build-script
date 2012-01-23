#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"
IPA_FONT_DIR="/usr/share/fonts/IPAfont00303"

lcms()
{
	cd $BASE_DIR/Little-CMS
	autoreconf -vfi
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

ghostscript()
{
        cd $BASE_DIR/ghostpdl/gs

cat > $BASE_DIR/ghostpdl/gs/Resource/Init/cidfmap << "EOF"
/Adobe-Japan1 << /FileType /TrueType /Path (ipag.ttf) /CSI [(Japan1) 6] >> ;
EOF

        ./autogen.sh --prefix=$PREFIX
        $MAKE_CLEAN
        make
        make install
	make so
	make soinstall
        ldconfig

	mkdir -p $PREFIX/share/ghostscript/fonts
	cp $IPA_FONT_DIR/*.ttf $PREFIX/share/ghostscript/fonts

        cd $BASE_DIR
}

#lcms
ghostscript

