#!/bin/bash

__BASE_DIR__=$(pwd)

for n in $(ls)
do
	cd $__BASE_DIR__/$n
	if [ $? -eq 0 ]
	then	
		echo $__BASE_DIR__/$n
		git branch
		echo
	fi
done

