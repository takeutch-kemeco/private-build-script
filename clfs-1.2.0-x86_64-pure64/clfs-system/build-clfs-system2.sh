#!/bin/bash

BASE_DIR=/sources/clfs-system
SRC_DIR=/sources/src
. $SRC_DIR/__common-func.sh

__bzip2()
{
	__dcd bzip2-1.0.6

	sed -i -e 's:ln -s -f $(PREFIX)/bin/:ln -s :' Makefile

	__mk -f Makefile-libbz2_so
	__mk clean

	__mk
	__mk PREFIX=/usr install

	cp -v bzip2-shared /bin/bzip2
	cp -av libbz2.so* /lib
	ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
	rm -v /usr/bin/{bunzip2,bzcat,bzip2}
	ln -sv bzip2 /bin/bunzip2
	ln -sv bzip2 /bin/bzcat
}

__diffutils()
{
	__dcd diffutils-3.0

	./configure --prefix=/usr

	sed -i 's@\(^#define DEFAULT_EDITOR_PROGRAM \).*@\1"vi"@' lib/config.h

	__mk
	__mk install
}

__file()
{
	__dcd file-5.07

	./configure --prefix=/usr

	__mk
	__mk install
}

__findutils()
{
	__dcd findutils-4.4.2

	./configure --prefix=/usr			\
		--libexecdir=/usr/lib/locate 		\
    		--localstatedir=/var/lib/locate		\

	__mk
	__mk install

	mv -v /usr/bin/find /bin

	sed -i 's@find:=${BINDIR}@find:=/bin@' /usr/bin/updatedb
}

__gawk()
{
	__dcd gawk-3.1.8

	./configure --prefix=/usr 			\
		--libexecdir=/usr/lib			\

	__mk
	__mk install
}

__gettext()
{
	__dcd gettext-0.18.1.1

	./configure --prefix=/usr

	__mk
	__mk install
}

__grep()
{
	__dcd grep-2.8

	./configure --prefix=/usr 			\
		--bindir=/bin				\

	__mk
	__mk install
}

__groff()
{
	__dcd groff-1.21

	PAGE=A4 					\
	./configure --prefix=/usr			\

	__mk
	__mk install

	ln -sv soelim /usr/bin/zsoelim
	ln -sv eqn /usr/bin/geqn
	ln -sv tbl /usr/bin/gtbl
}

__gzip()
{
	__dcd gzip-1.4

	./configure --prefix=/usr 			\
		--bindir=/bin				\

	__mk
	__mk install

	mv -v /bin/z{egrep,cmp,diff,fgrep,force,grep,less,more,new} /usr/bin
}

