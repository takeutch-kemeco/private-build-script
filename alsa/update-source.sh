#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

. ../common-func/__common-func.sh

for __PACKAGE__ in $(ls -F | grep / | sed -e "s/\/$//g")
do
	__cd $BASE_DIR/$__PACKAGE__
	if [ $? -eq 0 ]
	then
		git pull
	fi
done

