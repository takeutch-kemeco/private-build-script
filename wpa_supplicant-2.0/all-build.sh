#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__bld-common()
{
	$DIST_CLEAN
	__cfg --prefix=/usr		\
              --sysconfdir=/etc		\
	      $@

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

__libnl()
{
        __wget http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-3.2.23.tar.gz
        __common libnl-3.2.23
}

__wpa_supplicant()
{
        __wget http://hostap.epitest.fi/releases/wpa_supplicant-2.0.tar.gz
        __decord wpa_supplicant-2.0
        __cd wpa_supplicant-2.0/wpa_supplicant

cat > .config << "EOF"
CONFIG_BACKEND=file
CONFIG_CTRL_IFACE=y
CONFIG_DEBUG_FILE=n
CONFIG_DEBUG_SYSLOG=n
CONFIG_DEBUG_SYSLOG_FACILITY=LOG_DAEMON
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_DRIVER_WIRED=y
CONFIG_EAP_GTC=y
CONFIG_EAP_LEAP=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_OTP=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TLS=y
CONFIG_EAP_TTLS=y
CONFIG_IEEE8021X_EAPOL=y
CONFIG_IPV6=n
CONFIG_LIBNL32=y
CONFIG_PEERKEY=y
CONFIG_PKCS12=y
CONFIG_READLINE=y
CONFIG_SMARTCARD=y
CONFIG_WPS=y
CFLAGS += -I/usr/include/libnl3
EOF

        __mk BINDIR=/sbin LIBDIR=/lib

        install -v -m755 wpa_{cli,passphrase,supplicant} /sbin/ &&
        install -v -m644 doc/docbook/wpa_supplicant.conf.5 /usr/share/man/man5/ &&
        install -v -m644 doc/docbook/wpa_{cli,passphrase,supplicant}.8 /usr/share/man/man8/

        ldconfig
}

__all()
{
#__rem() {
         __libnl
         __wpa_supplicant
}

$@
