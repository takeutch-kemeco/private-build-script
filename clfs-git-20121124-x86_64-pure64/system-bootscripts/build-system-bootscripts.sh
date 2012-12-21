#!/bin/bash

BASE_DIR=/sources/system-bootscripts
SRC_DIR=/sources/src
. $SRC_DIR/__common-func.sh

__bootscripts-cross-lfs()
{
	__dcd bootscripts-cross-lfs-2.0-pre2

	__mk install-bootscripts
	__mk install-network
}

__clock()
{
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# End /etc/sysconfig/clock
EOF
}

__locale()
{
cat > /etc/profile << "EOF"
# Begin /etc/profile

export LC_ALL=ja_JP.utf8
export LANG=ja_JP.utf8
export INPUTRC=/etc/inputrc

# End /etc/profile
EOF
}

__inputrc()
{
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the
# value contained inside the 1st argument to the
# readline specific functions

"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF
}

__network()
{
	echo "HOSTNAME=clfs" > /etc/sysconfig/network

cat > /etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost

# End /etc/hosts (network card version)
EOF

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

#domain [Your Domain Name]
#nameserver [IP address of your primary nameserver]
#nameserver [IP address of your secondary nameserver]

# End /etc/resolv.conf
EOF

#mkdir -pv /etc/sysconfig/network-devices/ifconfig.eth0
#cat > ifconfig.eth0/ipv4 << "EOF"
#ONBOOT=yes
#SERVICE=ipv4-static
#IP=192.168.1.1
#GATEWAY=192.168.1.2
#PREFIX=24
#BROADCAST=192.168.1.255
#EOF
}

__dhcpcd()
{
	__dcd dhcpcd-5.5.6

	./configure --prefix=/usr 			\
		--sbindir=/sbin 			\
    		--sysconfdir=/etc 			\
		--dbdir=/var/lib/dhcpcd 		\
		--libexecdir=/usr/lib/dhcpcd		\

	__mk
	__mk install
}

__dhcp-config()
{
	__dcd bootscripts-cross-lfs-2.0-pre2

	__mk install-service-dhcpcd

#cd /etc/sysconfig/network-devices
#mkdir -pv /etc/sysconfig/network-devices/ifconfig.eth0
#cat > ifconfig.eth0/dhcpcd << "EOF"
#ONBOOT="yes"
#SERVICE="dhcpcd"
#
## Start Command for DHCPCD
#DHCP_START="-q"
#
## Stop Command for DHCPCD
#DHCP_STOP="-k"
#EOF
}

__fstab()
{
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type   options          dump  fsck
#                                                         order

/dev/sda9      /            ext2   defaults         0     1
/dev/sda5      swap         swap   pri=1            0     0
proc           /proc        proc   defaults         0     0
sysfs          /sys         sysfs  defaults         0     0
devpts         /dev/pts     devpts gid=4,mode=620   0     0
# shm          /dev/shm     tmpfs  defaults         0     0
tmpfs          /run         tmpfs  defaults         0     0
tmpfs          /tmp         tmpfs  defaults         0     0
devtmpfs       /dev         devtmpfs defaults       0     0

# End /etc/fstab
EOF
}

__i18n()
{
	cp -v /etc/sysconfig/i18n{,.orig}
	sed -e "s/^KEYMAP=.*/KEYMAP=\"jp106\"/g" \
		/etc/sysconfig/i18n.orig > /etc/sysconfig/i18n
	rm /etc/sysconfig/i18n.orig
}

__linux()
{
	__dcd linux-3.4.17

	__mk mrproper
	__mk menuconfig

	__mk
	__mk modules_install install
	__mk headers_install install
	__mk firmware_install install
	__mk install

	cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-clfs-3.4.17
	cp -v System.map /boot/System.map-3.4.17
	cp -v System.map /boot/System.map-3.4.17
}

__grub-install()
{
	grub-mkconfig -o /boot/grub/grub.cfg

	ln -sv /dev/sda9 /dev/root
	grub-install /dev/sda
}

#__rem() {
__bootscripts-cross-lfs
__clock
__locale
__inputrc
__network
__dhcpcd
__dhcp-config
__fstab
__i18n
__linux
###__grub-install

