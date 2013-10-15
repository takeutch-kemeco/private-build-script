#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ../common-func/__common-func-2.sh

__pciutils()
{
	__wget ftp://ftp.kernel.org/pub/software/utils/pciutils/pciutils-3.2.0.tar.xz
	__dcd pciutils-3.2.0

	$MAKE_CLEAN
	__mk PREFIX=/usr ZLIB=no
	__mk PREFIX=/usr install
	__mk PREFIX=/usr install-lib
	ldconfig
}

__libusb()
{
	__wget http://downloads.sourceforge.net/libusb/libusb-1.0.9.tar.bz2
	__dcd libusb-1.0.9
	__bld-common
}

__usbutils()
{
	__wget ftp://ftp.kernel.org/pub/linux/utils/usb/usbutils/usbutils-007.tar.xz
	__dcd usbutils-007
	__bld-common --enable-maintainer-mode
}

__libgusb()
{
	__wget http://people.freedesktop.org/~hughsient/releases/libgusb-0.1.6.tar.xz
	__dcd libgusb-0.1.6
	__bld-common
}

__consolekit()
{
	git clone git://anongit.freedesktop.org/ConsoleKit
	__cd ConsoleKit
	__bld-common --localstatedir=/var --libexecdir=/usr/lib/ConsoleKit --enable-pam-module
}

__colord()
{
	__wget http://www.freedesktop.org/software/colord/releases/colord-1.0.2.tar.xz
	__dcd colord-1.0.2
	__bld-common --localstatedir=/var --libexecdir=/usr/lib/colord --with-daemon-user=colord \
                     --enable-vala --disable-bash-completion --disable-systemd-login --disable-static
}

__libva()
{
	git clone git://anongit.freedesktop.org/git/libva
	__common libva
}

__intel-driver()
{
	git clone git://anongit.freedesktop.org/vaapi/intel-driver
	__cd intel-driver
	__bld-common

	grep "/usr/lib/dri" /etc/ld.so.conf
	if [ $? -ne 0 ]
	then
		echo "/usr/lib/dri" >> /etc/ld.so.conf
	fi

	ldconfig
}

__polkit()
{
	git clone git://anongit.freedesktop.org/polkit
	__cd polkit

	groupadd -fg 28 polkitd
	useradd -c "PolicyKit Daemon Owner" \
		-d /etc/polkit-1 \
		-u 28 \
		-g polkitd \
		-s /bin/false polkitd

	__bld-common --localstatedir=/var --libexecdir=/usr/lib/polkit-1 --with-authfw=shadow

cat > /etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF
}

__pyxdg()
{
	__wget http://people.freedesktop.org/~takluyver/pyxdg-0.25.tar.gz
	__dcd pyxdg-0.25
	python setup.py install
}

__shared-mime-info()
{
	git clone git://anongit.freedesktop.org/xdg/shared-mime-info
	__common shared-mime-info
}

__telepathy-glib()
{
	git clone git://anongit.freedesktop.org/telepathy/telepathy-glib
	__cd telepathy-glib
	__bld-common --enable-gtk-doc --disable-fatal-warnings
}

__telepathy-logger()
{
	git clone git://anongit.freedesktop.org/telepathy/telepathy-logger
	__cd telepathy-logger
	__bld-common --enable-gtk-doc --disable-fatal-warnings --enable-debug --disable-Werror
}

__upower()
{
	git clone git://anongit.freedesktop.org/upower
	__common upower
}

__xdg-utils()
{
	git clone git://anongit.freedesktop.org/xdg/xdg-utils
	__common xdg-utils
}

__desktop-file-utils()
{
	git clone git://anongit.freedesktop.org/xdg/desktop-file-utils
	__common desktop-file-utils

	update-desktop-database /usr/share/applications

### memo ###
### /etc/bashrc ###
# XDG_DATA_DIRS=/usr/share
# XDG_CONFIG_DIRS=/etc/xdg
# export XDG_DATA_DIRS XDG_CONFIG_DIRS
}

__liboil()
{
	__wget http://liboil.freedesktop.org/download/liboil-0.3.17.tar.gz
	__dcd liboil-0.3.17
	__bld-common
}

__default-icon-theme()
{
	git clone git://anongit.freedesktop.org/xdg/default-icon-theme
	__common default-icon-theme
}

