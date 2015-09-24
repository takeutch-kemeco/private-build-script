#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__init-env()
{
    XORG_PREFIX=/usr
    XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man \
               --localstatedir=/var --disable-static"
    
    PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/share/pkgconfig:/lib/pkgconfig"
    
    PROTO_URL="http://xorg.freedesktop.org/releases/individual/proto"
    LIBS_URL="http://xorg.freedesktop.org/releases/individual/lib"
    APPS_URL="http://xorg.freedesktop.org/releases/individual/app"
    FONTS_URL="http://xorg.freedesktop.org/releases/individual/font"
    DRIVER_URL="http://xorg.freedesktop.org/releases/individual/driver"
}

__bld-x-common()
{
    $DIST_CLEAN
    __cfg $XORG_CONFIG $@

    $MAKE_CLEAN
    __mk
    __mkinst
    ldconfig
}

__x-common()
{
    __dcd $1
    __bld-common
}

__util-macros()
{
    __wget http://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2
    __x-common util-macros-1.19.0
}

__xorg-proto()
{
    __bigreqsproto()
    {
	__wget ${PROTO_URL}/bigreqsproto-1.1.2.tar.bz2
	__x-common bigreqsproto-1.1.2
    }

    __compositeproto()
    {
	__wget ${PROTO_URL}/compositeproto-0.4.2.tar.bz2
	__x-common compositeproto-0.4.2
    }

    __damageproto()
    {
	__wget ${PROTO_URL}/damageproto-1.2.1.tar.bz2
	__x-common damageproto-1.2.1
    }

    __dmxproto()
    {
	__wget ${PROTO_URL}/dmxproto-2.3.1.tar.bz2
	__x-common dmxproto-2.3.1
    }

    __dri2proto()
    {
	__wget ${PROTO_URL}/dri2proto-2.8.tar.bz2
	__x-common dri2proto-2.8
    }

    __dri3proto()
    {
	__wget ${PROTO_URL}/dri3proto-1.0.tar.bz2
	__x-common dri3proto-1.0
    }

    __fixesproto()
    {
	__wget ${PROTO_URL}/fixesproto-5.0.tar.bz2
	__x-common fixesproto-5.0
    }

    __fontsproto()
    {
	__wget ${PROTO_URL}/fontsproto-2.1.3.tar.bz2
	__x-common fontsproto-2.1.3
    }

    __glproto()
    {
	__wget ${PROTO_URL}/glproto-1.4.17.tar.bz2
	__x-common glproto-1.4.17
    }

    __inputproto()
    {
	__wget ${PROTO_URL}/inputproto-2.3.1.tar.bz2
	__x-common inputproto-2.3.1
    }

    __kbproto()
    {
	__wget ${PROTO_URL}/kbproto-1.0.7.tar.bz2
	__x-common kbproto-1.0.7
    }

    __presentproto()
    {
	__wget ${PROTO_URL}/presentproto-1.0.tar.bz2
	__x-common presentproto-1.0
    }
    
    __randrproto()
    {
	__wget ${PROTO_URL}/randrproto-1.5.0.tar.bz2
	__x-common randrproto-1.5.0
    }

    __recordproto()
    {
	__wget ${PROTO_URL}/recordproto-1.14.2.tar.bz2
	__x-common recordproto-1.14.2
    }

    __renderproto()
    {
	__wget ${PROTO_URL}/renderproto-0.11.1.tar.bz2
	__x-common renderproto-0.11.1
    }

    __resourceproto()
    {
	__wget ${PROTO_URL}/resourceproto-1.2.0.tar.bz2
	__x-common resourceproto-1.2.0
    }

    __scrnsaverproto()
    {
	__wget ${PROTO_URL}/scrnsaverproto-1.2.2.tar.bz2
	__x-common scrnsaverproto-1.2.2
    }

    __videoproto()
    {
	__wget ${PROTO_URL}/videoproto-2.3.2.tar.bz2
	__x-common videoproto-2.3.2
    }

    __xcmiscproto()
    {
	__wget ${PROTO_URL}/xcmiscproto-1.2.2.tar.bz2
	__x-common xcmiscproto-1.2.2
    }

    __xextproto()
    {
	__wget ${PROTO_URL}/xextproto-7.3.0.tar.bz2
	__x-common xextproto-7.3.0
    }

    __xf86bigfontproto()
    {
	__wget ${PROTO_URL}/xf86bigfontproto-1.2.0.tar.bz2
	__x-common xf86bigfontproto-1.2.0
    }

    __xf86dgaproto()
    {
	__wget ${PROTO_URL}/xf86dgaproto-2.1.tar.bz2
	__x-common xf86dgaproto-2.1
    }

    __xf86driproto()
    {
	__wget ${PROTO_URL}/xf86driproto-2.1.1.tar.bz2
	__x-common xf86driproto-2.1.1
    }

    __xf86vidmodeproto()
    {
	__wget ${PROTO_URL}/xf86vidmodeproto-2.3.1.tar.bz2
	__x-common xf86vidmodeproto-2.3.1
    }

    __xineramaproto()
    {
	__wget ${PROTO_URL}/xineramaproto-1.2.1.tar.bz2
	__x-common xineramaproto-1.2.1
    }

    __xproto()
    {
	__wget ${PROTO_URL}/xproto-7.0.28.tar.bz2
	__x-common xproto-7.0.28
    }

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
    __xextproto
    __xf86bigfontproto
    __xf86dgaproto
    __xf86driproto
    __xf86vidmodeproto
    __xineramaproto
    __xproto
}

