#!/bin/bash

BASE_DIR=$(pwd)

for n in $(ls)
do
	cd $BASE_DIR/$n
	if [ $? -eq 0 ]
	then
		echo $n
		git pull
	fi
done

