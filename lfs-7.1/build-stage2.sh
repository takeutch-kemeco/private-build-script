#/bin/bash

SRC=$LFS/sources
MAKEFLAGS=

__cd()
{
	echo "------------------------------"
	echo $1	
	echo "------------------------------"
	
	cd $1
	if [ $? -ne 0 ]
	then
		cd error
		exit
	fi

	echo "Are you sure you want to build?"
	read
}

__dcd()
{
	echo "------------------------------"
	echo $1	
	echo "------------------------------"
	echo "Are you sure you want to decode?"
	read

	cd $SRC
	rm $1 -rf

	ls $1.tar.gz
	if [ $? -eq 0 ]
	then
		gzip -dc $1.tar.gz | tar xvf -
	fi

	ls $1.tar.bz2
	if [ $? -eq 0 ]
	then
		bzip2 -dc $1.tar.bz2 | tar xvf -
	fi

	ls $1.tar.xz
	if [ $? -eq 0 ]
	then
		xz -dc $1.tar.xz | tar xvf -
	fi

	###tcl
	ls $1-src.tar.gz
	if [ $? -eq 0 ]
	then
		gzip -dc $1-src.tar.gz | tar xvf -
	fi

	###texinfo
	ls $1a.tar.gz
	if [ $? -eq 0 ]
	then
		gzip -dc $1a.tar.gz | tar xvf -
	fi

	__cd $1
}

__linux-header()
{
	cd $SRC/linux-3.4.3

	make mrproper

	make headers_check
	make INSTALL_HDR_PATH=dest headers_install
	find dest/include \( -name .install -o -name ..install.cmd \) -delete
	cp -rv dest/include/* /usr/include
}

__man-pages()
{
	__dcd man-pages-3.41

	make install
}

__glibc()
{
	__dcd glibc-2.15

	DL=$(readelf -l /bin/sh | sed -n 's@.*interpret.*/tools\(.*\)]$@\1@p')
	sed -i "s|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=$DL -o|" \
        scripts/test-installation.pl
	unset DL

	sed -i -e 's/"db1"/& \&\& $name ne "nss_test1"/' scripts/test-installation.pl

	sed -i 's|@BASH@|/bin/bash|' elf/ldd.bash.in

	patch -Np1 -i ../glibc-2.15-fixes-1.patch

	patch -Np1 -i ../glibc-2.15-gcc_fix-1.patch

	rm ../glibc-build -rf
	mkdir -v ../glibc-build
	cd ../glibc-build

	case `uname -m` in
		i?86) echo "CFLAGS += -march=i686 -mtune=native -O3 -pipe" > configparms ;;
	esac

	../glibc-2.15/configure		\
		--prefix=/usr		\
		--disable-profile       \
		--enable-add-ons        \
		--enable-kernel=3.4     \
		--libexecdir=/usr/lib/glibc

	make

	###test
	cp -v ../glibc-2.15/iconvdata/gconv-modules iconvdata
	make -k check 2>&1 | tee glibc-check-log
	grep Error glibc-check-log

	touch /etc/ld.so.conf

	make install

	cp -v ../glibc-2.15/sunrpc/rpc/*.h /usr/include/rpc
	cp -v ../glibc-2.15/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
	cp -v ../glibc-2.15/nis/rpcsvc/*.h /usr/include/rpcsvc

	mkdir -pv /usr/lib/locale
	localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
	localedef -i de_DE -f ISO-8859-1 de_DE
	localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
	localedef -i de_DE -f UTF-8 de_DE.UTF-8
	localedef -i en_HK -f ISO-8859-1 en_HK
	localedef -i en_PH -f ISO-8859-1 en_PH
	localedef -i en_US -f ISO-8859-1 en_US
	localedef -i en_US -f UTF-8 en_US.UTF-8
	localedef -i es_MX -f ISO-8859-1 es_MX
	localedef -i fa_IR -f UTF-8 fa_IR
	localedef -i fr_FR -f ISO-8859-1 fr_FR
	localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
	localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
	localedef -i it_IT -f ISO-8859-1 it_IT
	localedef -i ja_JP -f EUC-JP ja_JP.EUC-JP
	localedef -e ja_JP -f UTF-8 ja_JP.UTF-8
	localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
	localedef -i zh_CN -f GB18030 zh_CN.GB18030

cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

	tzselect

	cp -v --remove-destination /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF

	mkdir /etc/ld.so.conf.d
}

__config()
{
	echo "------------------------------"
	echo "spec text"
	echo "------------------------------"

	mv -v /tools/bin/{ld,ld-old}
	mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
	mv -v /tools/bin/{ld-new,ld}
	ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

	gcc -dumpspecs | sed -e 's@/tools@@g' \
		-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
		-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > \
		`dirname $(gcc --print-libgcc-file-name)`/specs

	echo 'main(){}' > dummy.c
	cc dummy.c -v -Wl,--verbose &> dummy.log
	readelf -l a.out | grep ': /lib'
exit
	grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
	
	grep -B1 '^ /usr/include' dummy.log

	grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

	grep "/lib.*/libc.so.6 " dummy.log

	grep found dummy.log
	
	echo "------------------------------"
	echo "spec text OK?"
	echo ""
	echo "[Requesting program interpreter: /lib/ld-linux.so.2]"
	echo ""
	echo "/usr/lib/crt1.o succeeded"
	echo "/usr/lib/crti.o succeeded"
	echo "/usr/lib/crtn.o succeeded"
	echo ""
	echo "#include <...> search starts here:"
	echo "/usr/include"
	echo ""
	echo 'SEARCH_DIR("/tools/i686-pc-linux-gnu/lib")'
	echo 'SEARCH_DIR("/usr/lib")'
	echo 'SEARCH_DIR("/lib");'
	echo ""
	echo "attempt to open /lib/libc.so.6 succeeded"
	echo ""
	echo "found ld-linux.so.2 at /lib/ld-linux.so.2"
	echo "------------------------------"
	read

	rm -v dummy.c a.out dummy.log
}




rem(){
__linux-header
__man-pages
__glibc
}
__config





