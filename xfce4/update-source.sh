#!/bin/bash

__BASE_DIR__=$(pwd)

for __PACKAGE__ in $(ls)
do
	cd $__BASE_DIR__/$__PACKAGE__
	if [ $? -eq 0 ]
	then
#		rm $__BASE_DIR__/$__PACKAGE__/* -rf
#		git checkout master
#		rm $__BASE_DIR__/$__PACKAGE__/* -rf
#		git clone $__BASE_DIR__/$__PACKAGE__/. $__BASE_DIR__/$__PACKAGE__/b
#		mv $__BASE_DIR__/$__PACKAGE__/b/* $__BASE_DIR__/$__PACKAGE__/
#		rm $__BASE_DIR__/$__PACKAGE__/b -rf

		git pull
	fi
done

