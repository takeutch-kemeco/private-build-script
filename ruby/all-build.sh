#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__common()
{
	__cd $1

	./autogen.sh
	./configure --prefix=/usr

	__mk
	__mk install
	ldconfig
}

__all()
{
__common $BASE_DIR/ruby
}

$@