__tango-icon-theme()
{
	git clone git://anongit.freedesktop.org/tango/tango-icon-theme
	__common tango-icon-theme
}

__accountsservice()
{
	git clone git://anongit.freedesktop.org/accountsservice
	__common accountsservice
}

__certificate()
{
	__wget http://mxr.mozilla.org/mozilla/source/security/nss/lib/ckfw/builtins/certdata.txt?raw=1

cat > /bin/make-cert.pl << "EOF"
#!/usr/bin/perl -w

# Used to generate PEM encoded files from Mozilla certdata.txt.
# Run as ./mkcrt.pl > certificate.crt
#
# Parts of this script courtesy of RedHat (mkcabundle.pl)
#
# This script modified for use with single file data (tempfile.cer) extracted
# from certdata.txt, taken from the latest version in the Mozilla NSS source.
# mozilla/security/nss/lib/ckfw/builtins/certdata.txt
#
# Authors: DJ Lucas
#          Bruce Dubbs
#
# Version 20120211

my $certdata = './tempfile.cer';

open( IN, "cat $certdata|" )
    || die "could not open $certdata";

my $incert = 0;

while ( <IN> )
{
    if ( /^CKA_VALUE MULTILINE_OCTAL/ )
    {
        $incert = 1;
        open( OUT, "|openssl x509 -text -inform DER -fingerprint" )
            || die "could not pipe to openssl x509";
    }

    elsif ( /^END/ && $incert )
    {
        close( OUT );
        $incert = 0;
        print "\n\n";
    }

    elsif ($incert)
    {
        my @bs = split( /\\/ );
        foreach my $b (@bs)
        {
            chomp $b;
            printf( OUT "%c", oct($b) ) unless $b eq '';
        }
    }
}
EOF

chmod +x /bin/make-cert.pl

cat > /bin/make-ca.sh << "EOF"
#!/bin/bash
# Begin make-ca.sh
# Script to populate OpenSSL's CApath from a bundle of PEM formatted CAs
#
# The file certdata.txt must exist in the local directory
# Version number is obtained from the version of the data.
#
# Authors: DJ Lucas
#          Bruce Dubbs
#
# Version 20120211

certdata="certdata.txt"

if [ ! -r $certdata ]; then
  echo "$certdata must be in the local directory"
  exit 1
fi

REVISION=$(grep CVS_ID $certdata | cut -f4 -d'$')

if [ -z "${REVISION}" ]; then
  echo "$certfile has no 'Revision' in CVS_ID"
  exit 1
fi

VERSION=$(echo $REVISION | cut -f2 -d" ")

TEMPDIR=$(mktemp -d)
TRUSTATTRIBUTES="CKA_TRUST_SERVER_AUTH"
BUNDLE="BLFS-ca-bundle-${VERSION}.crt"
CONVERTSCRIPT="/bin/make-cert.pl"
SSLDIR="/etc/ssl"

mkdir "${TEMPDIR}/certs"

# Get a list of staring lines for each cert
CERTBEGINLIST=$(grep -n "^# Certificate" "${certdata}" | cut -d ":" -f1)

# Get a list of ending lines for each cert
CERTENDLIST=`grep -n "^CKA_TRUST_STEP_UP_APPROVED" "${certdata}" | cut -d ":" -f 1`

# Start a loop
for certbegin in ${CERTBEGINLIST}; do
  for certend in ${CERTENDLIST}; do
    if test "${certend}" -gt "${certbegin}"; then
      break
    fi
  done

  # Dump to a temp file with the name of the file as the beginning line number
  sed -n "${certbegin},${certend}p" "${certdata}" > "${TEMPDIR}/certs/${certbegin}.tmp"
done

unset CERTBEGINLIST CERTDATA CERTENDLIST certebegin certend

mkdir -p certs
rm certs/*      # Make sure the directory is clean

for tempfile in ${TEMPDIR}/certs/*.tmp; do
  # Make sure that the cert is trusted...
  grep "CKA_TRUST_SERVER_AUTH" "${tempfile}" | \
    egrep "TRUST_UNKNOWN|NOT_TRUSTED" > /dev/null

  if test "${?}" = "0"; then
    # Throw a meaningful error and remove the file
    cp "${tempfile}" tempfile.cer
    perl ${CONVERTSCRIPT} > tempfile.crt
    keyhash=$(openssl x509 -noout -in tempfile.crt -hash)
    echo "Certificate ${keyhash} is not trusted!  Removing..."
    rm -f tempfile.cer tempfile.crt "${tempfile}"
    continue
  fi

  # If execution made it to here in the loop, the temp cert is trusted
  # Find the cert data and generate a cert file for it

  cp "${tempfile}" tempfile.cer
  perl ${CONVERTSCRIPT} > tempfile.crt
  keyhash=$(openssl x509 -noout -in tempfile.crt -hash)
  mv tempfile.crt "certs/${keyhash}.pem"
  rm -f tempfile.cer "${tempfile}"
  echo "Created ${keyhash}.pem"
done

# Remove blacklisted files
# MD5 Collision Proof of Concept CA
if test -f certs/8f111d69.pem; then
  echo "Certificate 8f111d69 is not trusted!  Removing..."
  rm -f certs/8f111d69.pem
fi

# Finally, generate the bundle and clean up.
cat certs/*.pem >  ${BUNDLE}
rm -r "${TEMPDIR}"
EOF

chmod +x /bin/make-ca.sh

cat > /bin/remove-expired-certs.sh << "EOF"
#!/bin/bash
# Begin /bin/remove-expired-certs.sh
#
# Version 20120211

# Make sure the date is parsed correctly on all systems
function mydate()
{
  local y=$( echo $1 | cut -d" " -f4 )
  local M=$( echo $1 | cut -d" " -f1 )
  local d=$( echo $1 | cut -d" " -f2 )
  local m

  if [ ${d} -lt 10 ]; then d="0${d}"; fi

  case $M in
    Jan) m="01";;
    Feb) m="02";;
    Mar) m="03";;
    Apr) m="04";;
    May) m="05";;
    Jun) m="06";;
    Jul) m="07";;
    Aug) m="08";;
    Sep) m="09";;
    Oct) m="10";;
    Nov) m="11";;
    Dec) m="12";;
  esac

  certdate="${y}${m}${d}"
}

OPENSSL=/usr/bin/openssl
DIR=/etc/ssl/certs

if [ $# -gt 0 ]; then
  DIR="$1"
fi

certs=$( find ${DIR} -type f -name "*.pem" -o -name "*.crt" )
today=$( date +%Y%m%d )

for cert in $certs; do
  notafter=$( $OPENSSL x509 -enddate -in "${cert}" -noout )
  date=$( echo ${notafter} |  sed 's/^notAfter=//' )
  mydate "$date"

  if [ ${certdate} -lt ${today} ]; then
     echo "${cert} expired on ${certdate}! Removing..."
     rm -f "${cert}"
  fi
done
EOF

chmod +x /bin/remove-expired-certs.sh

certhost='http://mxr.mozilla.org'                        &&
certdir='/mozilla/source/security/nss/lib/ckfw/builtins' &&
url="$certhost$certdir/certdata.txt?raw=1"               &&

wget --output-document certdata.txt $url &&
unset certhost certdir url               &&
make-ca.sh                               &&
remove-expired-certs.sh certs

SSLDIR=/etc/ssl                                             &&
install -d ${SSLDIR}/certs                                  &&
cp -v certs/*.pem ${SSLDIR}/certs                           &&
c_rehash                                                    &&
install BLFS-ca-bundle*.crt ${SSLDIR}/ca-bundle.crt         &&
ln -sv ../ca-bundle.crt ${SSLDIR}/certs/ca-certificates.crt &&
unset SSLDIR

rm -r certs BLFS-ca-bundle*
}

__p11-kit()
{
	git clone git://anongit.freedesktop.org/p11-glue/p11-kit
	__cd p11-kit
	__bld-common --disable-nls
}

__all()
{
#__rem(){
__p11-kit
__desktop-file-utils
__pciutils
__usbutils
__libgusb
__consolekit
__colord
__libva
__intel-driver
__polkit
__pyxdg
__shared-mime-info
###__telepathy-glib
###__telepathy-logger
__upower
__xdg-utils
__liboil
__default-icon-theme
__tango-icon-theme
__accountsservice
__certificate
__p11-kit
}

$@

