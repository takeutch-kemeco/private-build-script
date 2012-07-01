#!/bin/bash

BASE_DIR=$(pwd)

__cd()
{
	echo "------------------------------"
	echo $1	
	echo "------------------------------"

	cd $1
}

for __PACKAGE__ in $(ls -F | grep / | sed -e "s/\/$//g")
do
	__cd $BASE_DIR/$__PACKAGE__
	if [ $? -eq 0 ]
	then
#		rm $BASE_DIR/$__PACKAGE__/* -rf
#		git checkout master
#		rm $BASE_DIR/$__PACKAGE__/* -rf
#		git clone $BASE_DIR/$__PACKAGE__/. $BASE_DIR/$__PACKAGE__/b
#		mv $BASE_DIR/$__PACKAGE__/b/* $BASE_DIR/$__PACKAGE__/
#		rm $BASE_DIR/$__PACKAGE__/b -rf

		git pull
	fi
done

