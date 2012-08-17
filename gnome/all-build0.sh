#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

#DIST_CLEAN
DIST_CLEAN="make distclean"

__cd()
{
	echo "------------------------------"
	echo $1	
	echo "------------------------------"

	cd $1
	$DIST_CLEAN
}

for n in $(ls)
do
	__cd $BASE_DIR/$n
	if [ $? -eq 0 ]
	then
		./autogen.sh
		./configure --prefix=$PREFIX
#		if [ $? -eq 0]
#		then
			$MAKE_CLEAN
			make
			if [ $? -eq 0 ]
			then
				make install
				ldconfig
			fi
#		fi
	fi
done

exit



### memo ###

### gnome-themes
./configure --prefix=/usr --enable-all-themes --enable-test-themes --enable-placeholders


