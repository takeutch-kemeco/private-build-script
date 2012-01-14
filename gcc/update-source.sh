#!/bin/bash

BASE_DIR=$(pwd)

update-mpfr()
{
	cd mpfr
	svn update
	cd $BASE_DIR
}

update-gmp()
{
	cd gmp
	hg pull
	hg update
	cd $BASE_DIR
}

update-mpc()
{
	cd mpc
	svn update
	cd $BASE_DIR
}

update-gcc()
{
	cd gcc
	svn update
	cd $BASE_DIR
}

update-mpfr
update-gmp
update-mpc
update-gcc

