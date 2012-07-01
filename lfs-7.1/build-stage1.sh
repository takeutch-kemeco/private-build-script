#/bin/bash

#SRC=$LFS/sources
SRC=$(pwd)

set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=i686-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin

MAKEFLAGS='-j4'

#CFLAGS='-O4 -march=native -mtune=native -msse3'
CFLAGS=
CXXFLAGS=$CFLAGS

export SRC LFS LC_ALL LFS_TGT PATH MAKEFLAGS CFLAGS CXXFLAGS

CURBUILDAPP=

__init()
{
	mkdir -v $LFS/tools
	ln -sv $LFS/tools /
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
	__echo-g $CURBUILDAPP "[ make" $@ "]"

	make $@
	if [ $? -ne 0 ]
	then
		__err "make error!!"
	fi
}

__common()
{
	__dcd $1

	./configure --prefix=/tools
	__mk
#	__mk check
	__mk install
}

__binutils-1()
{
	__dcd $SRC/binutils-2.22

	__cdbt

	../binutils-2.22/configure 	\
		--target=$LFS_TGT 	\
		--prefix=/tools 	\
		--disable-nls 		\
		--disable-werror

	__mk

	__mk install
}

__gcc-slcp()
{
	tar -jxf ../mpfr-3.1.0.tar.bz2
	mv -v mpfr-3.1.0 mpfr
	tar -Jxf ../gmp-5.0.4.tar.xz
	mv -v gmp-5.0.4 gmp
	tar -zxf ../mpc-0.9.tar.gz
	mv -v mpc-0.9 mpc
}

__gcc-1()
{
	__dcd $SRC/gcc-4.6.2

	__gcc-slcp

	patch -Np1 -i ../gcc-4.6.2-cross_compile-1.patch

	__cdbt

	../gcc-4.6.2/configure 		\
		--target=$LFS_TGT 	\
		--prefix=/tools 	\
		--disable-nls 		\
		--disable-shared 	\
		--disable-multilib 	\
		--disable-decimal-float \
		--disable-threads 	\
		--disable-libmudflap 	\
		--disable-libssp 	\
		--disable-libgomp 	\
		--disable-libquadmath 	\
		--disable-target-libiberty \
		--disable-target-zlib 	\
		--enable-languages=c 	\
		--without-ppl 		\
		--without-cloog 	\
		--with-mpfr-include=$(pwd)/../gcc-4.6.2/mpfr/src \
		--with-mpfr-lib=$(pwd)/mpfr/src/.libs

	__mk

	__mk install

	ln -vs libgcc.a `$LFS_TGT-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`
}

__linux-header()
{
	__dcd $SRC/linux-3.2.6

	__mk mrproper

	__mk headers_check
	__mk INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* /tools/include
}

__glibc()
{
	__dcd $SRC/glibc-2.14.1

	patch -Np1 -i ../glibc-2.14.1-gcc_fix-1.patch

	patch -Np1 -i ../glibc-2.14.1-cpuid-1.patch

	__cdbt

	case `uname -m` in
		i?86) echo "CFLAGS += -O2 -march=i686 -mtune=native" > configparms ;;
	esac

	../glibc-2.14.1/configure 	\
		--prefix=/tools 	\
		--host=$LFS_TGT 	\
		--build=$(../glibc-2.14.1/scripts/config.guess) \
		--disable-profile --enable-add-ons \
		--enable-kernel=3.0	\
		--with-headers=/tools/include \
		libc_cv_forced_unwind=yes \
		libc_cv_c_cleanup=yes

	__mk

	__mk install
}

