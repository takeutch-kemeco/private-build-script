#!/bin/bash

__BASE_DIR__=$(pwd)

git clone git://anongit.freedesktop.org/xorg/util/macros

mkdir -p proto
cd proto
git clone git://anongit.freedesktop.org/xorg/proto/bigreqsproto
git clone git://anongit.freedesktop.org/xorg/proto/compositeproto
git clone git://anongit.freedesktop.org/xorg/proto/damageproto
git clone git://anongit.freedesktop.org/xorg/proto/dmxproto
git clone git://anongit.freedesktop.org/xorg/proto/dri2proto
git clone git://anongit.freedesktop.org/xorg/proto/fixesproto
git clone git://anongit.freedesktop.org/xorg/proto/fontsproto
git clone git://anongit.freedesktop.org/xorg/proto/glproto
git clone git://anongit.freedesktop.org/xorg/proto/inputproto
git clone git://anongit.freedesktop.org/xorg/proto/kbproto
git clone git://anongit.freedesktop.org/xorg/proto/printproto
git clone git://anongit.freedesktop.org/xorg/proto/randrproto
git clone git://anongit.freedesktop.org/xorg/proto/recordproto
git clone git://anongit.freedesktop.org/xorg/proto/renderproto
git clone git://anongit.freedesktop.org/xorg/proto/resourceproto
git clone git://anongit.freedesktop.org/xorg/proto/scrnsaverproto
git clone git://anongit.freedesktop.org/xorg/proto/videoproto
git clone git://anongit.freedesktop.org/xorg/proto/xcmiscproto
git clone git://anongit.freedesktop.org/xorg/proto/xextproto
git clone git://anongit.freedesktop.org/xorg/proto/xf86bigfontproto
git clone git://anongit.freedesktop.org/xorg/proto/xf86dgaproto
git clone git://anongit.freedesktop.org/xorg/proto/xf86driproto
git clone git://anongit.freedesktop.org/xorg/proto/xf86vidmodeproto
git clone git://anongit.freedesktop.org/xorg/proto/xineramaproto
git clone git://anongit.freedesktop.org/xorg/proto/xproto
cd $__BASE_DIR__

git clone git://anongit.freedesktop.org/xorg/util/makedepend

git clone git://anongit.freedesktop.org/xorg/lib/libXau

git clone git://anongit.freedesktop.org/xorg/lib/libXdmcp

git git://anongit.freedesktop.org/xcb/pthread-stubs

mkdir -p xcb
cd xcb
git clone git://anongit.freedesktop.org/xcb/proto
git clone git://anongit.freedesktop.org/xcb/libxcb
git clone git://anongit.freedesktop.org/xcb/util
cd $__BASE_DIR__

mkdir -p libs
cd libs
git clone git://anongit.freedesktop.org/xorg/lib/libxtrans
git clone git://anongit.freedesktop.org/xorg/lib/libX11
git clone git://anongit.freedesktop.org/xorg/lib/libXext
git clone git://anongit.freedesktop.org/xorg/lib/libFS
git clone git://anongit.freedesktop.org/xorg/lib/libICE
git clone git://anongit.freedesktop.org/xorg/lib/libSM
git clone git://anongit.freedesktop.org/xorg/lib/libXScrnSaver
git clone git://anongit.freedesktop.org/xorg/lib/libXt
git clone git://anongit.freedesktop.org/xorg/lib/libXmu
git clone git://anongit.freedesktop.org/xorg/lib/libXp
git clone git://anongit.freedesktop.org/xorg/lib/libXpm
git clone git://anongit.freedesktop.org/xorg/lib/libXaw
git clone git://anongit.freedesktop.org/xorg/lib/libXfixes
git clone git://anongit.freedesktop.org/xorg/lib/libXcomposite
git clone git://anongit.freedesktop.org/xorg/lib/libXrender
git clone git://anongit.freedesktop.org/xorg/lib/libXcursor
git clone git://anongit.freedesktop.org/xorg/lib/libXdamage
git clone git://anongit.freedesktop.org/xorg/lib/libfontenc
git clone git://anongit.freedesktop.org/xorg/lib/libXfont
git clone git://anongit.freedesktop.org/xorg/lib/libXft
git clone git://anongit.freedesktop.org/xorg/lib/libXi
git clone git://anongit.freedesktop.org/xorg/lib/libXinerama
git clone git://anongit.freedesktop.org/xorg/lib/libXrandr
git clone git://anongit.freedesktop.org/xorg/lib/libXres
git clone git://anongit.freedesktop.org/xorg/lib/libXtst
git clone git://anongit.freedesktop.org/xorg/lib/libXv
git clone git://anongit.freedesktop.org/xorg/lib/libXvMC
git clone git://anongit.freedesktop.org/xorg/lib/libXxf86dga
git clone git://anongit.freedesktop.org/xorg/lib/libXxf86vm
git clone git://anongit.freedesktop.org/xorg/lib/libdmx
git clone git://anongit.freedesktop.org/xorg/lib/libpciaccess
git clone git://anongit.freedesktop.org/xorg/lib/libxkbfile
cd $__BASE_DIR__

mkdir -p mesa
cd mesa
git clone git://anongit.freedesktop.org/mesa/mesa
cd $__BASE_DIR__

mkdir -p apps
cd apps
#apps is null
cd $__BASE_DIR__

#xcursor-themes is null

#fonts is null

git clone git://anongit.freedesktop.org/xkeyboard-config

git clone git://anongit.freedesktop.org/xorg/xserver

mkdir -p driver
cd driver
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-acecad
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-aiptek
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-evdev
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-joystick
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-vmmouse
git clone git://anongit.freedesktop.org/xorg/driver/xf86-input-void
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-apm
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-ark
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-ast
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-ati
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-chips
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-cirrus
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-dummy
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-fbdev
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-geode
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-glide
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-glint
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-i128
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-i740
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-intel
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-mach64
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-mga
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-neomagic
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-newport
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-nv
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-openchrome
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-r128
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-rendition
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-s3
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-s3virge
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-savage
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-siliconmotion
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-sis
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-sisusb
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-sunbw2
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-suncg14
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-suncg3
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-suncg6
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-sunffb
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-sunleo
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-suntcx
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-tdfx
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-tga
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-trident
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-tseng
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-v4l
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-vesa
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-vmware
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-voodoo
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-wsfb
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-xgi
git clone git://anongit.freedesktop.org/xorg/driver/xf86-video-xgixp
cd $__BASE_DIR__

wget -c ftp://invisible-island.net/xterm/xterm-276.tgz
gzip -dc xterm-276.tgz | tar xvf -
mv xterm-276 xterm

