#!/bin/bash

__BASE_DIR__=$(pwd)

for __PACKAGE__ in $(ls)
do
	cd $__BASE_DIR__/$__PACKAGE__
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

