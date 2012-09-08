#!/bin/bash

BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

for n in $(__lsdir)
do
	cd $BASE_DIR/$n
	if [ $? -eq 0 ]
	then
		echo $n
		
		ls .git
		if [ $? -eq 0 ]
		then
			git pull
		fi

		ls .svn
		if [ $? -eq 0 ]
		then
			svn update
		fi

		ls .hg
		if [ $? -eq 0 ]
		then
			hg pull
			hg update
		fi

		ls CVS
		if [ $? -eq 0 ]
		then
			cvs update
		fi
	fi
done

