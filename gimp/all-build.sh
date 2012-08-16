#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

. ../common-func/__common-func.sh

__common()
{
	__cd $BASE_DIR/$1
#	make distclean
	./autogen.sh
	./configure --prefix=$PREFIX --disable-python
#	__mk clean
	__mk
	__mk install
	ldconfig
}

#__common vala
#__common gupnp
#__common gupnp-av
#__common gupnp-dlna
#__common gupnp-vala
#__common gssdp
__common babl
__common gegl
__common gimp