__iputils()
{
	__dcd iputils-s20101006

	patch -Np1 -i $SRC_DIR/iputils-s20101006-fixes-1.patch

	patch -Np1 -i $SRC_DIR/iputils-s20101006-doc-1.patch

	__mk IPV4_TARGETS="tracepath ping rdisc clockdiff rdisc" \
    		IPV6_TARGETS="tracepath6 traceroute6"	\

	install -v -m755 ping /bin
	install -v -m755 clockdiff /usr/bin
	install -v -m755 rdisc /usr/bin
	install -v -m755 tracepath /usr/bin
	install -v -m755 trace{path,route}6 /usr/bin
	install -v -m644 doc/*.8 /usr/share/man/man8
}

__kbd()
{
	__dcd kbd-1.15.3

	patch -Np1 -i $SRC_DIR/kbd-1.15.3-es.po_fix-1.patch

	./configure --prefix=/usr

	__mk
	__mk install

	mv -v /usr/bin/{kbd_mode,dumpkeys,loadkeys,openvt,setfont,setvtrgb} /bin
}

__less()
{
	__dcd less-443

	./configure --prefix=/usr 			\
		--sysconfdir=/etc			\

	__mk
	__mk install

	mv -v /usr/bin/less /bin
}

__make()
{
	__dcd make-3.82

	./configure --prefix=/usr

	__mk
	__mk install
}

__xz()
{
	__dcd xz-5.0.2

	./configure --prefix=/usr

	__mk
	__mk install

	mv -v /usr/bin/{xz,lzma,lzcat,unlzma,unxz,xzcat} /bin
}

__man()
{
	__dcd man-1.6g

	patch -Np1 -i $SRC_DIR/man-1.6g-i18n-1.patch

	sed -i 's@-is@&R@g' configure

	sed -i 's@MANPATH./usr/man@#&@g' src/man.conf.in
	sed -i 's@MANPATH./usr/local/man@#&@g' src/man.conf.in

	./configure -confdir=/etc

	__mk
	__mk install
}

__module-init-tools()
{
	__dcd module-init-tools-3.12

	sed -i "s/\(make\)\( all\)/\1 DOCBOOKTOMAN=true\2/" tests/runtests &&
	./tests/runtests

	./configure --prefix=/usr 			\
    		--bindir=/bin				\
		--sbindir=/sbin 			\
    		--enable-zlib-dynamic			\

	__mk DOCBOOKTOMAN=true
	__mk install
}

__patch()
{
	__dcd patch-2.6.1

	./configure --prefix=/usr

	__mk
	__mk install
}

__psmisc()
{
	__dcd psmisc-22.13

	./configure --prefix=/usr			\
		--exec-prefix=""			\

	__mk
	__mk install

	mv -v /bin/pstree* /usr/bin

	ln -sv killall /bin/pidof
}

__shadow()
{
	__dcd shadow-4.1.4.3

	sed -i 's/man_MANS = $(man_nopam) /man_MANS = /' man/ru/Makefile.in

	./configure --sysconfdir=/etc

	sed -i 's/groups$(EXEEXT) //' src/Makefile
	find man -name Makefile -exec sed -i '/groups.1.xml/d' '{}' \;
	find man -name Makefile -exec sed -i 's/groups.1 //' '{}' \;

	__mk
	__mk install

	sed -i /etc/login.defs \
    		-e 's@#\(ENCRYPT_METHOD \).*@\1MD5@' \
    		-e 's@/var/spool/mail@/var/mail@'

	mv -v /usr/bin/passwd /bin

	pwconv
	grpconv

	passwd root
}

__libestr()
{
	__dcd libestr-0.1.0

	./configure --prefix=/usr

	__mk
	__mk install
}

__libee()
{
	__dcd libee-0.3.1

	./configure --prefix=/usr

	__mk
	__mk install
}

__rsyslog()
{
	__dcd rsyslog-6.1.7

	./configure --prefix=/usr

	__mk
	__mk install

	install -dv /etc/rsyslog.d

cat > /etc/rsyslog.conf << "EOF"
# Begin /etc/rsyslog.conf

# CLFS configuration of rsyslog. For more info use man rsyslog.conf

#######################################################################
# Rsyslog Modules

# Support for Local System Logging
$ModLoad imuxsock.so

# Support for Kernel Logging
$ModLoad imklog.so

#######################################################################
# Global Options

# Use traditional timestamp format.
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

# Set the default permissions for all log files.
$FileOwner root
$FileGroup root
$FileCreateMode 0640
$DirCreateMode 0755

# Provides UDP reception
$ModLoad imudp
$UDPServerRun 514

# Disable Repeating of Entries
$RepeatedMsgReduction on

#######################################################################
# Include Rsyslog Config Snippets

$IncludeConfig /etc/rsyslog.d/*.conf

#######################################################################
# Standard Log Files

auth,authpriv.*			/var/log/auth.log
*.*;auth,authpriv.none		-/var/log/syslog
daemon.*			-/var/log/daemon.log
kern.*				-/var/log/kern.log
lpr.*				-/var/log/lpr.log
mail.*				-/var/log/mail.log
user.*				-/var/log/user.log

# Catch All Logs
*.=debug;\
	auth,authpriv.none;\
	news.none;mail.none	-/var/log/debug
*.=info;*.=notice;*.=warn;\
	auth,authpriv.none;\
	cron,daemon.none;\
	mail,news.none		-/var/log/messages

# Emergencies are shown to everyone
*.emerg				*

# End /etc/rsyslog.conf
EOF
}

__sysvinit()
{
	__dcd sysvinit-2.88dsf

	__mk -C src clobber
	__mk -C src
	__mk -C src install

cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc sysinit

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

EOF

cat >> /etc/inittab << "EOF"
1:2345:respawn:/sbin/agetty -I '\033(K' tty1 9600
2:2345:respawn:/sbin/agetty -I '\033(K' tty2 9600
3:2345:respawn:/sbin/agetty -I '\033(K' tty3 9600
4:2345:respawn:/sbin/agetty -I '\033(K' tty4 9600
5:2345:respawn:/sbin/agetty -I '\033(K' tty5 9600
6:2345:respawn:/sbin/agetty -I '\033(K' tty6 9600

EOF

cat >> /etc/inittab << "EOF"
c0:12345:respawn:/sbin/agetty 115200 ttyS0 vt100

EOF

cat >> /etc/inittab << "EOF"
# End /etc/inittab
EOF
}

__tar()
{
	__dcd tar-1.26

	patch -Np1 -i $SRC_DIR/tar-1.26-man-1.patch

	FORCE_UNSAFE_CONFIGURE=1 			\
	./configure --prefix=/usr 			\
    		--bindir=/bin 				\
		--libexecdir=/usr/sbin			\

	__mk
	__mk install
}

__texinfo()
{
	__decord texinfo-4.13a
	__cd texinfo-4.13

	patch -Np1 -i $SRC_DIR/texinfo-4.13a-new_compressors-1.patch

	./configure --prefix=/usr

	__mk
	__mk install

	pushd /usr/share/info
	rm dir
	for f in *
		do install-info $f dir 2>/dev/null
	done
	popd
}

__udev()
{
	__dcd udev-168

	./configure --prefix=/usr 			\
  		--exec-prefix=""			\
		--sysconfdir=/etc 			\
  		--libexecdir=/lib/udev 			\
		--libdir=/usr/lib 			\
  		--disable-extras 			\
		--disable-introspection			\

	__mk
	__mk install

	install -dv /lib/firmware
}

__vim()
{
	__decord vim-7.3
	__cd vim73

	patch -Np1 -i $SRC_DIR/vim-7.3-branch_update-2.patch

	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

	./configure --prefix=/usr			\
		--enable-multibyte			\

	__mk
	__mk install

	ln -sv vim /usr/bin/vi

	ln -sv ../vim/vim73/doc /usr/share/doc/vim-7.3

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2

"set number
set shiftwidth=8
set tabstop=8

set ruler

syntax on

set background=dark
"set background=light

" End /etc/vimrc
EOF
}

__grub()
{
	__dcd grub-1.99

	./configure --prefix=/usr 			\
		--sysconfdir=/etc 			\
		--disable-werror			\

	__mk
	__mk install

	install -m755 -dv /etc/default

cat > /etc/default/grub << "EOF"
# Begin /etc/default/grub

GRUB_DEFAULT=0
#GRUB_SAVEDEFAULT=true
GRUB_HIDDEN_TIMEOUT=
GRUB_HIDDEN_TIMEOUT_QUIET=false
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=Cross-LFS

GRUB_CMDLINE_LINUX=""
GRUB_CMDLINE_LINUX_DEFAULT=""

#GRUB_TERMINAL=console
#GRUB_GFXMODE=640x480
#GRUB_GFXPAYLOAD_LINUX=keep

#GRUB_DISABLE_LINUX_UUID=true
#GRUB_DISABLE_LINUX_RECOVERY=true

#GRUB_INIT_TUNE="480 440 1"

#GRUB_DISABLE_OS_PROBER=true

# End /etc/default/grub
EOF
}

#__rem(){
__bzip2
__diffutils
__file
__findutils
__gawk
__gettext
__grep
__groff
__gzip
__iputils
__kbd
__less
__make
__xz
__man
__module-init-tools
__patch
__psmisc
__shadow
__libestr
__libee
__rsyslog
__sysvinit
__tar
__texinfo
__udev
__vim
__grub

