#!/bin/bash

PREFIX=/usr
__BASE_DIR__=$(pwd)
__MAKE_CLEAN__=
#__MAKE_CLEAN__="make clean"

__ERROR_LOG__=$__BASE_DIR__/error.log
echo > $__ERROR_LOG__

for __PACKAGE__ in $(ls)
do
	cd $__BASE_DIR__/$__PACKAGE__

	if [ $? -eq 0 ]
	then
		./autogen.sh --prefix=$PREFIX --enable-gtk-doc --enable-xinput --with-x

		$__MAKE_CLEAN__
		make
		if [ $? -eq 0 ]
		then
			make install
			ldconfig
		else
			echo $__PACKAGE__ >> $__ERROR_LOG__
		fi
	fi

	cd $__BASE_DIR__
done



exit

### memo ####
### bullet
cmake -DCMAKE_INSTALL_PREFIX=/usr . -G "Unix Makefiles"
make
make install
のあとに、/usr/local/以下へとインストールされたincludeやpkgconfig等を/usr/以下へ手動で移動する

