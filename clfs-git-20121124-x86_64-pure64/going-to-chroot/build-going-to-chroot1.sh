#!/bin/bash

BASE_DIR=/mnt/clfs/sources/going-to-chroot
SRC_DIR=/mnt/clfs/sources/src
. $SRC_DIR/__common-func.sh

__init-env()
{
	export CLFS="/mnt/clfs"
	export LC_ALL="POSIX"
	export BUILD64="-m64"
	export PATH="/cross-tools/bin:/bin:/usr/bin"

	export CLFS_HOST=$(echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/')
	export CLFS_TARGET="x86_64-unknown-linux-gnu"

	export CC="${CLFS_TARGET}-gcc"
	export CXX="${CLFS_TARGET}-g++"
	export AR="${CLFS_TARGET}-ar"
	export AS="${CLFS_TARGET}-as"
	export RANLIB="${CLFS_TARGET}-ranlib"
	export LD="${CLFS_TARGET}-ld"
	export STRIP="${CLFS_TARGET}-strip"
}

__util-linux()
{
	__dcd util-linux-2.22.1

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
		--disable-makeinstall-chown	\
		--disable-login 		\
		--disable-su			\
		--config-cache			\

	__mk
	__mk install
}

__mount-vkfs()
{
	mkdir -pv ${CLFS}/{dev,proc,sys}

	mount -vt proc proc ${CLFS}/proc
	mount -vt sysfs sysfs ${CLFS}/sys

	mknod -m 600 ${CLFS}/dev/console c 5 1
	mknod -m 666 ${CLFS}/dev/null c 1 3

	mount -v -o bind /dev ${CLFS}/dev

	mount -f -vt tmpfs tmpfs ${CLFS}/dev/shm
	mount -f -vt devpts -o gid=4,mode=620 devpts ${CLFS}/dev/pts
}

__chroot-env()
{
	chroot "${CLFS}" /tools/bin/env -i \
		HOME=/root TERM="${TERM}" PS1='\u:\w\$ ' \
    		PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    		/tools/bin/bash --login +h
}

__init-env

#__rem(){
__util-linux
__mount-vkfs
__chroot-env

