#!/bin/bash

__BASE_DIR__=$(pwd)

. ../common-func/__common-func.sh

for __PACKAGE__ in $(__lsdir)
do
	cd $__BASE_DIR__/$__PACKAGE__
	if [ $? -eq 0 ]
	then
		git pull
	fi
done

