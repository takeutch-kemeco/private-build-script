#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)
SRC=$BASE_DIR

MAKE_CLEAN=
$MAKE_CLEAN="__mk clean"

. ../common-func/__common-func.sh

for PACKAGE in $(ls -F | grep / | sed -e "s/\/$//g")
do
	__cd $BASE_DIR/$PACKAGE
	if [ $? -eq 0 ]
	then
		./gitcompile
		if [ $? -eq 0 ]
		then
			./configure --prefix=$PREFIX
			$MAKE_CLEAN
			__mk
			__mk install
			ldconfig
		fi
	fi
done

