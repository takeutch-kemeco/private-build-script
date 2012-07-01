#/tools/bin/bash

#SRC=$LFS/sources
SRC=$(pwd)

set +h
umask 022
HOME=/root
TERM="$TERM"
PS1='\u:\w\$ '
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin

LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=i686-lfs-linux-gnu

MAKEFLAGS='-j4'

#CFLAGS='-O4 -march=native -mtune=native -msse3'
CFLAGS=
CXXFLAGS=$CFLAGS

export SRC HOME TERM PS1 LFS LC_ALL LFS_TGT PATH MAKEFLAGS CFLAGS CXXFLAGS

CURBUILDAPP=

__init-dir()
{
	mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib,mnt,opt,run}
	mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
	install -dv -m 0750 /root
	install -dv -m 1777 /tmp /var/tmp
	mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
	mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
	mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
	mkdir -pv /usr/{,local/}share/man/man{1..8}
	for dir in /usr /usr/local; do
  		ln -sv share/{man,doc,info} $dir
	done
	case $(uname -m) in
 		x86_64) ln -sv lib /lib64 && ln -sv lib /usr/lib64 ;;
	esac
	mkdir -v /var/{log,mail,spool}
	ln -sv /run /var/run
	ln -sv /run/lock /var/lock
	mkdir -pv /var/{opt,cache,lib/{misc,locate},local}
}

__init-link()
{
	ln -sv /tools/bin/{bash,cat,echo,pwd,stty} /bin
	ln -sv /tools/bin/perl /usr/bin
	ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
	ln -sv /tools/lib/libstdc++.so{,.6} /usr/lib
	sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
	ln -sv bash /bin/sh

	touch /etc/mtab
}

__init-shell()
{
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
mail:x:34:
nogroup:x:99:
EOF

	exec /tools/bin/bash --login +h
}

__init-dir
__init-link
__init-shell

