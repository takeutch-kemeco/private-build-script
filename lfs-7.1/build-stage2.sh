#/tools/bin/bash

#SRC=$LFS/sources
SRC=$(pwd)

#CFLAGS='-O4 -march=native -mtune=native -msse3'
CFLAGS=
CXXFLAGS=$CFLAGS

export SRC CFLAGS CXXFLAGS

CURBUILDAPP=

__init()
{
	touch /var/log/{btmp,lastlog,wtmp}
	chgrp -v utmp /var/log/lastlog
	chmod -v 664  /var/log/lastlog
	chmod -v 600  /var/log/btmp

	cp /tools/lib/* /lib/ -rf
}

__echo-g()
{
	COLGREEN=$'\e[1;32;1m'
	echo "$COLGREEN"$@

	COLDEF=$'\e[0m'
	echo "$COLDEF" 
}

__err()
{
	COLRED=$'\e[0;31;1m'
	echo "$COLRED"
	echo "cur build app : " $CURBUILDAPP
	echo $@

	COLDEF=$'\e[0m'
	echo "$COLDEF" 

	exit
}

__mes()
{
	__echo-g "------------------------------"
	__echo-g $1	
	__echo-g "------------------------------"
	__echo-g $2
}

__wait()
{
	__echo-g "<<< Prease enter key >>>"
	read
}

__cd()
{
	CURBUILDAPP=$1
	__mes $1 "Are you sure you want to build?"

	cd $1
	if [ $? -ne 0 ]
	then
		__err "not directory error!!"
	fi

	__wait
}

__dcd()
{
	__mes $1 "Are you sure you want to decode?"
	__wait

	cd $SRC

	BN=$(ls $1*.tar.*)
	__echo-g $BN

	case $BN in
		*.gz)  gzip  -dc $BN | tar xvf - ;;
		*.bz2) bzip2 -dc $BN | tar xvf - ;;
		*.xz)  xz    -dc $BN | tar xvf - ;;
	esac

	__cd $1
}

__cdbt()
{
	BLDTMP=$SRC/__bldtmp

	rm $BLDTMP -rf
	mkdir -v $BLDTMP
	cd $BLDTMP	
}

__mk()
{
	__echo-g "\n\n\n" $CURBUILDAPP "[ make" $@ "]"

	make $@
	if [ $? -ne 0 ]
	then
		__err "make error!!"
	fi
}

__common()
{
	__dcd $1

	./configure --prefix=/usr
	__mk
#	__mk check
	__mk install
}

__linux-header()
{
	__dcd $SRC/linux-3.2.6

	__mk mrproper

	__mk headers_check
	__mk INSTALL_HDR_PATH=dest headers_install
	find dest/include \( -name .install -o -name ..install.cmd \) -delete
	cp -rv dest/include/* /usr/include
}

__man-pages()
{
	__dcd $SRC/man-pages-3.41

	__mk install
}

__glibc()
{
	__dcd $SRC/glibc-2.14.1

	DL=$(readelf -l /bin/sh | sed -n 's@.*interpret.*/tools\(.*\)]$@\1@p')
	sed -i "s|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=$DL -o|" scripts/test-installation.pl
	unset DL

	sed -i -e 's/"db1"/& \&\& $name ne "nss_test1"/' scripts/test-installation.pl

	sed -i 's|@BASH@|/bin/bash|' elf/ldd.bash.in

	patch -Np1 -i ../glibc-2.14.1-fixes-1.patch
	patch -Np1 -i ../glibc-2.14.1-sort-1.patch

	patch -Np1 -i ../glibc-2.14.1-gcc_fix-1.patch

	sed -i '195,213 s/PRIVATE_FUTEX/FUTEX_CLOCK_REALTIME/' \
	nptl/sysdeps/unix/sysv/linux/x86_64/pthread_rwlock_timed{rd,wr}lock.S

	__cdbt

	case `uname -m` in
		i?86) echo "CFLAGS += -O2 -march=i486 -mtune=native -O3 -pipe" > configparms ;;
	esac

	../glibc-2.14.1/configure	\
		--prefix=/usr 		\
		--disable-profile 	\
		--enable-add-ons 	\
		--enable-kernel=2.6.25 	\
		--libexecdir=/usr/lib/glibc

	__mk

	cp -v ../glibc-2.14.1/iconvdata/gconv-modules iconvdata
	### not use __mk() !!
	make -k check 2>&1 | tee glibc-check-log
	grep Error glibc-check-log

	touch /etc/ld.so.conf

	__mk install

	cp -v ../glibc-2.14.1/sunrpc/rpc/*.h /usr/include/rpc
	cp -v ../glibc-2.14.1/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
	cp -v ../glibc-2.14.1/nis/rpcsvc/*.h /usr/include/rpcsvc

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
	localedef -i ja_JP -f EUC-JP ja_JP
	localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
	localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
	localedef -i zh_CN -f GB18030 zh_CN.GB18030

###	__mk localedata/install-locales
}

__glibc-config()
{
	__mes "glibc configure" ""
	__wait

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

__chain-config()
{
	__mes "chain configure" ""
	__wait

	mv -v /tools/bin/{ld,ld-old}
	mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
	mv -v /tools/bin/{ld-new,ld}
	ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

	gcc -dumpspecs | sed -e 's@/tools@@g' \
		-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
		-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > \
		`dirname $(gcc --print-libgcc-file-name)`/specs

	###test
	echo 'main(){}' > dummy.c
	cc dummy.c -v -Wl,--verbose &> dummy.log
	readelf -l a.out | grep ': /lib'

        grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

	grep -B1 '^ /usr/include' dummy.log

	grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

	grep "/lib.*/libc.so.6 " dummy.log

	grep found dummy.log

	rm -v dummy.c a.out dummy.log

        __mes "do you have this message appear in the above?" \
                "[Requesting program interpreter: /lib/ld-linux.so.2]"
	__echo-g ""
	__echo-g "/usr/lib/crt1.o succeeded"
	__echo-g "/usr/lib/crti.o succeeded"
	__echo-g "/usr/lib/crtn.o succeeded"
	__echo-g ""
	__echo-g "#include <...> search starts here:"
	__echo-g " /usr/include"
	__echo-g ""
	__echo-g 'SEARCH_DIR("/tools/i686-pc-linux-gnu/lib")'
	__echo-g 'SEARCH_DIR("/usr/lib")'
	__echo-g 'SEARCH_DIR("/lib");'
	__echo-g ""
	__echo-g "attempt to open /lib/libc.so.6 succeeded"
	__echo-g ""
	__echo-g "found ld-linux.so.2 at /lib/ld-linux.so.2"
       __wait
}

