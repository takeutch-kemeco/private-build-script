#!/bin/bash

__BASE_DIR__=$(pwd)

GST_VERSION=0.10
#GST_VERSION=0.11

__f() {
	cd $__BASE_DIR__/$n
	if [ $? -eq 0 ]
	then
		git checkout origin/master
		git branch -D 0.10
		git branch -D 0.11

		git checkout origin/$GST_VERSION
		git checkout -b $GST_VERSION

		git branch --set-upstream $GST_VERSION origin/$GST_VERSION
	fi
}
	
for n in $(ls)
do
	echo $n | grep -e "^gst.*"
	if [ $? -eq 0 ]
	then
		__f
	fi

	echo $n | grep common
	if [ $? -eq 0 ]
	then
		__f
	fi
done