__configure()
{
	__mes "tools specs configure" ""
	__wait

	SPECS=`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/specs
	$LFS_TGT-gcc -dumpspecs | sed \
		-e 's@/lib\(64\)\?/ld@/tools&@g' \
		-e "/^\*cpp:$/{n;s,$, -isystem /tools/include,}" > $SPECS
	echo "New specs file is: $SPECS"
	unset SPECS

	###test
	echo 'main(){}' > dummy.c
	$LFS_TGT-gcc -B/tools/lib dummy.c
	readelf -l a.out | grep ': /tools'

	rm -v dummy.c a.out

	__mes "do you have this message appear in the above?" \
		"[requesting program interpreter: /tools/lib/ld-linux.so.2]"
	__wait
}

__binutils-2()
{
	__dcd $SRC/binutils-2.22

	__cdbt

	CC="$LFS_TGT-gcc -B/tools/lib/"	\
	AR=$LFS_TGT-ar 			\
	RANLIB=$LFS_TGT-ranlib 		\
	../binutils-2.22/configure	\
		--prefix=/tools 	\
		--disable-nls 		\
		--with-lib-path=/tools/lib

	__mk

	__mk install

	__mk -C ld clean
	__mk -C ld LIB_PATH=/usr/lib:/lib
	cp -v ld/ld-new /tools/bin
}

__gcc-2()
{
	__dcd $SRC/gcc-4.6.2

	patch -Np1 -i ../gcc-4.6.2-startfiles_fix-1.patch

	cp -v gcc/Makefile.in{,.orig}
	sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in

	cp -v gcc/Makefile.in{,.tmp}
	sed 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > gcc/Makefile.in

	for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
		cp -uv $file{,.orig}
		sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@g' $file.orig > $file

		echo '
#undef STANDARD_INCLUDE_DIR
#define STANDARD_INCLUDE_DIR 0
#define STANDARD_STARTFILE_PREFIX_1 ""
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file

		touch $file.orig
	done

	__gcc-slcp

	__cdbt

	CC="$LFS_TGT-gcc -B/tools/lib/" \
	AR=$LFS_TGT-ar RANLIB=$LFS_TGT-ranlib \
    	../gcc-4.6.2/configure		\
		--prefix=/tools 	\
    		--with-local-prefix=/tools \
		--enable-clocale=gnu 	\
    		--enable-shared 	\
		--enable-threads=posix 	\
    		--enable-__cxa_atexit 	\
		--enable-languages=c,c++ \
    		--disable-libstdcxx-pch \
		--disable-multilib 	\
    		--disable-bootstrap 	\
		--disable-libgomp 	\
    		--without-ppl 		\
		--without-cloog 	\
    		--with-mpfr-include=$(pwd)/../gcc-4.6.2/mpfr/src \
    		--with-mpfr-lib=$(pwd)/mpfr/src/.libs

	__mk

	__mk install

	ln -vs gcc /tools/bin/cc

	###test
	echo 'main(){}' > dummy.c
	cc dummy.c
	readelf -l a.out | grep ': /tools'

	rm -v dummy.c a.out

	__mes "do you have this message appear in the above?" \
		"[requesting program interpreter: /tools/lib/ld-linux.so.2]"
	__wait
}

__tcl()
{
	__dcd $SRC/tcl8.5.11

	cd unix
	./configure --prefix=/tools

	__mk

#	TZ=UTC __mk test

	__mk install

	chmod -v u+w /tools/lib/libtcl8.5.so

	__mk install-private-headers

	ln -sv tclsh8.5 /tools/bin/tclsh
}

__expect()
{
	__dcd $SRC/expect5.45

	cp -v configure{,.orig}
	sed 's:/usr/local/bin:/bin:' configure.orig > configure

	./configure --prefix=/tools 	\
		--with-tcl=/tools/lib 	\
		--with-tclinclude=/tools/include

	__mk

#	__mk test

	__mk SCRIPTS="" install
}

__dejagnu()
{
	__common $SRC/dejagnu-1.5
}

__check()
{
	__common $SRC/check-0.9.8
}

__ncurses()
{
	__dcd $SRC/ncurses-5.9

	./configure --prefix=/tools 	\
		--with-shared 		\
    		--without-debug 	\
		--without-ada 		\
		--enable-overwrite

	__mk

	__mk install
}

__bash()
{
	__dcd $SRC/bash-4.2

	patch -Np1 -i ../bash-4.2-fixes-4.patch	

	./configure --prefix=/tools 	\
		--without-bash-malloc

	__mk

#	__mk tests

	__mk install

	ln -vs bash /tools/bin/sh
}

__bzip2()
{
	__dcd $SRC/bzip2-1.0.6

	__mk

	__mk PREFIX=/tools install
}

__coreutils()
{
	__dcd $SRC/coreutils-8.15

	./configure --prefix=/tools 	\
		--enable-install-program=hostname

	__mk

#	__mk RUN_EXPENSIVE_TESTS=yes check

	__mk install

	cp -v src/su /tools/bin/su-tools
}

__diffutils()
{
	__common $SRC/diffutils-3.2
}

__file()
{
	__common $SRC/file-5.10
}

__findutils()
{
	__common $SRC/findutils-4.4.2
}

__gawk()
{
	__common $SRC/gawk-4.0.0
}

__gettext()
{
	__dcd $SRC/gettext-0.18.1.1

	cd gettext-tools
	./configure --prefix=/tools 	\
		--disable-shared

	__mk -C gnulib-lib
	__mk -C src msgfmt

	cp -v src/msgfmt /tools/bin
}

__grep()
{
	__dcd $SRC/grep-2.10

	./configure --prefix=/tools 	\
		--disable-perl-regexp

	__mk

#	__mk check

	__mk install
}

__gzip()
{
	__common $SRC/gzip-1.4
}

__m4()
{
	__common $SRC/m4-1.4.16
}

__make()
{
	__common $SRC/make-3.82
}

__patch()
{
	__common $SRC/patch-2.6.1
}

__perl()
{
	__dcd perl-5.14.2

	patch -Np1 -i ../perl-5.14.2-libc-1.patch

	sh Configure -des -Dprefix=/tools

	__mk

	cp -v perl cpan/podlators/pod2man /tools/bin
	mkdir -pv /tools/lib/perl5/5.14.2
	cp -Rv lib/* /tools/lib/perl5/5.14.2
}

__sed()
{
	__common $SRC/sed-4.2.1
}

__tar()
{
	__common $SRC/tar-1.26
}

__texinfo()
{
	__common $SRC/texinfo-4.13
}

__xz()
{
	__common $SRC/xz-5.0.3
}

__strip()
{
	__mes "build compleate" ""
	__mes "Are you sure you want to strip?" ""
	__wait

	strip --strip-debug /tools/lib/*
	strip --strip-unneeded /tools/{,s}bin/*

	rm -rf /tools/{,share}/{info,man,doc}
}

__backup()
{
	__mes "Are you sure you want to backup?" ""
	__wait

	cd $LFS
	ls
	tar cvf tools.$(date +"%Y%m%y").tar tools
#	xz tools.tar
}

rem(){
__init

__binutils-1
__gcc-1

__linux-header
__glibc
__configure
__binutils-2
__gcc-2
}
###__tcl
__expect
__dejagnu
__check

__ncurses
__bash
__bzip2
__coreutils
__diffutils
__file
__findutils
__gawk
__gettext
__grep
__gzip
__m4
__make
__patch
__perl
__sed
__tar
__texinfo
__xz

__strip
__backup

