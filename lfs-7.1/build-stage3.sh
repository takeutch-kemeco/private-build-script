# build-stage3.sh

SRC=$(pwd)

. __common-func.sh

__lfs-bootscripts()
{
	__dcd lfs-bootscripts-20120725

	__mk install
}

__sysconf-inittab()
{
cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

	vim /etc/inittab
}

__sysconf-hostname()
{
	echo "HOSTNAME=lsm" > /etc/sysconfig/network

	vim /etc/sysconfig/network
}

__sysconf-setclock()
{
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1
HARDWARECLOCK="UTC"
TIMEZONE="Asia/Tokyo"

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF

	vim /etc/sysconfig/clock
}

__sysconf-console()
{
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

KEYMAP="jp106"
CONSOLEFONT="sun12x22"
USECOLOR="yes"

# End /etc/sysconfig/console
EOF

	vim /etc/sysconfig/console
}

__sysconf-profile()
{
cat > /etc/profile << "EOF"
# Begin /etc/profile

export LANG="ja_JP.utf8"
export LOCALE="ja_JP.utf8"

# End /etc/profile
EOF

	/etc/profile
}

__sysconf-inputrc()
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

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
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

	vim /etc/inputrc
}

__sysconf-fstab()
{
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system	mount-point	type	options			dump	fsck
#								order

/dev/sda9	/		ext4	defaults,noatime	0	1
/dev/sda5	swap		swap	pri=1			0	0
proc		/proc		proc	nosuid,noexec,nodev	0	0
sysfs		/sys		sysfs	nosuid,noexec,nodev	0	0
devpts		/dev/pts	devpts	gid=5,mode=620		0	0
tmpfs		/run		tmpfs	defaults,noatime	0	0
devtmpfs	/dev		devtmpfs mode=0755,nosuid	0	0

# End /etc/fstab
EOF

	vim /etc/fstab
}

__sysconf()
{
	__sysconf-inittab
	__sysconf-hostname
	__sysconf-setclock
	__sysconf-console
	__sysconf-profile
	__sysconf-inputrc
	__sysconf-fstab
}
	
__grub-config()
{
	ln -sv /dev/sda9 /dev/root

	grub-install /dev/sda

cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,9)

menuentry "LFS" {
	linux	/boot/vmlinuz root=/dev/sda9 ro
}
EOF

	vim /boot/grub/grub.cfg
}

__linux-kernel()
{
	__dcd $SRC/linux-3.5

	cp ../linux-3.2.6.config .config

	__mk menuconfig

	__mk

	make headers_install
	make firmware_install
	make modules_install
	__mk install

	cp -v ../firmware /lib/ -rf
}

#rem(){
__lfs-bootscripts
__sysconf
__linux-kernel
###__grub-config

__mes "build-stage3 compleate"

