#!/bin/bash

__BASE_DIR__=$(pwd)

for __PACKAGE__ in $(ls)
do
	cd $__BASE_DIR__/$__PACKAGE__
	git pull
done

