#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__geany()
{
	__cd geany

	./autogen.sh
	./configure --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__geany

