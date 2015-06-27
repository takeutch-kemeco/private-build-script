#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

### ビルド時にシステムメモリーを使いきらないように制限する
__init-build-group

__init-env()
{
    XORG_PREFIX=/usr
    XORG_CONFIG="--prefix=/usr --sysconfdir=/etc \
                 --mandir=/usr/share/man --localstatedir=/var"
    PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/share/pkgconfig:/lib/pkgconfig"
    ln -s /usr/lib /usr/lib64
}

__x-bld-common()
{
    __bld-common ${XORG_CONFIG} $@
}

__x-common()
{
    __cd $1
    __x-bld-common
}

__util-macros()
{
    __git-clone git://anongit.freedesktop.org/xorg/util/macros util-macros
    __x-common util-macros
}

### >>> xorg-proto members

__bigreqsproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/bigreqsproto
    __x-common bigreqsproto
}

__compositeproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/compositeproto
    __x-common compositeproto
}

__damageproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/damageproto
    __x-common damageproto
}

__dmxproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/dmxproto
    __x-common  dmxproto
}

__dri2proto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/dri2proto
    __x-common dri2proto
}

__dri3proto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/dri3proto
    __x-common dri3proto
}

__fixesproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/fixesproto
    __x-common fixesproto
}

__fontsproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/fontsproto
    __x-common fontsproto
}

__glamor()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/glamor
    __x-common glamor
}

__glproto()
{
    __git-clone git://people.freedesktop.org/xorg/proto/glproto
    __x-common glproto
}

__inputproto()
{
    __git-clone git://people.freedesktop.org/xorg/proto/inputproto
    __x-common inputproto
}

__kbproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/kbproto
    __x-common kbproto
}

__presentproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/presentproto
    __x-common presentproto
}       

__randrproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/randrproto
    __x-common randrproto
}

__recordproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/recordproto
    __x-common recordproto
}

__renderproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/renderproto
    __x-common renderproto
}

__resourceproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/resourceproto
    __x-common resourceproto
}

__scrnsaverproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/scrnsaverproto
    __x-common scrnsaverproto
}

__videoproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/videoproto
    __x-common videoproto
}

__xcmiscproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xcmiscproto
    __x-common xcmiscproto
}

__xectproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xextproto
    __x-common xextproto
}

__xf86miscproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xf86miscproto
    __x-common xf86miscproto
}

__xf86bigfontproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xf86bigfontproto
    __x-common xf86bigfontproto
}

__xf86dgaproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xf86dgaproto
    __x-common xf86dgaproto
}

__xf86driproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xf86driproto
    __x-common xf86driproto
}

__xf86vidmodeproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xf86vidmodeproto
    __x-common xf86vidmodeproto
}

__xineramaproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xineramaproto
    __x-common xineramaproto
}

__xproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/xproto
    __x-common xproto
}

### <<< xorg-proto members

__xorg-proto()
{
    __bigreqsproto
    __compositeproto
    __damageproto
    __dmxproto
    __dri2proto
    __dri3proto
    __fixesproto
    __fontsproto
    __glproto
    __inputproto
    __kbproto
    __presentproto
    __randrproto
    __recordproto
    __renderproto
    __resourceproto
    __scrnsaverproto
    __videoproto
    __xcmiscproto
    __xectproto
    __xf86miscproto
    __xf86bigfontproto
    __xf86dgaproto
    __xf86driproto
    __xf86vidmodeproto
    __xineramaproto
    __xproto
}

__makedepend()
{
    __git-clone git://anongit.freedesktop.org/xorg/util/makedepend
    __x-common makedepend
}

__libxau()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXau
    __x-common libXau
}

__libxdmcp()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXdmcp
    __x-common libXdmcp
}

__libpthread-stubs()
{
    __git-clone git://anongit.freedesktop.org/xcb/pthread-stubs libpthread-stubs
    __cd libpthread-stubs
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr

    $MAKE_CLEAN
    __mk
    __mkinst
}

__python27()
{
    echo
}

