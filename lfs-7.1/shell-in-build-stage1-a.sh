#/bin/bash

SRC=$(pwd)

LFS=/mnt/lfs
LFS_SRC=$LFS/sources

export SRC LFS

. __common-func.sh

__initdir()
{
	mkdir -v $LFS/tools
	ln -sv $LFS/tools /

	mkdir -v $LFS_SRC
	mkdir -v $LFS_SRC/firmware
}

__copydata()
{
	cp -v $SRC/*.tar.{gz,bz2,xz} $LFS_SRC
	cp -v $SRC/*.patch $LFS_SRC
	cp -v $SRC/*.sh $LFS_SRC
	cp -v $SRC/*.config $LFS_SRC

	cp -v /lib/firmware $LFS_SRC/ -rf
	cp -v /usr/lib/firmware $LFS_SRC/ -rf
}

__inituser()
{
	groupadd lfs
	useradd -s /bin/bash -g lfs -m -k /dev/null lfs

	__echo-setcol-green
	passwd lfs
	__echo-setcol-def

	chown -v lfs $LFS/tools -R
	chown -v lfs $LFS_SRC
	chown -v lfs $LFS_SRC/*.tar.{gz,bz2,xz} -R
	chown -v lfs $LFS_SRC/*.patch -R
	chown -v lfs $LFS_SRC/*.sh -R
}

__initdir
__copydata
__inituser

su - lfs

