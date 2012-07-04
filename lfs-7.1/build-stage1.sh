#/bin/bash

SRC=$(pwd)

MAKEFLAGS="-j2"

CFLAGS="-O4 -march=native -mtune=native -msse3"
CXXFLAGS=$CFLAGS

export SRC MAKEFLAGS CFLAGS CXXFLAGS

. __common-func.sh

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

	patch -Np1 -i ../binutils-2.22-build_fix-1.patch

	__cdbt

	../binutils-2.22/configure         \
		--prefix=/tools            \
		--with-sysroot=$LFS        \
		--with-lib-path=/tools/lib \
		--target=$LFS_TGT          \
		--disable-nls              \
		--disable-werror

	__mk

	__mk install
}

__gcc-slcp()
{
	tar -jxf ../mpfr-3.1.0.tar.bz2
	mv -v mpfr-3.1.0 mpfr
	tar -Jxf ../gmp-5.0.5.tar.xz
	mv -v gmp-5.0.5 gmp
	tar -zxf ../mpc-0.9.tar.gz
	mv -v mpc-0.9 mpc
}

__gcc-1()
{
	__dcd $SRC/gcc-4.7.1

	__gcc-slcp

	for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
		cp -uv $file{,.orig}
		sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
			-e 's@/usr@/tools@g' $file.orig > $file

echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file

		touch $file.orig
	done

	__cdbt

	../gcc-4.7.1/configure         \
	    --target=$LFS_TGT          \
	    --prefix=/tools            \
	    --with-sysroot=$LFS        \
	    --with-newlib              \
	    --without-headers          \
	    --with-local-prefix=/tools \
	    --with-native-system-header-dir=/tools/include \
	    --disable-nls              \
	    --disable-shared           \
	    --disable-multilib         \
	    --disable-decimal-float    \
	    --disable-threads          \
	    --disable-libmudflap       \
	    --disable-libssp           \
	    --disable-libgomp          \
	    --disable-libquadmath      \
	    --enable-languages=c       \
	    --with-mpfr-include=$(pwd)/../gcc-4.7.1/mpfr/src \
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
	__dcd $SRC/glibc-2.15

	sed -i 's#$ac_includes_default#\n\n#' sysdeps/i386/configure

	sed -i 's#/var/db#/tools/var/db#' Makeconfig

	patch -Np1 -i ../glibc-2.15-gcc_fix-1.patch

	case `uname -m` in
		i?86) echo "CFLAGS += -O4 -march=native -mtune=native -msse3" > configparms ;;
	esac

	__cdbt

	../glibc-2.15/configure		\
	      --prefix=/tools		\
	      --host=$LFS_TGT		\
	      --build=$(../glibc-2.15/scripts/config.guess) \
	      --disable-profile		\
	      --enable-add-ons		\
	      --enable-kernel=3.1	\
	      --with-headers=/tools/include \
	      libc_cv_forced_unwind=yes	\
	      libc_cv_ctors_header=yes	\
	      libc_cv_c_cleanup=yes

	__mk

	__mk install
}

__configure()
{
	__mes "tools specs configure" ""
	__wait

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

	patch -Np1 -i ../binutils-2.22-build_fix-1.patch

	__cdbt

	CC=$LFS_TGT-gcc            	\
	AR=$LFS_TGT-ar             	\
	RANLIB=$LFS_TGT-ranlib     	\
	../binutils-2.22/configure 	\
		--prefix=/tools        	\
		--disable-nls          	\
		--with-lib-path=/tools/lib

	__mk

	__mk install

	__mk -C ld clean
	__mk -C ld LIB_PATH=/usr/lib:/lib
	cp -v ld/ld-new /tools/bin
}

__gcc-2()
{
	__dcd $SRC/gcc-4.7.1

	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
		`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

	cp -v gcc/Makefile.in{,.tmp}
	sed 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > gcc/Makefile.in

	for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
		cp -uv $file{,.orig}
		sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
			-e 's@/usr@/tools@g' $file.orig > $file

echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file

		touch $file.orig
	done

	__gcc-slcp

	__cdbt

	CC=$LFS_TGT-gcc \
	AR=$LFS_TGT-ar                  \
	RANLIB=$LFS_TGT-ranlib          \
	../gcc-4.7.1/configure          \
	    --prefix=/tools             \
	    --with-local-prefix=/tools  \
	    --with-native-system-header-dir=/tools/include \
	    --enable-clocale=gnu        \
	    --enable-shared             \
	    --enable-threads=posix      \
	    --enable-__cxa_atexit       \
	    --enable-languages=c,c++    \
	    --disable-libstdcxx-pch     \
	    --disable-multilib          \
	    --disable-bootstrap         \
	    --disable-libgomp           \
	    --with-mpfr-include=$(pwd)/../gcc-4.7.1/mpfr/src \
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

	### not use __mk() !!
	make install

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
	__dcd $SRC/perl-5.14.2

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
        __dcd $SRC/tar-1.26

        ./configure --prefix=/tools \
		FORCE_UNSAFE_CONFIGURE=1

        __mk

#       __mk check

        __mk install
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

#rem(){
__binutils-1
__gcc-1

__linux-header
__glibc
__configure
__binutils-2
__gcc-2

__tcl
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