__xcb-proto()
{
    __git-clone git://anongit.freedesktop.org/xcb/proto xcb-proto
    __cd xcb-proto
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG

    $MAKE_CLEAN
    __mk
    __mkinst

    sudo install -dv -m755 /usr/share/doc/xcb-proto
    sudo install -v -m644 doc/* /usr/share/doc/xcb-proto
}

__libxml2()
{
    __git-clone git://git.gnome.org/libxml2 
    __cd libxml2
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr --disable-static --with-history --with-python=/usr/lib/python2.7/

    $MAKE_CLEAN
    __mk
    __mkinst
}

__libxslt()
{
    __git-clone git://git.gnome.org/libxslt
    __cd libxslt
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr --disable-static

    $MAKE_CLEAN
    __mk
    __mkinst
}

__libxcb()
{
    __git-clone git://anongit.freedesktop.org/xcb/libxcb
    __cd libxcb
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --docdir='${datadir}'/doc/libxcb --enable-xinput \
          --enable-xkb --enable-render --enable-record

    $MAKE_CLEAN
    __mk
    __mkinst
}

__expat()
{
    echo
}

__freetype2()
{
    __git-clone git://git.sv.nongnu.org/freetype/freetype2.git freetype2
    __cd freetype2
    git pull

    cp -f include/freetype/config/{ftoption.h,ftoption.h.orig}
    sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr --disable-static

    $MAKE_CLEAN
    __mk
    __mkinst

    cp -f include/freetype/config/{ftoption.h.orig,ftoption.h}
}

__lxml()
{
    __git-clone git://github.com/lxml/lxml.git
    __cd lxml
}

__fontconfig()
{
    __git-clone git://anongit.freedesktop.org/fontconfig
    __cd fontconfig
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr				\
	  --sysconfdir=/etc 			\
          --localstatedir=/var 			\
          --docdir=/usr/share/doc/fontconfig    \
          --disable-docs			\
          --disable-static

    $MAKE_CLEAN
    __mk
    __mkinst

    sudo install -v -m755 -d /usr/share/{man/man{3,5},doc/fontconfig/fontconfig-devel}
    sudo install -v -m644 fc-*/*.1          /usr/share/man/man1
    sudo install -v -m644 doc/*.3           /usr/share/man/man3
    sudo install -v -m644 doc/fonts-conf.5  /usr/share/man/man5
    sudo install -v -m644 doc/fontconfig-devel/* /usr/share/doc/fontconfig/fontconfig-devel
    sudo install -v -m644 doc/*.{pdf,sgml,txt,html} /usr/share/doc/fontconfig
}

### >>> xorg-libs members
__xtrans()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libxtrans
    __x-common libxtrans
}

__libX11()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libX11
    __x-common libX11
}

__libXext()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXext
    __x-common libXext
}

__libFS()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libFS
    __x-common libFS
}

__libICE()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libICE
    __x-common libICE
}

__libSM()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libSM
    __x-common libSM
}

__libXScrnSaver()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXScrnSaver
    __x-common libXScrnSaver
}

__libXt()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXt
    __x-common libXt
}

__libXmu()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXmu
    __x-common libXmu
}

__libXpm()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXpm
    __x-common libXpm
}

__libXaw()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXaw
    __x-common libXaw
}

__libXfixes()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXfixes
    __x-common libXfixes
}

__libXcomposite()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXcomposite
    __x-common libXcomposite
}

__libXrender()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXrender
    __x-common libXrender
}

__libXcursor()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXcursor
    __x-common libXcursor
}

__libXdamage()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXdamage
    __x-common libXdamage
}

__libfontenc()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libfontenc
    __x-common libfontenc
}

__libXfont()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXfont
    __cd libXfont
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --disable-devel-docs

    $MAKE_CLEAN
    __mk
    __mkinst
}

__libXft()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXft
    __x-common libXft
}

__libXi()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXi
    __x-common libXi
}

__libXinerama()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXinerama
    __x-common libXinerama
}

__libXrandr()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXrandr
    __x-common libXrandr
}

__libXres()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXRes 
    __x-common libXRes
}

__libXtst()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXtst
    __cd libXtst
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --with-appdefaultdir=/etc/X11/app-defaults

    $MAKE_CLEAN
    __mk
    __mkinst
}

__libXv()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXv
    __x-common libXv
}

__libXvMC()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXvMC
    __x-common libXvMC
}

__libXxf86misc()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXxf86misc
    __x-common libXxf86misc
}

__libXxf86dga()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXxf86dga
    __x-common libXxf86dga
}

__libXx86vm()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXxf86vm
    __x-common libXxf86vm
}

__libdmx()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libdmx
    __x-common libdmx
}

__libpciaccess()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libpciaccess
    __x-common libpciaccess
}

__libxkbfile()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libxkbfile
    __x-common libxkbfile
}
### <<< xorg-libs members

__xorg-libs()
{
    __xtrans
    __libX11
    __libXext
    __libFS
    __libICE
    __libSM
    __libXScrnSaver
    __libXt
    __libXmu
    __libXpm
    __libXaw
    __libXfixes
    __libXcomposite
    __libXrender
    __libXcursor
    __libXdamage
    __libfontenc
    __libXfont
    __libXft
    __libXi
    __libXinerama
    __libXrandr
    __libXres
    __libXtst
    __libXv
    __libXvMC
    __libXxf86misc
    __libXxf86dga
    __libXx86vm
    __libdmx
    __libpciaccess
    __libxkbfile
}

__gperf()
{
    __git-clone git://git.savannah.gnu.org/gperf.git gperf
    __cd gperf
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr --docdir=/usr/share/doc/gperf

    $MAKE_CLEAN
    __mk
    makeinfo -o doc/gperf.txt --plaintext doc/gperf.texi

    __mkinst

    sudo install -m644 -v doc/gperf.{dvi,ps,pdf,txt} /usr/share/doc/gperf

    pushd /usr/share/info
    sudo rm -v dir
    for FILENAME in *; do
	sudo install-info $FILENAME dir 2>/dev/null
    done
    popd
}

__xcb-util-common-m4()
{
    __git-clone git://anongit.freedesktop.org/xcb/util-common-m4 xcb-util-common-m4
    __cd xcb-util-common-m4
    git pull

    sudo cp -f *.m4 /usr/share/aclocal/
}

__xcb-util()
{
    __git-clone git://anongit.freedesktop.org/xcb/util xcb-util
    __cd xcb-util
    git pull
    git submodule update --init
    __x-bld-common
}

__xcb-util-image()
{
    __git-clone git://anongit.freedesktop.org/xcb/util-image xcb-util-image
    __cd xcb-util-image
    git submodule update --init
    __x-bld-common
}

__xcb-util-keysyms()
{
    __git-clone git://anongit.freedesktop.org/xcb/util-keysyms xcb-util-keysyms
    __cd xcb-util-keysyms
    git pull
    git submodule update --init
    __x-bld-common
}

__xcb-util-renderutil()
{
    __git-clone git://anongit.freedesktop.org/xcb/util-renderutil xcb-util-renderutil
    __cd xcb-util-renderutil
    git pull
    git submodule update --init
    __x-bld-common
}

__xcb-util-wm()
{
    __git-clone git://anongit.freedesktop.org/xcb/util-wm xcb-util-wm
    __cd xcb-util-wm
    git pull
    git submodule update --init
    __x-bld-common
}

__libxshmfence()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libxshmfence
    __x-common libxshmfence
}

__libdrm()
{
    __git-clone git://anongit.freedesktop.org/mesa/drm libdrm
    __cd libdrm
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr	        \
	  --enable-udev	        \
	  --disable-radeon	\
	  --disable-vmwgfx      \
          --disable-intel       \
          --enable-cairo-tests=no \
	  --disable-manpages

    $MAKE_CLEAN
    __mk
    __mkinst
}

__mesa-lib()
{
    __git-clone git://anongit.freedesktop.org/mesa/mesa mesa-lib
    __cd mesa-lib
    git pull

    $DIST_CLEAN
    ./autogen.sh \
          --prefix=/usr                	        \
          --sysconfdir=/etc              	\
          --enable-texture-float         	\
          --enable-gles1                 	\
          --enable-gles2                 	\
          --enable-xa                    	\
          --enable-gbm                   	\
          --enable-gallium-egl           	\
          --enable-gallium-gbm           	\
          --enable-glx-tls               	\
          --enable-dri                          \
          --with-egl-platforms="drm,x11" \
          --with-gallium-drivers="nouveau"  \
          --with-dri-drivers="nouveau"

    $MAKE_CLEAN
    __mk
### __mk -C xdemos DEMOS_PREFIX=/usr
    __mkinst

### __mk -C xdemos DEMOS_PREFIX=/usr install

    sudo install -v -dm755 /usr/share/doc/MesaLib
    sudo cp -rfv docs/* /usr/share/doc/MesaLib
}

__mesa-glu()
{
    __git-clone git://anongit.freedesktop.org/mesa/glu mesa-glu
    __cd mesa-glu
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg --prefix=/usr --disable-static

    $MAKE_CLEAN
    __mk
    __mkinst
}

__xbitmaps()
{
    __git-clone git://anongit.freedesktop.org/xorg/data/bitmaps xbitmaps
    __x-common xbitmaps
}

__libpng()
{
    echo
}

### >>> xorg-apps members

__bdftopcf()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/bdftopcf
    __x-common bdftopcf
}

__iceauth()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/iceauth
    __x-common iceauth
}

__luit()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/luit
    __cd luit
    git pull
    __x-bld-common --enable-maintainer-mode --disable-selective-werror
}

__mkfontdir()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/mkfontdir
    __x-common mkfontdir
}

__mkfontscale()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/mkfontscale
    __x-common mkfontscale
}

__sessreg()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/sessreg
    __x-common sessreg
}

__setxkbmap()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/setxkbmap
    __x-common setxkbmap
}

__smproxy()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/smproxy
    __x-common smproxy
}

__x11perf()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/x11perf
    __x-common x11perf
}

__xauth()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xauth
    __x-common xauth
}

__xbacklight()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xbacklight
    __x-common xbacklight
}

__xcmsdb()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xcmsdb
    __x-common xcmsdb
}

__xcursorgen()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xcursorgen
    __x-common xcursorgen
}

__xdpyinfo()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xdpyinfo
    __x-common xdpyinfo
}

__xdriinfo()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xdriinfo
    __x-common xdriinfo
}

__xev()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xev
    __x-common xev
}

__xgamma()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xgamma
    __x-common xgamma
}

__xhost()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xhost
    __x-common xhost
}

__xinput()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xinput
    __x-common xinput
}

__xkbcomp()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xkbcomp
    __x-common xkbcomp
}

__xkbevd()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xkbevd
    __x-common xkbevd
}

__xkbutils()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xkbutils
    __x-common xkbutils
}

__xkill()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xkill
    __x-common xkill
}

__xlsatoms()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xlsatoms
    __x-common xlsatoms
}

__xlsclients()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xlsclients
    __x-common xlsclients
}

__xmodmap()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xmodmap
    __x-common xmodmap
}

__xpr()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xpr
    __x-common xpr
}

__xprop()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xprop
    __x-common xprop
}

__xrandr()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xrandr
    __x-common xrandr
}

__xrdb()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xrdb
    __x-common xrdb
}

__xrefresh()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xrefresh
    __x-common xrefresh
}

__xset()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xset
    __x-common xset
}

__xsetroot()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xsetroot
    __x-common xsetroot
}

__xvinfo()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xvinfo
    __x-common xvinfo
}

__xwd()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xwd
    __x-common xwd
}

__xwininfo()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xwininfo
    __x-common xwininfo
}

__xwud()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xwud
    __x-common xwud
}

### <<< xorg-apps members

__xorg-apps()
{
    __bdftopcf
    __iceauth
    __luit
    __mkfontdir
    __mkfontscale
    __sessreg
    __setxkbmap
    __smproxy
    __x11perf
    ### リモートデスクトップは使わない
### __xauth
    __xbacklight
    __xcmsdb
    __xcursorgen
    __xdpyinfo
    __xdriinfo
    __xev
    __xgamma
    ### リモートデスクトップは使わない
### __xhost
    __xinput
    __xkbcomp
    __xkbevd
    __xkbutils
    __xkill
    __xlsatoms
    __xlsclients
    __xmodmap
    __xpr
    __xprop
    __xrandr
    __xrdb
    __xrefresh
    __xset
    __xsetroot
    __xvinfo
    __xwd
    __xwininfo
    __xwud
}

__xcursor-themes()
{
    __git-clone git://anongit.freedesktop.org/xorg/data/cursors xcursor-themes
    __x-common xcursor-themes
}

__xorg-fonts()
{
    __xorg-fonts-common()
    {
	FONTS_URL="ftp://ftp.yz.yamagata-u.ac.jp/pub/X11/x.org/X11R7.7/src/font"
	__wget $FONTS_URL/$1.tar.bz2
	__dcd $1
	__x-bld-common
    }

    __xorg-fonts-common font-util-1.3.0
    __xorg-fonts-common encodings-1.0.4
    __xorg-fonts-common font-adobe-100dpi-1.0.3
    __xorg-fonts-common font-adobe-75dpi-1.0.3
    __xorg-fonts-common font-adobe-utopia-100dpi-1.0.4
    __xorg-fonts-common font-adobe-utopia-75dpi-1.0.4
    __xorg-fonts-common font-adobe-utopia-type1-1.0.4
    __xorg-fonts-common font-alias-1.0.3
    __xorg-fonts-common font-arabic-misc-1.0.3
    __xorg-fonts-common font-bh-100dpi-1.0.3
    __xorg-fonts-common font-bh-75dpi-1.0.3
    __xorg-fonts-common font-bh-lucidatypewriter-100dpi-1.0.3
    __xorg-fonts-common font-bh-lucidatypewriter-75dpi-1.0.3
    __xorg-fonts-common font-bh-ttf-1.0.3
    __xorg-fonts-common font-bh-type1-1.0.3
    __xorg-fonts-common font-bitstream-100dpi-1.0.3
    __xorg-fonts-common font-bitstream-75dpi-1.0.3
    __xorg-fonts-common font-bitstream-type1-1.0.3
    __xorg-fonts-common font-cronyx-cyrillic-1.0.3
    __xorg-fonts-common font-cursor-misc-1.0.3
    __xorg-fonts-common font-daewoo-misc-1.0.3
    __xorg-fonts-common font-dec-misc-1.0.3
    __xorg-fonts-common font-ibm-type1-1.0.3
    __xorg-fonts-common font-isas-misc-1.0.3
    __xorg-fonts-common font-jis-misc-1.0.3
    __xorg-fonts-common font-micro-misc-1.0.3
    __xorg-fonts-common font-misc-cyrillic-1.0.3
    __xorg-fonts-common font-misc-ethiopic-1.0.3
    __xorg-fonts-common font-misc-meltho-1.0.3
    __xorg-fonts-common font-misc-misc-1.1.2
    __xorg-fonts-common font-mutt-misc-1.0.3
    __xorg-fonts-common font-schumacher-misc-1.1.2
    __xorg-fonts-common font-screen-cyrillic-1.0.4
    __xorg-fonts-common font-sony-misc-1.0.3
    __xorg-fonts-common font-sun-misc-1.0.3
    __xorg-fonts-common font-winitzki-cyrillic-1.0.3
    __xorg-fonts-common font-xfree86-type1-1.0.4
}

__xml-parser()
{
    echo
}

__intltool()
{
    echo
}

__xkeyboard-config()
{
    __git-clone git://anongit.freedesktop.org/xkeyboard-config
    __cd xkeyboard-config
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --with-xkb-rules-symlink=xorg

    $MAKE_CLEAN
    __mk
    __mkinst

    sudo install -dv -m755 $XORG_PREFIX/share/doc/xkeyboard-config
    sudo install -v -m644 docs/{README,HOWTO}* $XORG_PREFIX/share/doc/xkeyboard-config
}

__printproto()
{
    __git-clone git://anongit.freedesktop.org/xorg/proto/printproto
    __x-common printproto
}

__libxp()
{
    __git-clone git://anongit.freedesktop.org/xorg/lib/libXp
    __x-common libXp
}

__pixman()
{
    __git-clone git://anongit.freedesktop.org/pixman
    __cd pixman
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg  --prefix=/usr --disable-static

    $MAKE_CLEAN
    __mk
    __mkinst
}

__xorg-server()
{
    __git-clone git://anongit.freedesktop.org/xorg/xserver xorg-server
    __cd xorg-server
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --with-xkb-output=/var/lib/xkb --enable-install-setuid --enable-tcp-transport=no \
          --enable-ipv6=no --with-default-xkb-model=pc105 --with-default-xk-layout=jp --disable-selective-werror \
	  --enable-glamor --enable-suid-wrapper
    $MAKE_CLEAN
    __mk
    __mkinst

    sudo mkdir -pv /etc/X11/xorg.conf.d

    grep "/tmp/.ICE-unix dir 1777 root root" /etc/sysconfig/createfiles
    if [ $? -ne 0 ]
    then
cat >> /etc/sysconfig/createfiles << .
/tmp/.ICE-unix dir 1777 root root
.
    fi

    grep "/tmp/.X11-unix dir 1777 root root" /etc/sysconfig/createfiles
    if [ $? -ne 0 ]
    then
cat >> /etc/sysconfig/createfiles << .
/tmp/.X11-unix dir 1777 root root
.
    fi
}

__libevdev()
{
    __git-clone git://anongit.freedesktop.org/libevdev
    __x-common libevdev
}

### >>> xorg-drivers members

__xf86-input-evdev()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/xf86-input-evdev
    __x-common xf86-input-evdev
}

__xf86-input-keyboard()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/xf86-input-keyboard
    __x-common xf86-input-keyboard
}

__xf86-input-mouse()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/xf86-input-mouse
    __x-common xf86-input-mouse
}

__xf86-input-wacom()
{
    __git-clone git://people.freedesktop.org/~whot/xf86-input-wacom
    __cd xf86-input-wacom
    git pull
    __x-bld-common --enable-maintainer-mode --disable-selective-werror
}

__xf86-video-intel()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/xf86-video-intel
    __x-common xf86-video-intel 
}

__xf86-video-nouveau()
{
    __git-clone git://anongit.freedesktop.org/nouveau/xf86-video-nouveau
    __x-common xf86-video-nouveau
}

__xf86-video-modesetting()
{
    __git-clone git://anongit.freedesktop.org/xorg/driver/xf86-video-modesetting
    __x-common xf86-video-modesetting
}

### <<< xorg-drivers members

__xorg-drivers()
{
    __xf86-input-evdev
    __xf86-input-keyboard
    __xf86-input-mouse
    __xf86-input-wacom
    __xf86-video-intel
    __xf86-video-nouveau
    __xf86-video-modesetting
}

__twm()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/twm
    __cd twm
    git pull

    cp src/{Makefile.in,Makefile.in.orig}
    sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG

    $MAKE_CLEAN
    __mk
    __mkinst

    cp src/{Makefile.in.orig,Makefile.in}
}

__xterm()
{
    __wget ftp://invisible-island.net/xterm/xterm-313.tgz

    cd ${BASE_DIR}
    gzip -dc ${SRC_DIR}/xterm-313.tgz | tar xvf -
    __cd xterm-313

    sed -i '/v0/,+1s/new:/new:kb=^?:/' termcap
    echo -e '\tkbs=\\177,' >> terminfo

    TERMINFO=/usr/share/terminfo \
    ./configure $XORG_CONFIG \
                --enable-luit --enable-wide-chars \
                --with-app-defaults=/etc/X11/app-defaults

    __mk
    __mkinst
    sudo make install-ti
    sudo ldconfig

cat >> /etc/X11/app-defaults/XTerm << .
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
.
}

__xclock()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xclock
    __x-common xclock
}

__xinit()
{
    __git-clone git://anongit.freedesktop.org/xorg/app/xinit
    __cd xinit
    git pull

    $DIST_CLEAN
    ./autogen.sh
    __cfg $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults

    $MAKE_CLEAN
    __mk
    __mkinst
}

__xorg-config()
{
    __mes "Please enter your user name to be used when logging on to the xwindow"

    XORG_USER_NAME=""
    read XORG_USER_NAME

    sudo usermod -a -G video ${XORG_USER_NAME}
    sudo usermod -a -G audio ${XORG_USER_NAME}

    sudo ln -vsf $XORG_PREFIX /usr/X11R6

    __dejavu-fonts-ttf()
    {
	__wget http://sourceforge.net/projects/dejavu/files/dejavu/2.33/dejavu-fonts-ttf-2.33.tar.bz2
	__dcd dejavu-fonts-ttf-2.33
	cd ttf
        
	sudo install -v -d -m755 /usr/share/fonts/dejavu
	sudo install -v -m644 *.ttf /usr/share/fonts/dejavu
	sudo fc-cache
    }

    __dejavu-fonts-ttf

    ls /etc/X11/xorg.conf.d/16-xkb-defaults.conf
    if [ $? -ne 0 ]
    then
cat > /etc/X11/xorg.conf.d/16-xkb-defaults.conf << .
Section "InputClass"
	Identifier	"XKB Defaults"
	MatchIsKeyboard	"yes"
	Option		"XkbOptions" "terminate:ctrl_alt_bksp"
	Option		"XkbLayout" "jp"
	Option		"XkbModel" "pc106"
EndSection
.
    fi

    ls /etc/X11/xorg.conf.d/15-videocard-intel.conf
    if [ $? -ne 0 ]
    then
cat > /etc/X11/xorg.conf.d/15-videocard-intel.conf << .
Section "ServerLayout"
	Identifier	"DefaultLayout"
	Screen		0 "Screen0" 0 0

###	Screen		1 "Screen1" LeftOf "Screen0"
###	Option		"Xinerama"
EndSection

Section "Monitor"
	Identifier	"Monitor0"
EndSection

Section "Device"
	Identifier	"Device0"
	Driver		"intel"
	Option		"DRI" "true"
	Option		"AccelMethod" "uxa"
EndSection

Section "Screen"
	Identifier	"Screen0"
	Device		"Device0"
	Monitor		"Monitor0"
	DefaultDepth	24 
	SubSection	"Display"
	Depth		24
	Modes		"1920x1080_60.0"
	EndSubSection
EndSection
.
    fi

cat > /etc/X11/xorg.conf.d/50-wacom.conf << .
Section "InputClass"
	Identifier 	"Wacom class"
	MatchProduct 	"Wacom|WACOM|WALTOP|Hanwang"
	MatchDevicePath	"/dev/input/event*"
	Driver		"wacom"

	Option		"Rotate" "CCW"

	Option		"TopX" "0"
	Option		"BottomX" "30479"

	Option		"TopY" "3000"
	Option		"BottomY" "20144"
EndSection

Section "InputClass"
	Identifier	"Wacom serial class"
	MatchProduct	"Serial Wacom Tablet"
	Driver		"wacom"
EndSection

Section "InputClass"
        Identifier	"Wacom serial class identifiers"
        MatchProduct	"WACf|FUJ02e5|FUJ02e7|FUJ02e9"
        Driver		"wacom"
EndSection

# N-Trig Duosense Electromagnetic Digitizer
Section "InputClass"
	Identifier	"Wacom N-Trig class"
	MatchProduct	"HID 1b96:0001|N-Trig Pen"
	MatchDevicePath	"/dev/input/event*"
	Driver		"wacom"
	Option		"Button2" "3"
EndSection
.

#   cp -f /etc/X11/app-defaults/xinitrc{.orig,}
}

__all()
{
    __util-macros
    __xorg-proto
    __makedepend
    __libxau
    __libxdmcp
    __libpthread-stubs
### __python27
    __xcb-proto
    __libxml2
    __libxslt
    __libxcb
### __expat
    __freetype2
    __fontconfig
    __xorg-libs
### __gperf
    __xcb-util-common-m4
    __xcb-util
    __xcb-util-image
    __xcb-util-keysyms
    __xcb-util-renderutil
    __xcb-util-wm
    __libxshmfence
    __libdrm
    __mesa-lib
    __mesa-glu
    __xbitmaps
### __libpng
    __xorg-apps
    __xcursor-themes
    __xorg-fonts
### __xml-parser
### __intltool
    __xkeyboard-config
    __printproto
    __libxp
    __pixman
    __xorg-server
    __libevdev
    __xorg-drivers
    __twm
    __xterm
    __xclock
    __xinit
    __xorg-config
}

__init-env
$@

