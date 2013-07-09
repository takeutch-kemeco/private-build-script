#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

. ./__common-func.sh

for n in $(__lsdir)
do
	__cd $n
	if [ $? -eq 0 ]
	then
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