__libxau()
{
    __wget ftp://ftp.x.org/pub/individual/lib/libXau-1.0.8.tar.bz2
    __x-common libXau-1.0.8
}

__libxdmcp()
{
    __wget ftp://ftp.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2
    __x-common libXdmcp-1.1.2
}

__xcb-proto()
{
    __wget http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.bz2
    __x-common xcb-proto-1.11
    sudo install -dv -m755 /usr/share/doc/xcb-proto-1.11
    sudo install -v -m644 doc/* /usr/share/doc/xcb-proto-1.11
}

__libxcb()
{
    __wget http://xcb.freedesktop.org/dist/libxcb-1.11.1.tar.bz2
    __dcd libxcb-1.11.1
    __bld-x-common --docdir='${datadir}'/doc/libxcb-1.11.1 --enable-xinput --enable-xkb --enable-render --enable-record
}

__xorg-libs()
{
    __xtrans()
    {
	__wget ${LIBS_URL}/xtrans-1.3.5.tar.bz2
	__x-common xtrans-1.3.5
    }

    __libX11()
    {
	__wget ${LIBS_URL}/libX11-1.6.3.tar.bz2
	__x-common libX11-1.6.3
    }

    __libXext()
    {
        __wget ${LIBS_URL}/libXext-1.3.3.tar.bz2
	__x-common libXext-1.3.3
    }

    __libFS()
    {
        __wget ${LIBS_URL}/libFS-1.0.7.tar.bz2
	__x-common libFS-1.0.7
    }

    __libICE()
    {
        __wget ${LIBS_URL}/libICE-1.0.9.tar.bz2
	__x-common libICE-1.0.9
    }

    __libSM()
    {
        __wget ${LIBS_URL}/libSM-1.2.2.tar.bz2
	__x-common libSM-1.2.2
    }

    __libXScrnSaver()
    {
        __wget ${LIBS_URL}/libXScrnSaver-1.2.2.tar.bz2
	__x-common libXScrnSaver-1.2.2
    }

    __libXt()
    {
        __wget ${LIBS_URL}/libXt-1.1.5.tar.bz2
	__x-common libXt-1.1.5
    }

    __libXmu()
    {
        __wget ${LIBS_URL}/libXmu-1.1.2.tar.bz2
	__x-common libXmu-1.1.2
    }

    __libXpm()
    {
        __wget ${LIBS_URL}/libXpm-3.5.11.tar.bz2
	__x-common libXpm-3.5.11
    }

    __libXaw()
    {
        __wget ${LIBS_URL}/libXaw-1.0.13.tar.bz2
	__x-common libXaw-1.0.13
    }

    __libXfixes()
    {
        __wget ${LIBS_URL}/libXfixes-5.0.1.tar.bz2
	__x-common libXfixes-5.0.1
    }

    __libXcomposite()
    {
        __wget ${LIBS_URL}/libXcomposite-0.4.4.tar.bz2
	__x-common libXcomposite-0.4.4
    }

    __libXrender()
    {
        __wget ${LIBS_URL}/libXrender-0.9.9.tar.bz2
	__x-common libXrender-0.9.9
    }

    __libXcursor()
    {
        __wget ${LIBS_URL}/libXcursor-1.1.14.tar.bz2
	__x-common libXcursor-1.1.14
    }

    __libXdamage()
    {
        __wget ${LIBS_URL}/libXdamage-1.1.4.tar.bz2
	__x-common libXdamage-1.1.4
    }

    __libfontenc()
    {
        __wget ${LIBS_URL}/libfontenc-1.1.3.tar.bz2
	__x-common libfontenc-1.1.3
    }

    __libXfont()
    {
        __wget ${LIBS_URL}/libXfont-1.5.1.tar.bz2
	__dcd libXfont-1.5.1
	__bld-x-common --disable-devel-docs
    }

    __libXft()
    {
        __wget ${LIBS_URL}/libXft-2.3.2.tar.bz2
	__x-common libXft-2.3.2
    }

    __libXi()
    {
        __wget ${LIBS_URL}/libXi-1.7.4.tar.bz2
	__x-common libXi-1.7.4
    }

    __libXinerama()
    {
        __wget ${LIBS_URL}/libXinerama-1.1.3.tar.bz2
	__x-common libXinerama-1.1.3
    }

    __libXrandr()
    {
        __wget ${LIBS_URL}/libXrandr-1.5.0.tar.bz2
	__x-common libXrandr-1.5.0
    }

    __libXres()
    {
        __wget ${LIBS_URL}/libXres-1.0.7.tar.bz2
	__x-common libXres-1.0.7
    }

    __libXtst()
    {
        __wget ${LIBS_URL}/libXtst-1.2.2.tar.bz2
	__dcd libXtst-1.2.2
	__bld-x-common --with-appdefaultdir=/etc/X11/app-defaults
    }

    libXv()
    {
        __wget ${LIBS_URL}/libXv-1.0.10.tar.bz2
	__x-common libXv-1.0.10
    }

    __libXvMC()
    {
        __wget ${LIBS_URL}/libXvMC-1.0.9.tar.bz2
	__x-common libXvMC-1.0.9
    }

    libXxf86dga()
    {
        __wget ${LIBS_URL}/libXxf86dga-1.1.4.tar.bz2
	__x-common libXxf86dga-1.1.4
    }

    __libXx86vm()
    {
        __wget ${LIBS_URL}/libXxf86vm-1.1.4.tar.bz2
	__x-common libXxf86vm-1.1.4
    }

    __libdmx()
    {
        __wget ${LIBS_URL}/libdmx-1.1.3.tar.bz2
	__x-common libdmx-1.1.3
    }

    __libpciaccess()
    {
        __wget ${LIBS_URL}/libpciaccess-0.13.4.tar.bz2
	__x-common libpciaccess-0.13.4
    }

    __libxkbfile()
    {
        __wget ${LIBS_URL}/libxkbfile-1.0.9.tar.bz2
	__x-common libxkbfile-1.0.9
    }

    __libxshmfence()
    {
        __wget ${LIBS_URL}/libxshmfence-1.2.tar.bz2
	__x-common libxshmfence-1.2
    }

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
    __libxshmfence
}

__xcb-util()
{
    __wget http://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.gz
    __x-common xcb-util-0.4.0
}

__xcb-util-image()
{
    __wget http://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2
    __x-common xcb-util-image-0.4.0
}

__xcb-util-keysyms()
{
    __wget http://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2
    __x-common xcb-util-keysyms-0.4.0
}

__xcb-util-renderutil()
{
    __wget http://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2
    __x-common xcb-util-renderutil-0.3.9
}

__xcb-util-wm()
{
    __wget http://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2
    __x-common xcb-util-wm-0.4.1
}

__libdrm()
{
    __wget http://dri.freedesktop.org/libdrm/libdrm-2.4.64.tar.bz2
    __dcd libdrm-2.4.64
    sed -e "/pthread-stubs/d" -i configure.ac
    autoreconf -fiv
    __bld-common --enable-udev --disable-valgrind
}

__mesalib()
{
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/mesa-10.6.6-llvm_3_7-1.patch
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/mesa-10.6.6-add_xdemos-1.patch
    __wget ftp://ftp.freedesktop.org/pub/mesa/10.6.6/mesa-10.6.6.tar.xz
    __dcd mesa-10.6.6
    patch -Np1 -i ../mesa-10.6.6-add_xdemos-1.patch
    patch -Np1 -i ../mesa-10.6.6-llvm_3_7-1.patch
    GLL_DRV="nouveau,swrast"
    ./autogen.sh CFLAGS='-O4' CXXFLAGS='-O4' \
	--prefix=/usr                   \
        --sysconfdir=/etc               \
        --enable-texture-float          \
        --enable-gles1                  \
        --enable-gles2                  \
        --enable-osmesa                 \
        --enable-xa                     \
        --enable-gbm                    \
        --enable-glx-tls                \
        --with-egl-platforms="drm,x11"  \
        --with-gallium-drivers=$GLL_DRV
    unset GLL_DRV
    __mk
    __mkinst
}

__glu()
{
    __wget ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2
    __x-common glu-9.0.0
}

__xbitmaps()
{
    __wget ftp://ftp.x.org/pub/individual/data/xbitmaps-1.1.1.tar.bz2
    __x-common xbitmaps-1.1.1
}

__xorg-apps()
{
    __bdftopcf()
    {
	__wget ${APPS_URL}/bdftopcf-1.0.5.tar.bz2
	__x-common bdftopcf-1.0.5
    }

    __iceauth()
    {
	__wget ${APPS_URL}/iceauth-1.0.7.tar.bz2
	__x-common iceauth-1.0.7
    }

    __luit()
    {
        __wget ${APPS_URL}/luit-1.1.1.tar.bz2
	__dcd luit-1.1.1
	__bld-x-common --disable-selective-werror
    }

    __mkfontdir()
    {
        __wget ${APPS_URL}/mkfontdir-1.0.7.tar.bz2
	__x-common mkfontdir-1.0.7
    }

    __mkfontscale()
    {
        __wget ${APPS_URL}/mkfontscale-1.1.2.tar.bz2
	__x-common mkfontscale-1.1.2
    }

    __sessreg()
    {
        __wget ${APPS_URL}/sessreg-1.1.0.tar.bz2
	__x-common sessreg-1.1.0
    }

    __setxkbmap()
    {
        __wget ${APPS_URL}/setxkbmap-1.3.1.tar.bz2
	__x-common setxkbmap-1.3.1
    }

    __smproxy()
    {
        __wget ${APPS_URL}/smproxy-1.0.6.tar.bz2
	__x-common smproxy-1.0.6
    }

    __x11perf()
    {
        __wget ${APPS_URL}/x11perf-1.6.0.tar.bz2
	__x-common x11perf-1.6.0
    }

    __xauth()
    {
        __wget ${APPS_URL}/xauth-1.0.9.tar.bz2
	__x-common xauth-1.0.9
    }

    __xbacklight()
    {
        __wget ${APPS_URL}/xbacklight-1.2.1.tar.bz2
	__x-common xbacklight-1.2.1
    }

    __xcmsdb()
    {
        __wget ${APPS_URL}/xcmsdb-1.0.5.tar.bz2
	__x-common xcmsdb-1.0.5
    }

    __xcursorgen()
    {
        __wget ${APPS_URL}/xcursorgen-1.0.6.tar.bz2
	__x-common xcursorgen-1.0.6
    }

    __xdpyinfo()
    {
        __wget ${APPS_URL}/xdpyinfo-1.3.2.tar.bz2
	__x-common xdpyinfo-1.3.2
    }

    __xdriinfo()
    {
        __wget ${APPS_URL}/xdriinfo-1.0.5.tar.bz2
	__x-common xdriinfo-1.0.5
    }

    __xev()
    {
        __wget ${APPS_URL}/xev-1.2.2.tar.bz2
	__x-common xev-1.2.2
    }

    __xgamma()
    {
        __wget ${APPS_URL}/xgamma-1.0.6.tar.bz2
	__x-common xgamma-1.0.6
    }

    __xhost()
    {
        __wget ${APPS_URL}/xhost-1.0.7.tar.bz2
	__x-common xhost-1.0.7
    }

    __xinput()
    {
        __wget ${APPS_URL}/xinput-1.6.1.tar.bz2
	__x-common xinput-1.6.1
    }

    __xkbcomp()
    {
        __wget ${APPS_URL}/xkbcomp-1.3.0.tar.bz2
	__x-common xkbcomp-1.3.0
    }

    __xkbevd()
    {
        __wget ${APPS_URL}/xkbevd-1.1.4.tar.bz2
	__x-common xkbevd-1.1.4
    }

    __xkbutils()
    {
        __wget ${APPS_URL}/xkbutils-1.0.4.tar.bz2
	__x-common xkbutils-1.0.4
    }

    __xkill()
    {
        __wget ${APPS_URL}/xkill-1.0.4.tar.bz2
	__x-common xkill-1.0.4
    }

    __xlsatoms()
    {
        __wget ${APPS_URL}/xlsatoms-1.1.2.tar.bz2
	__x-common xlsatoms-1.1.2
    }

    __xlsclients()
    {
        __wget ${APPS_URL}/xlsclients-1.1.3.tar.bz2
	__x-common xlsclients-1.1.3
    }

    __xmodmap()
    {
        __wget ${APPS_URL}/xmodmap-1.0.9.tar.bz2
	__dcd xmodmap-1.0.9
	__bld-x-common --disable-selective-werror
    }

    __xpr()
    {
        __wget ${APPS_URL}/xpr-1.0.4.tar.bz2
	__x-common xpr-1.0.4
    }

    __xprop()
    {
        __wget ${APPS_URL}/xprop-1.2.2.tar.bz2
	__x-common xprop-1.2.2
    }

    __xrandr()
    {
        __wget ${APPS_URL}/xrandr-1.4.3.tar.bz2
	__x-common xrandr-1.4.3
    }

    __xrdb()
    {
        __wget ${APPS_URL}/xrdb-1.1.0.tar.bz2
	__x-common xrdb-1.1.0
    }

    __xrefresh()
    {
        __wget ${APPS_URL}/xrefresh-1.0.5.tar.bz2
	__x-common xrefresh-1.0.5
    }

    __xset()
    {
        __wget ${APPS_URL}/xset-1.2.3.tar.bz2
	__x-common xset-1.2.3
    }

    __xsetroot()
    {
        __wget ${APPS_URL}/xsetroot-1.1.1.tar.bz2
	__x-common xsetroot-1.1.1
    }

    __xvinfo()
    {
        __wget ${APPS_URL}/xvinfo-1.1.3.tar.bz2
	__x-common xvinfo-1.1.3
    }

    __xwd()
    {
        __wget ${APPS_URL}/xwd-1.0.6.tar.bz2
	__x-common xwd-1.0.6
    }

    __xwininfo()
    {
        __wget ${APPS_URL}/xwininfo-1.1.3.tar.bz2
	__x-common xwininfo-1.1.3
    }

    __xwud()
    {
        __wget ${APPS_URL}/xwud-1.0.4.tar.bz2
	__x-common xwud-1.0.4
    }

    __bdftopcf
    __iceauth
    __luit
    __mkfontdir
    __mkfontscale
#   __sessreg
    __setxkbmap
    __smproxy
    __x11perf
    __xauth
    __xbacklight
    __xcmsdb
    __xcursorgen
    __xdpyinfo
    __xdriinfo
    __xev
    __xgamma
    __xhost
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
    __wget ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.4.tar.bz2
    __x-common xcursor-themes-1.0.4
}

__xorg-fonts()
{
    __xorg-fonts-common()
    {
	__wget $FONTS_URL/$1.tar.bz2
	__x-common $1
    }

    __xorg-fonts-common font-util-1.3.1
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

__xkeyboard-config()
{
    __wget ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.15.tar.bz2
    __dcd xkeyboard-config-2.15
    __bld-x-common --with-xkb-rules-symlink=xorg
    sudo install -dv -m755 $XORG_PREFIX/share/doc/xkeyboard-config-2.15
    sudo install -v -m644 docs/{README,HOWTO}* $XORG_PREFIX/share/doc/xkeyboard-config-2.15
}

__xorg-server()
{
    __wget http://www.linuxfromscratch.org/patches/blfs/svn/xorg-server-1.17.2-add_prime_support-1.patch
    __wget ftp://ftp.x.org/pub/individual/xserver/xorg-server-1.17.2.tar.bz2
    __dcd xorg-server-1.17.2
    patch -Np1 -i ../xorg-server-1.17.2-add_prime_support-1.patch
    __bld-x-common \
	--with-xkb-output=/var/lib/xkb \
	--enable-glamor \
	--enable-install-setuid \
	--enable-config-dbus \
	--enable-suid-wrapper \
	--disable-systemd-logind \
	--enable-tcp-transport=no \
	--enable-ipv6=no \
	--with-default-xkb-model=pc105 \
	--with-default-xkb-layout=jp \
        --enable-xvfb \
        --enable-xfbdev
    mkdir -pv /etc/X11/xorg.conf.d
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

__xorg-drivers()
{
    __libevdev()
    {
	__wget http://www.freedesktop.org/software/libevdev/libevdev-1.4.4.tar.xz
	__x-common libevdev-1.4.4
    }
    
    __xf86-input-evdev()
    {
	__wget ${DRIVER_URL}/xf86-input-evdev-2.9.2.tar.bz2
	__x-common xf86-input-evdev-2.9.2
    }

    __xf86-input-keyboard()
    {
	__wget ${DRIVER_URL}/xf86-input-keyboard-1.7.0.tar.gz
	__x-common xf86-input-keyboard-1.7.0
    }

    __xf86-input-mouse()
    {
	__wget ${DRIVER_URL}/xf86-input-mouse-1.9.0.tar.gz
	__x-common xf86-input-mouse-1.9.0
    }

    __xf86-input-wacom()
    {
	__wget http://downloads.sourceforge.net/linuxwacom/xf86-input-wacom-0.31.0.tar.bz2
	__x-common xf86-input-wacom-0.31.0
    }

    __xf86-video-fbdev()
    {
	__wget ${DRIVER_URL}/xf86-video-fbdev-0.4.4.tar.bz2
	__x-common xf86-video-fbdev-0.4.4
    }

    __xf86-video-intel()
    {
	__wget ${DRIVER_URL}/xf86-video-intel-2.99.917.tar.bz2
	__x-common xf86-video-intel-2.99.917
    }
    
    __libvdpau()
    {
	__wget http://people.freedesktop.org/~aplattner/vdpau/libvdpau-1.1.1.tar.bz2
	__x-common libvdpau-1.1.1
    }
	
    __xf86-video-nouveau()
    {
	__wget ${DRIVER_URL}/xf86-video-nouveau-1.0.11.tar.bz2
	__x-common xf86-video-nouveau-1.0.11
    }
    
    __libva()
    {
	__wget http://www.freedesktop.org/software/vaapi/releases/libva/libva-1.6.0.tar.bz2
	__x-common libva-1.6.0
    }

    __libvdpau-va-gl()
    {
	__wget https://github.com/i-rinat/libvdpau-va-gl/releases/download/v0.3.4/libvdpau-va-gl-0.3.4.tar.gz
	__dcd libvdpau-va-gl-0.3.4
	mkdir build
	cd build
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$XORG_PREFIX ..
	__mk
	__mkinst
	sudo echo "export VDPAU_DRIVER=va_gl" >> /etc/profile.d/xorg.sh
    }

    __xf86-video-modesetting()
    {
	__wget ${DRIVER_URL}/xf86-video-modesetting-0.7.0.tar.gz
	__x-common xf86-video-modesetting-0.7.0
    }

    __libevdev
    __xf86-input-evdev
    __xf86-input-keyboard
    __xf86-input-mouse
    __xf86-input-wacom
    __xf86-video-fbdev
    __xf86-video-intel
    __libvdpau
    __xf86-video-nouveau
    __libva
    __libvdpau-va-gl
}

__twm()
{
    __wget ftp://ftp.x.org/pub/individual/app/twm-1.0.9.tar.bz2
    __dcd twm-1.0.9
    sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in
    __bld-x-common
}

__xterm()
{
    __wget ftp://invisible-island.net/xterm/xterm-320.tgz
    cd ${BASE_DIR}
    gzip -dc ${SRC_DIR}/xterm-320.tgz | tar xvf -
    __cd xterm-320
    sed -i '/v0/,+1s/new:/new:kb=^?:/' termcap
    echo -e '\tkbs=\\177,' >> terminfo
    TERMINFO=/usr/share/terminfo			\
	    ./configure $XORG_CONFIG 			\
	    --enable-luit --enable-wide-chars 	\
	    --with-app-defaults=/etc/X11/app-defaults
    __mk
    __mk install
    __mk install-ti
    ldconfig
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
    __wget ftp://ftp.x.org/pub/individual/app/xclock-1.0.7.tar.bz2
    __x-common xclock-1.0.7
}

__xinit()
{
	__wget ftp://ftp.x.org/pub/individual/app/xinit-1.3.4.tar.bz2
	__dcd xinit-1.3.4
	__bld-x-common --with-xinitdir=/etc/X11/app-defaults
}

__xorg-config()
{
    __mes "Please enter your user name to be used when logging on to the xwindow"

    XORG_USER_NAME=""
    read XORG_USER_NAME

    usermod -a -G video ${XORG_USER_NAME}
    usermod -a -G audio ${XORG_USER_NAME}

    ln -vsf $XORG_PREFIX /usr/X11R7

    __dejavu-fonts-ttf()
    {
	wget -c --directory-prefix=${SRC_DIR} \
	     http://sourceforge.net/projects/dejavu/files/dejavu/2.33/dejavu-fonts-ttf-2.33.tar.bz2
	__dcd dejavu-fonts-ttf-2.33
	cd ttf
	sudo install -v -d -m755 /usr/share/fonts/dejavu
	sudo install -v -m644 *.ttf /usr/share/fonts/dejavu
	fc-cache
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
        Option          "AccelMethod" "uxa"
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

    ls /etc/X11/xorg.conf.d/50-wacom.conf
    if [ $? -ne 0 ]
    then
	cat > /etc/X11/xorg.conf.d/50-wacom.conf << .
Section "InputClass"
	Identifier 	"Wacom class"
	MatchProduct 	"Wacom|WACOM|WALTOP|Hanwang"
	MatchDevicePath	"/dev/input/event*"
	Driver		"wacom"

	Option		"Rotate" "CCW"

	Option		"TopX" "0"
	Option		"BottomX" "30479"

	Option		"TopY" "2000"
	Option		"BottomY" "19144"
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
    fi

    sudo cp -f /etc/X11/app-defaults/xinitrc{.orig,}
}

__all()
{
    __util-macros
    __xorg-proto
    __libxau
    __libxdmcp
    __xcb-proto
    __libxcb
    __xorg-libs
    __gperf
    __xcb-util
    __xcb-util-image
    __xcb-util-keysyms
    __xcb-util-renderutil
    __xcb-util-wm
    __libdrm
    __mesalib
    __glu
    __xbitmaps
    __xorg-apps
    __xcursor-themes
    __xorg-fonts
    __xkeyboard-config
    __xorg-server
    __xorg-drivers
    __twm
    __xterm
    __xclock
    __xinit
    __xorg-config
}

__init-env
$@