__zlib()
{
	__common zlib-1.2.7

	mv -v /usr/lib/libz.so.* /lib
	ln -sfv ../../lib/libz.so.1.2.6 /usr/lib/libz.so
}

__file()
{
	__common file-5.10
}

__binutils()
{
	__dcd binutils-2.22

	###test
	expect -c "spawn ls"
	__mes "do you have this message appear in the above?" "spawn ls"
	__wait

	###build
	rm -fv etc/standards.info
	sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

	sed -i "/exception_defines.h/d" ld/testsuite/ld-elf/new.cc
	sed -i "s/-fvtable-gc //" ld/testsuite/ld-selective/selective.exp

	__cdbt

	../binutils-2.22/configure --prefix=/usr \
		--enable-shared

	__mk tooldir=/usr

	###test
	__mk -k check

	__mk tooldir=/usr install

	cp -v ../binutils-2.22/include/libiberty.h /usr/include
}

__m4()
{
	__dcd m4-1.4.16

	__mk

	echo "exit 0" > tests/test-update-copyright.sh

	sed -i -e '41s/ENOENT/& || errno == EINVAL/' tests/test-readlink.h
	__mk check

	__mk install
}

__gmp()
{
	__dcd gmp-5.0.4

	ABI=32 ./configure --prefix=/usr \
		--enable-cxx \
		--enable-mpbsd

	__mk

	### not use __mk() !!
	make check 2>&1 | tee gmp-check-log

	awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log

	__mk install

	mkdir -v /usr/share/doc/gmp-5.0.4
	cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp-5.0.4
}

__mpfr()
{
	__dcd mpfr-3.1.0

	patch -Np1 -i ../mpfr-3.1.0-fixes-1.patch

	./configure --prefix=/usr 	\
		--enable-thread-safe 	\
		--docdir=/usr/share/doc/mpfr-3.1.0

	__mk

	__mk check

	__mk install

	__mk html
	__mk install-html
}

__mpc()
{
	__common mpc-0.9
}

__gcc()
{
	__dcd gcc-4.6.2

	sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

	case `uname -m` in
 		i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
	esac

	sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

	__cdbt

	../gcc-4.6.2/configure --prefix=/usr \
		--libexecdir=/usr/lib	\
		--enable-shared 	\
    		--enable-threads=posix	\
		--enable-__cxa_atexit 	\
    		--enable-clocale=gnu	\
		--enable-languages=c,c++ \
    		--disable-multilib 	\
		--disable-bootstrap 	\
		--with-system-zlib

	__mk

	###test
	ulimit -s 16384

	__mk -k check

	../gcc-4.6.2/contrib/test_summary | grep -A7 Summ

	###inst
	__mk install

	ln -sv ../usr/bin/cpp /lib

	ln -sv gcc /usr/bin/cc

	###test
	echo 'main(){}' > dummy.c
	cc dummy.c -v -Wl,--verbose &> dummy.log
	readelf -l a.out | grep ': /lib'

	grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

	grep -B4 '^ /usr/include' dummy.log

	grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

	grep "/lib.*/libc.so.6 " dummy.log

	grep found dummy.log

	rm -v dummy.c a.out dummy.log

	__mes "do you have this message appear in the above?" \
        	"[Requesting program interpreter: /lib/ld-linux.so.2]"
	__echo-g ""
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.6.2/../../../crt1.o succeeded"
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.6.2/../../../crti.o succeeded"
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.6.2/../../../crtn.o succeeded"
	__echo-g ""
	__echo-g "#include <...> search starts here:"
	__echo-g " /usr/local/include"
	__echo-g " /usr/lib/gcc/i686-pc-linux-gnu/4.6.2/include"
	__echo-g " /usr/lib/gcc/i686-pc-linux-gnu/4.6.2/include-fixed"
	__echo-g " /usr/include"
	__echo-g ""
	__echo-g 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib")'
	__echo-g 'SEARCH_DIR("/usr/local/lib")'
	__echo-g 'SEARCH_DIR("/lib")'
	__echo-g 'SEARCH_DIR("/usr/lib");'
	__echo-g ""
	__echo-g "attempt to open /lib/libc.so.6 succeeded"
	__echo-g ""
	__echo-g "found ld-linux.so.2 at /lib/ld-linux.so.2"
	__wait
}










rem(){
__init

__linux-header
__man-pages
__glibc
__glibc-config
__chain-config

__zlib
__file
__binutils
__m4
__gmp
__mpfr
__mpc
}
__gcc







