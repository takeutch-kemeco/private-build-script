#/bin/bash

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

	chown -v lfs $LFS/tools -R
	chown -v lfs $SRC -R
}

__initdir
__inituser

su - lfs

