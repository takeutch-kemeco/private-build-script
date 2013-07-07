#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

for n in $(__lsdir)
do
	__cd $BASE_DIR/$n
	if [ $? -eq 0 ]
	then
		ls .git
		if [ $? -eq 0 ]
		then
			git pull
		fi
	fi
done

