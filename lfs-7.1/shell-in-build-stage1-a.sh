#/bin/bash

#SRC=$LFS/sources
SRC=$(pwd)

LFS=/mnt/lfs

export SRC LFS

__initdir()
{
	mkdir -v $LFS/tools
	ln -sv $LFS/tools /
}

__inituser()
{
	groupadd lfs
	useradd -s /bin/bash -g lfs -m -k /dev/null lfs

	passwd lfs

	chown -v lfs $LFS/tools
	chown -v lfs $LFS/sources
}

__initdir
__inituser

su - lfs

