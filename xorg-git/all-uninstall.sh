#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

. ./__common-func.sh

__bld-common()
{
	__mk uninstall
	ldconfig
}

__common()
{
	__cd $1
	__bld-common
}

__util-macros()
{
	__common util-macros
}

__xorg-proto()
{
	__bigreqsproto()
	{
		__common bigreqsproto
	}

	__compositeproto()
	{
		__common compositeproto
	}

	__damageproto()
	{
		__common damageproto
	}

	__dmxproto()
	{
		__common  dmxproto
	}

	__dri2proto()
	{
		__common dri2proto
	}

	__fixesproto()
	{
		__common fixesproto
	}

	__fontsproto()
	{
		__common fontsproto
	}

	__glproto()
	{
		__common glproto
	}

	__inputproto()
	{

		__common inputproto
	}

	__kbproto()
	{

		__common kbproto
	}

	__randrproto()
	{

		__common randrproto
	}

	__recordproto()
	{

		__common recordproto
	}

	__renderproto()
	{

		__common renderproto
	}

	__resourceproto()
	{

		__common resourceproto
	}

	__scrnsaverproto()
	{

		__common scrnsaverproto
	}

	__videoproto()
	{

		__common videoproto
	}

	__xcmiscproto()
	{

		__common xcmiscproto
	}

	__xectproto()
	{

		__common xextproto
	}

	__xf86miscproto()
	{

		__common xf86miscproto
	}

	__xf86bigfontproto()
	{

		__common xf86bigfontproto
	}

	__xf86dgaproto()
	{

		__common xf86dgaproto
	}

	__xf86driproto()
	{

		__common xf86driproto
	}

	__xf86vidmodeproto()
	{

		__common xf86vidmodeproto
	}

	__xineramaproto()
	{

		__common xineramaproto
	}

	__xproto()
	{

		__common xproto
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

	__common makedepend
}

__libxau()
{

	__common libXau
}

__libxdmcp()
{

	__common libXdmcp
}

__libpthread-stubs()
{
	echo
}

__python27()
{
	echo
}

__xcb-proto()
{
	__common xcb-proto
}

__libxml2()
{
	echo
}

__libxslt()
{
	__common libxslt
}

__libxcb()
{

	__common libxcb
}

__expat()
{
	echo
}

__freetype2()
{
	echo
}

__fontconfig()
{
	__common fontconfig
}

__xorg-libs()
{
	__xtrans()
	{

		__common libxtrans
	}

	__libX11()
	{

		__common libX11
	}

	__libXext()
	{

		__common libXext
	}

	__libFS()
	{

		__common libFS
	}

	__libICE()
	{

		__common libICE
	}

	__libSM()
	{

		__common libSM
	}

	__libXScrnSaver()
	{

		__common libXScrnSaver
	}

	__libXt()
	{

		__common libXt
	}

	__libXmu()
	{

		__common libXmu
	}

	__libXpm()
	{

		__common libXpm
	}

	__libXaw()
	{

		__common libXaw
	}

	__libXfixes()
	{

		__common libXfixes
	}

	__libXcomposite()
	{

		__common libXcomposite
	}

	__libXrender()
	{

		__common libXrender
	}

	__libXcursor()
	{

		__common libXcursor
	}

	__libXdamage()
	{

		__common libXdamage
	}

	__libfontenc()
	{

		__common libfontenc
	}

	__libXfont()
	{
		__common libXfont
	}

	__libXft()
	{

		__common libXft
	}

	__libXi()
	{

		__common libXi
	}

	__libXinerama()
	{

		__common libXinerama
	}

	__libXrandr()
	{

		__common libXrandr
	}

	__libXres()
	{

		__common libXRes
	}

	__libXtst()
	{

		__common libXtst
	}

	__libXv()
	{

		__common libXv
	}

	__libXvMC()
	{

		__common libXvMC
	}

	__libXxf86misc()
	{

		__common libXxf86misc
	}

	__libXxf86dga()
	{

		__common libXxf86dga
	}

	__libXx86vm()
	{

		__common libXxf86vm
	}

	__libdmx()
	{

		__common libdmx
	}

	__libpciaccess()
	{

		__common libpciaccess
	}

	__libxkbfile()
	{

		__common libxkbfile
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
	__libXxf86misc
	__libXxf86dga
	__libXx86vm
	__libdmx
	__libpciaccess
	__libxkbfile
}

__gperf()
{
	echo
}

__xcb-util-common-m4()
{
        echo
}

__xcb-util()
{
	__common xcb-util
}

__xcb-util-image()
{
	__common xcb-util-image
}

__xcb-util-keysyms()
{
	__common xcb-util-keysyms
}

__xcb-util-renderutil()
{

	__common xcb-util-renderutil
}

__xcb-util-wm()
{

	__common xcb-util-wm
}

__libdrm()
{
	__common libdrm
}

__mesa-lib()
{
	__common mesa-lib

	__mesa-glu()
	{
		__common mesa-glu
	}

	__mesa-glu
}

__xbitmaps()
{
	__common xbitmaps
}

__libpng()
{
	echo
}

__xorg-apps()
{
	__bdftopcf()
	{

		__common bdftopcf
	}

	__iceauth()
	{

		__common iceauth
	}

	__luit()
	{
		__common luit
	}

	__mkfontdir()
	{

		__common mkfontdir
	}

	__mkfontscale()
	{

		__common mkfontscale
	}

	__sessreg()
	{

		__common sessreg
	}

	__setxkbmap()
	{

		__common setxkbmap
	}

	__smproxy()
	{

		__common smproxy
	}

	__x11perf()
	{

		__common x11perf
	}

	__xauth()
	{

		__common xauth
	}

	__xbacklight()
	{

		__common xbacklight
	}

	__xcmsdb()
	{

		__common xcmsdb
	}

	__xcursorgen()
	{

		__common xcursorgen
	}

	__xdpyinfo()
	{

		__common xdpyinfo
	}

	__xdriinfo()
	{

		__common xdriinfo
	}

	__xev()
	{

		__common xev
	}

	__xgamma()
	{

		__common xgamma
	}

	__xhost()
	{

		__common xhost
	}

	__xinput()
	{

		__common xinput
	}

	__xkbcomp()
	{

		__common xkbcomp
	}

	__xkbevd()
	{

		__common xkbevd
	}

	__xkbutils()
	{

		__common xkbutils
	}

	__xkill()
	{

		__common xkill
	}

	__xlsatoms()
	{

		__common xlsatoms
	}

	__xlsclients()
	{

		__common xlsclients
	}

	__xmodmap()
	{

		__common xmodmap
	}

	__xpr()
	{

		__common xpr
	}

	__xprop()
	{

		__common xprop
	}

	__xrandr()
	{

		__common xrandr
	}

	__xrdb()
	{

		__common xrdb
	}

	__xrefresh()
	{

		__common xrefresh
	}

	__xset()
	{

		__common xset
	}

	__xsetroot()
	{

		__common xsetroot
	}

	__xvinfo()
	{

		__common xvinfo
	}

	__xwd()
	{

		__common xwd
	}

	__xwininfo()
	{

		__common xwininfo
	}

	__xwud()
	{

		__common xwud
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

	__common xcursor-themes
}

__xorg-fonts()
{
	echo
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
	__common xkeyboard-config
}

__printproto()
{

	__common printproto
}

__libxp()
{

	__common libXp
}

__pixman()
{
	echo
}

__xorg-server()
{
	__common xorg-server
}

__xorg-drivers()
{
	__xf86-input-evdev()
	{

		__common xf86-input-evdev
	}

	__xf86-input-keyboard()
	{

		__common xf86-input-keyboard
	}

	__xf86-input-mouse()
	{

		__common xf86-input-mouse
	}

	__xf86-input-wacom()
	{
		__common xf86-input-wacom
	}

        __xf86-video-intel()
        {

                __common xf86-video-intel 
        }

	__xf86-video-modesetting()
	{

		__common xf86-video-modesetting
	}

#	__rem(){
        __xf86-input-evdev
        __xf86-input-keyboard
        __xf86-input-mouse
        __xf86-input-wacom
        __xf86-video-intel
        __xf86-video-modesetting
}

__twm()
{
	__common twm
}

__xterm()
{
	__common xterm-279
}

__xclock()
{

	__common xclock
}

__xinit()
{
	__common xinit
}

__xorg-config()
{
	echo
}

__all()
{
#	__rem() {
	__util-macros
	__xorg-proto
	__makedepend
	__libxau
	__libxdmcp
	__libpthread-stubs
###	__python27
	__xcb-proto
	__libxml2
	__libxslt
	__libxcb
###	__expat
	__freetype2
	__fontconfig
	__xorg-libs
###	__gperf
	__xcb-util-common-m4
	__xcb-util
	__xcb-util-image
	__xcb-util-keysyms
	__xcb-util-renderutil
	__xcb-util-wm
	__libdrm
	__mesa-lib
	__xbitmaps
###	__libpng
	__xorg-apps
	__xcursor-themes
	__xorg-fonts
###	__xml-parser
###	__intltool
	__xkeyboard-config
	__printproto
	__libxp
###	__pixman
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

