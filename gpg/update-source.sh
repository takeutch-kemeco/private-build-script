#!/bin/bash

__BASE_DIR__=$(pwd)

for package in $(ls)
do
	cd $__BASE_DIR__/$package
	if [ $? -eq 0 ]
	then
		git pull
	fi
done

