#!/bin/bash

__BASE_DIR__=$(pwd)

#GST_VERSION=0.10
#GST_VERSION=0.11
GST_VERSION=$1

__f() {
	cd $__BASE_DIR__/$n
	if [ $? -eq 0 ]
	then
		echo $GST_VERSION | grep master
		if [ $? -eq 0 ]
		then
			git checkout master
			git branch --set-upstream master origin/master
		else
			git branch del
			git checkout del
			git commit -a -m "del"

			git checkout master
			git branch -D del
			git branch -D $GST_VERSION

			git checkout origin/$GST_VERSION
			git checkout -b $GST_VERSION

			git branch --set-upstream $GST_VERSION origin/$GST_VERSION
		fi
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

