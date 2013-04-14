#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN=
DIST_CLEAN="make distclean"

. ./__common-func.sh

__init-env()
{
	XORG_PREFIX=/usr
	XORG_CONFIG="--prefix=/usr		\
		--sysconfdir=/etc 		\
             	--mandir=/usr/share/man 	\
             	--localstatedir=/var"

	PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/share/pkgconfig:/lib/pkgconfig"

	PROTO_URL="http://xorg.freedesktop.org/releases/individual/proto"
	LIBS_URL="http://xorg.freedesktop.org/releases/individual/lib"
	APPS_URL="http://xorg.freedesktop.org/releases/individual/app"
	FONTS_URL="http://xorg.freedesktop.org/releases/individual/font"

	ln -s /usr/lib /usr/lib64
}

__bld-common()
{
	$DIST_CLEAN
	__cfg $XORG_CONFIG $@

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__common()
{
	__dcd $1
	__bld-common
}

__util-macros()
{
	__wget ftp://ftp.x.org/pub/individual/util/util-macros-1.17.tar.bz2
	__common util-macros-1.17
}

__xorg-proto()
{
	__bigreqsproto()
	{
		__wget ${PROTO_URL}/bigreqsproto-1.1.2.tar.bz2
		__common bigreqsproto-1.1.2
	}

	__compositeproto()
	{
		__wget ${PROTO_URL}/compositeproto-0.4.2.tar.bz2
		__common compositeproto-0.4.2
	}

	__damageproto()
	{
		__wget ${PROTO_URL}/damageproto-1.2.1.tar.bz2
		__common damageproto-1.2.1
	}

	__dmxproto()
	{
		__wget ${PROTO_URL}/dmxproto-2.3.1.tar.bz2
		__common dmxproto-2.3.1
	}

	__dri2proto()
	{
		__wget ${PROTO_URL}/dri2proto-2.6.tar.bz2
		__common dri2proto-2.6
	}

	__fixesproto()
	{
		__wget ${PROTO_URL}/fixesproto-5.0.tar.bz2
		__common fixesproto-5.0
	}

	__fontsproto()
	{
		__wget ${PROTO_URL}/fontsproto-2.1.2.tar.bz2
		__common fontsproto-2.1.2
	}

	__glproto()
	{
		__wget ${PROTO_URL}/glproto-1.4.15.tar.bz2
		__common glproto-1.4.15
	}

	__inputproto()
	{
		__wget ${PROTO_URL}/inputproto-2.2.tar.bz2
		__common inputproto-2.2
	}

	__kbproto()
	{
		__wget ${PROTO_URL}/kbproto-1.0.6.tar.bz2
		__common kbproto-1.0.6
	}

	__randrproto()
	{
		__wget ${PROTO_URL}/randrproto-1.3.2.tar.bz2
		__common randrproto-1.3.2
	}

	__recordproto()
	{
		__wget ${PROTO_URL}/recordproto-1.14.2.tar.bz2
		__common recordproto-1.14.2
	}

	__renderproto()
	{
		__wget ${PROTO_URL}/renderproto-0.11.1.tar.bz2
		__common renderproto-0.11.1
	}

	__resourceproto()
	{
		__wget ${PROTO_URL}/resourceproto-1.2.0.tar.bz2
		__common resourceproto-1.2.0
	}

	__scrnsaverproto()
	{
		__wget ${PROTO_URL}/scrnsaverproto-1.2.2.tar.bz2
		__common scrnsaverproto-1.2.2
	}

	__videoproto()
	{
		__wget ${PROTO_URL}/videoproto-2.3.1.tar.bz2
		__common videoproto-2.3.1
	}

	__xcmiscproto()
	{
		__wget ${PROTO_URL}/xcmiscproto-1.2.2.tar.bz2
		__common xcmiscproto-1.2.2
	}

	__xectproto()
	{
		__wget ${PROTO_URL}/xextproto-7.2.1.tar.bz2
		__common xextproto-7.2.1
	}

	__xf86bigfontproto()
	{
		__wget ${PROTO_URL}/xf86bigfontproto-1.2.0.tar.bz2
		__common xf86bigfontproto-1.2.0
	}

	__xf86dgaproto()
	{
		__wget ${PROTO_URL}/xf86dgaproto-2.1.tar.bz2
		__common xf86dgaproto-2.1
	}

	__xf86driproto()
	{
		__wget ${PROTO_URL}/xf86driproto-2.1.1.tar.bz2
		__common xf86driproto-2.1.1
	}

	__xf86vidmodeproto()
	{
		__wget ${PROTO_URL}/xf86vidmodeproto-2.3.1.tar.bz2
		__common xf86vidmodeproto-2.3.1
	}

	__xineramaproto()
	{
		__wget ${PROTO_URL}/xineramaproto-1.2.1.tar.bz2
		__common xineramaproto-1.2.1
	}

	__xproto()
	{
		__wget ${PROTO_URL}/xproto-7.0.23.tar.bz2
		__common xproto-7.0.23
	}

#	__rem() {
	__bigreqsproto
	__compositeproto
	__damageproto
	__dmxproto
	__dri2proto
	__fixesproto
	__fontsproto
	__glproto
	__inputproto
	__kbproto
	__randrproto
	__recordproto
	__renderproto
	__resourceproto
	__scrnsaverproto
	__videoproto
	__xcmiscproto
	__xectproto
	__xf86bigfontproto
	__xf86dgaproto
	__xf86driproto
	__xf86vidmodeproto
	__xineramaproto
	__xproto
}

__makedepend()
{
	__wget http://xorg.freedesktop.org/releases/individual/util/makedepend-1.0.4.tar.bz2
	__common makedepend-1.0.4
}

__libxau()
{
	__wget ftp://ftp.x.org/pub/individual/lib/libXau-1.0.7.tar.bz2
	__common libXau-1.0.7
}

__libxdmcp()
{
	__wget ftp://ftp.x.org/pub/individual/lib/libXdmcp-1.1.1.tar.bz2
	__common libXdmcp-1.1.1
}

__libpthread-stubs()
{
	__wget http://xcb.freedesktop.org/dist/libpthread-stubs-0.3.tar.bz2
	__dcd libpthread-stubs-0.3

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__python27()
{
	__wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tar.xz
	__wget http://docs.python.org/ftp/python/doc/2.7.3/python-2.7.3-docs-html.tar.bz2
	__dcd Python-2.7.3

	sed -i "s/ndbm_libs = \[\]/ndbm_libs = ['gdbm', 'gdbm_compat']/" setup.py

	$DIST_CLEAN
	__cfg --prefix=/usr --enable-shared

	$MAKE_CLEAN
	__mk
	make -C Doc html

	__mk install
	chmod -v 755 /usr/lib/libpython2.7.so.1.0
	ldconfig

	install -v -m755 -d /usr/share/doc/Python-2.7.3
	cp -rfv Doc/build/html/* /usr/share/doc/python-2.7.3

	install -v -m755 -d /usr/share/doc/Python-2.7.3

	tar --strip-components=1 -C /usr/share/doc/Python-2.7.3 \
		-xvf ${SRC_DIR}/python-2.7.3-docs-html.tar.bz2

	find /usr/share/doc/Python-2.7.3 -type d -exec chmod 0755 {} \;
	find /usr/share/doc/Python-2.7.3 -type f -exec chmod 0644 {} \;

	grep "export PYTHONDOCS=/usr/share/doc/Python-2.7.3" /etc/profile
	if [ $? -ne 0 ]
	then
		echo "export PYTHONDOCS=/usr/share/doc/Python-2.7.3" >> /etc/profile
	fi
}

__xcb-proto()
{
	__wget http://xcb.freedesktop.org/dist/xcb-proto-1.7.1.tar.bz2
	__dcd xcb-proto-1.7.1

	$DIST_CLEAN
	__cfg $XORG_CONFIG

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -dv -m755 /usr/share/doc/xcb-proto-1.7.1
	install -v -m644 doc/* /usr/share/doc/xcb-proto-1.7.1
}

__libxml2()
{
	__wget ftp://xmlsoft.org/libxml2/libxml2-2.9.0.tar.gz
	__dcd libxml2-2.9.0

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__libxslt()
{
	__wget ftp://xmlsoft.org/libxslt/libxslt-1.1.28.tar.gz
	__dcd libxslt-1.1.28

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-static

	$MAKE_CLEAN
	__mk
	make install
}

__libxcb()
{
	__wget http://xcb.freedesktop.org/dist/libxcb-1.8.1.tar.bz2
	__dcd libxcb-1.8.1	

	$DIST_CLEAN
	__cfg $XORG_CONFIG --docdir='${datadir}'/doc/libxcb-1.8.1 --enable-xinput --enable-xkb --enable-render --enable-record

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__expat()
{
	__wget http://downloads.sourceforge.net/expat/expat-2.1.0.tar.gz
	__dcd expat-2.1.0

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/doc/expat-2.1.0
	install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.1.0
}

__freetype2()
{
	__wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/freetype-2.4.10.tar.bz2
	__wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/freetype-doc-2.4.10.tar.bz2
	__dcd freetype-2.4.10

	tar -xf ${SRC_DIR}/freetype-doc-2.4.10.tar.bz2 --strip-components=2 -C docs

	sed -i -r 's:.*(#.*SUBPIXEL.*) .*:\1:' include/freetype/config/ftoption.h

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/doc/freetype-2.4.10
	cp -v -R docs/*     /usr/share/doc/freetype-2.4.10
}

__fontconfig()
{
	__wget http://fontconfig.org/release/fontconfig-2.10.1.tar.bz2
	__dcd fontconfig-2.10.1

	$DIST_CLEAN
	__cfg --prefix=/usr				\
		--sysconfdir=/etc 			\
            	--localstatedir=/var 			\
            	--docdir=/usr/share/doc/fontconfig-2.10.1 \
            	--disable-docs				\
            	--disable-static			\

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m755 -d /usr/share/{man/man{3,5},doc/fontconfig-2.10.1/fontconfig-devel}
	install -v -m644 fc-*/*.1          /usr/share/man/man1
	install -v -m644 doc/*.3           /usr/share/man/man3
	install -v -m644 doc/fonts-conf.5  /usr/share/man/man5
	install -v -m644 doc/fontconfig-devel/* /usr/share/doc/fontconfig-2.10.1/fontconfig-devel
	install -v -m644 doc/*.{pdf,sgml,txt,html} /usr/share/doc/fontconfig-2.10.1
}

__xorg-libs()
{
	__xtrans()
	{
		__wget ${LIBS_URL}/xtrans-1.2.7.tar.bz2
		__common xtrans-1.2.7
	}

	__libX11()
	{
		__wget ${LIBS_URL}/libX11-1.5.0.tar.bz2
		__common libX11-1.5.0
	}

	__libXext()
	{
                __wget ${LIBS_URL}/libXext-1.3.1.tar.bz2
		__common libXext-1.3.1
	}

	__libFS()
	{
                __wget ${LIBS_URL}/libFS-1.0.4.tar.bz2
		__common libFS-1.0.4
	}

	__libICE()
	{
                __wget ${LIBS_URL}/libICE-1.0.8.tar.bz2
		__common libICE-1.0.8
	}

	__libSM()
	{
                __wget ${LIBS_URL}/libSM-1.2.1.tar.bz2
		__common libSM-1.2.1
	}

	__libXScrnSaver()
	{
                __wget ${LIBS_URL}/libXScrnSaver-1.2.2.tar.bz2
		__common libXScrnSaver-1.2.2
	}

	__libXt()
	{
                __wget ${LIBS_URL}/libXt-1.1.3.tar.bz2
		__common libXt-1.1.3
	}

	__libXmu()
	{
                __wget ${LIBS_URL}/libXmu-1.1.1.tar.bz2
		__common libXmu-1.1.1
	}

	__libXpm()
	{
                __wget ${LIBS_URL}/libXpm-3.5.10.tar.bz2
		__common libXpm-3.5.10
	}

	__libXaw()
	{
                __wget ${LIBS_URL}/libXaw-1.0.11.tar.bz2
		__common libXaw-1.0.11
	}

	__libXfixes()
	{
                __wget ${LIBS_URL}/libXfixes-5.0.tar.bz2
		__common libXfixes-5.0
	}

	__libXcomposite()
	{
                __wget ${LIBS_URL}/libXcomposite-0.4.3.tar.bz2
		__common libXcomposite-0.4.3
	}

	__libXrender()
	{
                __wget ${LIBS_URL}/libXrender-0.9.7.tar.bz2
		__common libXrender-0.9.7
	}

	__libXcursor()
	{
                __wget ${LIBS_URL}/libXcursor-1.1.13.tar.bz2
		__common libXcursor-1.1.13
	}

	__libXdamage()
	{
                __wget ${LIBS_URL}/libXdamage-1.1.3.tar.bz2
		__common libXdamage-1.1.3
	}

	__libfontenc()
	{
                __wget ${LIBS_URL}/libfontenc-1.1.1.tar.bz2
		__common libfontenc-1.1.1
	}

	__libXfont()
	{
                __wget ${LIBS_URL}/libXfont-1.4.5.tar.bz2
		__dcd libXfont-1.4.5

		$DIST_CLEAN
		__cfg $XORG_CONFIG --disable-devel-docs

		$MAKE_CLEAN
		__mk
		__mk install
		ldconfig
	}

	__libXft()
	{
                __wget ${LIBS_URL}/libXft-2.3.1.tar.bz2
		__common libXft-2.3.1
	}

	__libXi()
	{
                __wget ${LIBS_URL}/libXi-1.6.1.tar.bz2
		__common libXi-1.6.1
	}

	__libXinerama()
	{
                __wget ${LIBS_URL}/libXinerama-1.1.2.tar.bz2
		__common libXinerama-1.1.2
	}

	__libXrandr()
	{
                __wget ${LIBS_URL}/libXrandr-1.3.2.tar.bz2
		__common libXrandr-1.3.2
	}

	__libXres()
	{
                __wget ${LIBS_URL}/libXres-1.0.6.tar.bz2
		__common libXres-1.0.6
	}

	__libXtst()
	{
                __wget ${LIBS_URL}/libXtst-1.2.1.tar.bz2
		__dcd libXtst-1.2.1

		$DIST_CLEAN
		__cfg $XORG_CONFIG --with-appdefaultdir=/etc/X11/app-defaults

		$MAKE_CLEAN
		__mk
		__mk install
		ldconfig
	}

	__libXv()
	{
                __wget ${LIBS_URL}/libXv-1.0.7.tar.bz2
		__common libXv-1.0.7
	}

	__libXvMC()
	{
                __wget ${LIBS_URL}/libXvMC-1.0.7.tar.bz2
		__common libXvMC-1.0.7
	}

	__libXxf86dga()
	{
                __wget ${LIBS_URL}/libXxf86dga-1.1.3.tar.bz2
		__common libXxf86dga-1.1.3
	}

	__libXx86vm()
	{
                __wget ${LIBS_URL}/libXxf86vm-1.1.2.tar.bz2
		__common libXxf86vm-1.1.2
	}

	__libdmx()
	{
                __wget ${LIBS_URL}/libdmx-1.1.2.tar.bz2
		__common libdmx-1.1.2
	}

	__libpciaccess()
	{
                __wget ${LIBS_URL}/libpciaccess-0.13.1.tar.bz2
		__common libpciaccess-0.13.1
	}

	__libxkbfile()
	{
                __wget ${LIBS_URL}/libxkbfile-1.0.8.tar.bz2
		__common libxkbfile-1.0.8
	}

#	__rem() {
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
	__libXxf86dga
	__libXx86vm
	__libdmx
	__libpciaccess
	__libxkbfile
}

__gperf()
{
	__wget ftp://ftp.gnu.org/gnu/gperf/gperf-3.0.4.tar.gz
	__dcd gperf-3.0.4

	$DIST_CLEAN
	__cfg --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4

	$MAKE_CLEAN
	__mk
	makeinfo -o doc/gperf.txt --plaintext doc/gperf.texi

	__mk install
	ldconfig

	install -m644 -v doc/gperf.{dvi,ps,pdf,txt} /usr/share/doc/gperf-3.0.4

	pushd /usr/share/info
	rm -v dir
	for FILENAME in *; do
		install-info $FILENAME dir 2>/dev/null
	done
	popd
}

__xcb-util()
{
	__wget http://xcb.freedesktop.org/dist/xcb-util-0.3.9.tar.gz
	__common xcb-util-0.3.9
}

__xcb-util-image()
{
	__wget http://xcb.freedesktop.org/dist/xcb-util-image-0.3.9.tar.bz2
	__common xcb-util-image-0.3.9
}

__xcb-util-keysyms()
{
	__wget http://xcb.freedesktop.org/dist/xcb-util-keysyms-0.3.9.tar.bz2
	__common xcb-util-keysyms-0.3.9
}

__xcb-util-renderutil()
{
	__wget http://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.8.tar.bz2
	__common xcb-util-renderutil-0.3.8
}

__xcb-util-wm()
{
	__wget http://xcb.freedesktop.org/dist/xcb-util-wm-0.3.9.tar.bz2
	__common xcb-util-wm-0.3.9
}

__libdrm()
{
	__wget http://dri.freedesktop.org/libdrm/libdrm-2.4.42.tar.bz2
	__dcd libdrm-2.4.42

	$DIST_CLEAN

	sed -e "/pthread-stubs/d" -i configure.ac
	autoreconf -fi
        __cfg --prefix=/usr     \
              --enable-udev     \
              --disable-radeon  \
              --disable-nouveau \
              --disable-vmwgfx

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__mesa-lib()
{
	__wget ftp://ftp.freedesktop.org/pub/mesa/9.1/MesaLib-9.1.tar.bz2
	__wget http://www.linuxfromscratch.org/patches/blfs/svn/MesaLib-9.1-add_xdemos-1.patch
	__decord MesaLib-9.1
	__cd Mesa-9.1

	patch -Np1 -i ${SRC_DIR}/MesaLib-9.1-add_xdemos-1.patch

	$DIST_CLEAN
	autoreconf -fi
	__cfg --prefix=/usr                	\
            	--sysconfdir=/etc              	\
            	--enable-texture-float         	\
            	--enable-gles1                 	\
            	--enable-gles2                 	\
            	--enable-openvg                	\
		--enable-osmesa			\
            	--enable-xa                    	\
            	--enable-gbm                   	\
            	--enable-gallium-egl           	\
            	--enable-gallium-gbm           	\
            	--enable-glx-tls               	\
		--with-llvm-shared-libs		\
            	--with-egl-platforms="drm,x11" 	\
            	--with-gallium-drivers="i915"	\
		--with-dri-drivers="i965"	\

	$MAKE_CLEAN
	__mk
	__mk -C xdemos DEMOS_PREFIX=/usr
	__mk install
	ldconfig

	__mk -C xdemos DEMOS_PREFIX=/usr install

	install -v -dm755 /usr/share/doc/MesaLib-9.1
	cp -rfv docs/* /usr/share/doc/MesaLib-9.1

	__mesa-glu()
	{
		__wget ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2
		__dcd glu-9.0.0

		$DIST_CLEAN
		__cfg --prefix=/usr --disable-static

		$MAKE_CLEAN
		__mk
		__mk install
		ldconfig
	}

	__mesa-glu
}

__xbitmaps()
{
	__wget ftp://ftp.x.org/pub/individual/data/xbitmaps-1.1.1.tar.bz2
	__common xbitmaps-1.1.1
}

__libpng()
{
	__wget http://downloads.sourceforge.net/libpng/libpng-1.5.13.tar.xz
	__wget http://downloads.sourceforge.net/libpng-apng/libpng-1.5.13-apng.patch.gz
	__dcd libpng-1.5.13

	gzip -cd ${SRC_DIR}/libpng-1.5.13-apng.patch.gz | patch -p1

	$DIST_CLEAN
	__cfg --prefix=/usr --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	mkdir /usr/share/doc/libpng-1.5.13
	cp README libpng-manual.txt /usr/share/doc/libpng-1.5.13
}

__xorg-apps()
{
	__bdftopcf()
	{
		__wget ${APPS_URL}/bdftopcf-1.0.3.tar.bz2
		__common bdftopcf-1.0.3
	}

	__iceauth()
	{
		__wget ${APPS_URL}/iceauth-1.0.5.tar.bz2
		__common iceauth-1.0.5
	}

	__luit()
	{
                __wget ${APPS_URL}/luit-1.1.1.tar.bz2
		__dcd luit-1.1.1
		__bld-common --disable-selective-werror
	}

	__mkfontdir()
	{
                __wget ${APPS_URL}/mkfontdir-1.0.7.tar.bz2
		__common mkfontdir-1.0.7
	}

	__mkfontscale()
	{
                __wget ${APPS_URL}/mkfontscale-1.1.0.tar.bz2
		__common mkfontscale-1.1.0
	}

	__sessreg()
	{
                __wget ${APPS_URL}/sessreg-1.0.7.tar.bz2
		__common sessreg-1.0.7
	}

	__setxkbmap()
	{
                __wget ${APPS_URL}/setxkbmap-1.3.0.tar.bz2
		__common setxkbmap-1.3.0
	}

	__smproxy()
	{
                __wget ${APPS_URL}/smproxy-1.0.5.tar.bz2
		__common smproxy-1.0.5
	}

	__x11perf()
	{
                __wget ${APPS_URL}/x11perf-1.5.4.tar.bz2
		__common x11perf-1.5.4
	}

	__xauth()
	{
                __wget ${APPS_URL}/xauth-1.0.7.tar.bz2
		__common xauth-1.0.7
	}

	__xbacklight()
	{
                __wget ${APPS_URL}/xbacklight-1.1.2.tar.bz2
		__common xbacklight-1.1.2
	}

	__xcmsdb()
	{
                __wget ${APPS_URL}/xcmsdb-1.0.4.tar.bz2
		__common xcmsdb-1.0.4
	}

	__xcursorgen()
	{
                __wget ${APPS_URL}/xcursorgen-1.0.5.tar.bz2
		__common xcursorgen-1.0.5
	}

	__xdpyinfo()
	{
                __wget ${APPS_URL}/xdpyinfo-1.3.0.tar.bz2
		__common xdpyinfo-1.3.0
	}

	__xdriinfo()
	{
                __wget ${APPS_URL}/xdriinfo-1.0.4.tar.bz2
		__common xdriinfo-1.0.4
	}

	__xev()
	{
                __wget ${APPS_URL}/xev-1.2.0.tar.bz2
		__common xev-1.2.0
	}

	__xgamma()
	{
                __wget ${APPS_URL}/xgamma-1.0.5.tar.bz2
		__common xgamma-1.0.5
	}

	__xhost()
	{
                __wget ${APPS_URL}/xhost-1.0.5.tar.bz2
		__common xhost-1.0.5
	}

	__xinput()
	{
                __wget ${APPS_URL}/xinput-1.6.0.tar.bz2
		__common xinput-1.6.0
	}

	__xkbcomp()
	{
                __wget ${APPS_URL}/xkbcomp-1.2.4.tar.bz2
		__common xkbcomp-1.2.4
	}

	__xkbevd()
	{
                __wget ${APPS_URL}/xkbevd-1.1.3.tar.bz2
		__common xkbevd-1.1.3
	}

	__xkbutils()
	{
                __wget ${APPS_URL}/xkbutils-1.0.3.tar.bz2
		__common xkbutils-1.0.3
	}

	__xkill()
	{
                __wget ${APPS_URL}/xkill-1.0.3.tar.bz2
		__common xkill-1.0.3
	}

	__xlsatoms()
	{
                __wget ${APPS_URL}/xlsatoms-1.1.1.tar.bz2
		__common xlsatoms-1.1.1
	}

	__xlsclients()
	{
                __wget ${APPS_URL}/xlsclients-1.1.2.tar.bz2
		__common xlsclients-1.1.2
	}

	__xmodmap()
	{
                __wget ${APPS_URL}/xmodmap-1.0.7.tar.bz2
		__dcd xmodmap-1.0.7
		__bld-common --disable-selective-werror
	}

	__xpr()
	{
                __wget ${APPS_URL}/xpr-1.0.4.tar.bz2
		__common xpr-1.0.4
	}

	__xprop()
	{
                __wget ${APPS_URL}/xprop-1.2.1.tar.bz2
		__common xprop-1.2.1
	}

	__xrandr()
	{
                __wget ${APPS_URL}/xrandr-1.3.5.tar.bz2
		__common xrandr-1.3.5
	}

	__xrdb()
	{
                __wget ${APPS_URL}/xrdb-1.0.9.tar.bz2
		__common xrdb-1.0.9
	}

	__xrefresh()
	{
                __wget ${APPS_URL}/xrefresh-1.0.4.tar.bz2
		__common xrefresh-1.0.4
	}

	__xset()
	{
                __wget ${APPS_URL}/xset-1.2.2.tar.bz2
		__common xset-1.2.2
	}

	__xsetroot()
	{
                __wget ${APPS_URL}/xsetroot-1.1.0.tar.bz2
		__common xsetroot-1.1.0
	}

	__xvinfo()
	{
                __wget ${APPS_URL}/xvinfo-1.1.1.tar.bz2
		__common xvinfo-1.1.1
	}

	__xwd()
	{
                __wget ${APPS_URL}/xwd-1.0.5.tar.bz2
		__common xwd-1.0.5
	}

	__xwininfo()
	{
                __wget ${APPS_URL}/xwininfo-1.1.2.tar.bz2
		__common xwininfo-1.1.2
	}

	__xwud()
	{
                __wget ${APPS_URL}/xwud-1.0.4.tar.bz2
		__common xwud-1.0.4
	}

#	__rem() {
	__bdftopcf
	__iceauth
	__luit
	__mkfontdir
	__mkfontscale
	__sessreg
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
	__wget ftp://ftp.x.org/pub/individual/data/xcursor-themes-1.0.3.tar.bz2
	__common xcursor-themes-1.0.3
}

__xorg-fonts()
{
	__xorg-fonts-common()
	{
		__wget $FONTS_URL/$1.tar.bz2
		__common $1
	}

#	__rem() {
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
	__wget http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/XML-Parser-2.41.tar.gz
	__dcd XML-Parser-2.41
	perl Makefile.PL
	__mk
	__mk install
	ldconfig
}

__intltool()
{
	wget -c -B $SRC_DIR http://launchpad.net/intltool/trunk/0.50.2/+download/intltool-0.50.2.tar.gz
	__dcd intltool-0.50.2

	$DIST_CLEAN
	__cfg --prefix=/usr

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -v -m644 -D doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO
}

__xkeyboard-config()
{
	__wget ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.6.tar.bz2
	__dcd xkeyboard-config-2.6

	$DIST_CLEAN
	__cfg $XORG_CONFIG --with-xkb-rules-symlink=xorg

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

	install -dv -m755 $XORG_PREFIX/share/doc/xkeyboard-config-2.6
	install -v -m644 docs/{README,HOWTO}* $XORG_PREFIX/share/doc/xkeyboard-config-2.6
}

__printproto()
{
	__wget ftp://ftp.x.org/pub/individual/proto/printproto-1.0.5.tar.bz2
	__dcd printproto-1.0.5
}

__libxp()
{
	__wget ftp://ftp.x.org/pub/individual/lib/libXp-1.0.1.tar.bz2
	__dcd libXp-1.0.1
}

__pixman()
{
	__wget http://cairographics.org/releases/pixman-0.28.0.tar.gz
	__dcd pixman-0.28.0

	$DIST_CLEAN
	__cfg  --prefix=/usr --disable-static

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xorg-server()
{
	__wget ftp://ftp.x.org/pub/individual/xserver/xorg-server-1.12.4.tar.bz2
	__dcd xorg-server-1.12.4

	$DIST_CLEAN
	__cfg $XORG_CONFIG 			\
           --with-xkb-output=/var/lib/xkb 	\
           --enable-install-setuid

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig

mkdir -pv /etc/X11/xorg.conf.d
cat >> /etc/sysconfig/createfiles << .
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
.
}

__xorg-drivers()
{
	__xf86-input-evdev()
	{
		__wget ftp://ftp.x.org/pub/individual/driver/xf86-input-evdev-2.7.3.tar.bz2
		__common xf86-input-evdev-2.7.3
	}

	__xf86-input-wacom()
	{
		__wget http://downloads.sourceforge.net/linuxwacom/xf86-input-wacom-0.17.0.tar.bz2
		__common xf86-input-wacom-0.17.0
	}

	__xf86-video-fbdev()
	{
		__wget ftp://ftp.x.org/pub/individual/driver/xf86-video-fbdev-0.4.3.tar.bz2
		__common xf86-video-fbdev-0.4.3
	}

	__xf86-video-intel()
	{
		__wget ftp://ftp.x.org/pub/individual/driver/xf86-video-intel-2.20.13.tar.bz2
		__common xf86-video-intel-2.20.13
	}

	__xf86-video-vesa()
	{
		__wget ftp://ftp.x.org/pub/individual/driver/xf86-video-vesa-2.3.2.tar.bz2
		__common xf86-video-vesa-2.3.2
	}

	__xf86-input-evdev
	__xf86-input-wacom
	__xf86-video-fbdev	
	__xf86-video-intel
###	__xf86-video-vesa
}

__twm()
{
	__wget ftp://ftp.x.org/pub/individual/app/twm-1.0.7.tar.bz2
	__dcd twm-1.0.7

	sed -i -e '/^rcdir =/s,^\(rcdir = \).*,\1/etc/X11/app-defaults,' src/Makefile.in

	$DIST_CLEAN
	__cfg $XORG_CONFIG

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xterm()
{
	__wget ftp://invisible-island.net/xterm/xterm-279.tgz

	cd ${BASE_DIR}
	gzip -dc ${SRC_DIR}/xterm-279.tgz | tar xvf -
	__cd xterm-279

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
	__wget ftp://ftp.x.org/pub/individual/app/xclock-1.0.6.tar.bz2
	__common xclock-1.0.6
}

__xinit()
{
	__wget ftp://ftp.x.org/pub/individual/app/xinit-1.3.2.tar.bz2
	__dcd xinit-1.3.2

	$DIST_CLEAN
	__cfg $XORG_CONFIG --with-xinitdir=/etc/X11/app-defaults

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__xorg-config()
{
	__mes "Please enter your user name to be used when logging on to the xwindow"

	XORG_USER_NAME=""
	read XORG_USER_NAME

	usermod -a -G video ${XORG_USER_NAME}
	usermod -a -G audio ${XORG_USER_NAME}

	ln -vsf $XORG_PREFIX /usr/X11R6

	__dejavu-fonts-ttf()
	{
		wget -c --directory-prefix=${SRC_DIR} \
			http://sourceforge.net/projects/dejavu/files/dejavu/2.33/dejavu-fonts-ttf-2.33.tar.bz2
		__dcd dejavu-fonts-ttf-2.33
		cd ttf

		install -v -d -m755 /usr/share/fonts/dejavu
		install -v -m644 *.ttf /usr/share/fonts/dejavu
		fc-cache
	}

	__dejavu-fonts-ttf

cat > /etc/X11/xorg.conf.d/xkb-defaults.conf << .
Section "InputClass"
	Identifier	"XKB Defaults"
	MatchIsKeyboard	"yes"
	Option		"XkbOptions" "terminate:ctrl_alt_bksp"
	Option		"XkbLayout" "jp"
	Option		"XkbModel" "pc106"
EndSection
.

cat > /etc/X11/xorg.conf.d/videocard-0.conf << .
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

}

__init-env

__all()
{
#	__rem() {
	__util-macros
	__xorg-proto
	__makedepend
	__libxau
	__libxdmcp
	__libpthread-stubs
	__python27
	__xcb-proto
	__libxml2
	__libxslt
	__libxcb
	__expat
	__freetype2
	__fontconfig
	__xorg-libs
	__gperf
	__xcb-util
	__xcb-util-image
	__xcb-util-keysyms
	__xcb-util-renderutil
	__xcb-util-wm
	__libdrm
	__mesa-lib
	__xbitmaps
	__libpng
	__xorg-apps
	__xcursor-themes
	__xorg-fonts
	__xml-parser
	__intltool
	__xkeyboard-config
	__printproto
	__libxp
	__pixman
	__xorg-server
	__xorg-drivers
	__twm
	__xterm
	__xclock
	__xinit
	__xorg-config
}

$@

