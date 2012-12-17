#!/tools/bin/bash

BASE_DIR=/sources/going-to-chroot
SRC_DIR=/sources/src
. $SRC_DIR/__common-func.sh

__change-own()
{
	chown -Rv 0:0 /tools
	chown -Rv 0:0 /cross-tools
}

__change-dir()
{
	mkdir -pv /{bin,boot,dev,{etc/,}opt,home,lib,mnt}
	mkdir -pv /{proc,media/{floppy,cdrom},sbin,srv,sys}
	mkdir -pv /var/{lock,log,mail,run,spool}
	mkdir -pv /var/{opt,cache,lib/{misc,locate},local}
	install -dv -m 0750 /root
	install -dv -m 1777 {/var,}/tmp
	mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
	mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
	mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
	mkdir -pv /usr/{,local/}share/man/man{1..8}
	for dir in /usr{,/local}; do
  		ln -sv share/{man,doc,info} $dir
	done
	mkdir -pv /run
}

__create-symlink()
{
	ln -sv /tools/bin/{bash,cat,echo,grep,pwd,stty} /bin
	ln -sv /tools/bin/file /usr/bin
	ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
	ln -sv /tools/lib/libstd* /usr/lib
	ln -sv bash /bin/sh

	mkdir -pv /usr/lib64
	ln -sv /tools/lib/libstd*so* /usr/lib64
}

__build-flags()
{
	export BUILD64="-m64"
	echo export BUILD64=\""${BUILD64}\"" >> ~/.bash_profile
}

__create-pas()
{
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
EOF

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:
sys:x:2:
kmem:x:3:
tty:x:4:
tape:x:5:
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
EOF

	exec /tools/bin/bash --login +h
}

#__rem(){
__change-own
__change-dir
__create-symlink
__build-flags
__create-pas

