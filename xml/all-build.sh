#/bin/bash

BASE_DIR=$(pwd)

#MAKE_CLEAN=
MAKE_CLEAN="make distclean && make clean"

. ../common-func/__common-func.sh

__common()
{
        __cd $1

        $MAKE_CLEAN
        ./autogen.sh
        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig
}

__libxml2()
{
	__common $BASE_DIR/libxml2
}

__libxml++()
{
	__common $BASE_DIR/libxml++
}

__libxslt()
{
	__common $BASE_DIR/libxslt
}

__all()
{
__libxml2
__libxml++
__libxslt
}

$@

