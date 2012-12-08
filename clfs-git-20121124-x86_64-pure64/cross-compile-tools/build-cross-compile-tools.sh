#!/bin/bash

BASE_DIR=/mnt/clfs/sources/cross-compile-tools
SRC_DIR=/mnt/clfs/sources/src
. $SRC_DIR/__common-func.sh

__init-env()
{
	export CLFS="/mnt/clfs"
	export LC_ALL="POSIX"
	export BUILD64="-m64"
	export PATH="/cross-tools/bin:/bin:/usr/bin"

	export CLFS_HOST=$(echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/')
	export CLFS_TARGET="x86_64-unknown-linux-gnu"
}

__enable-gets()
{
	cp -v lib/stdio.in.h{,.orig}
	sed -e "s/^_GL_WARN_ON_USE (gets, /\/\/_GL_WARN_ON_USE (gets, /g" \
		lib/stdio.in.h.orig > lib/stdio.in.h
}

__common()
{
	__dcd $1

	__enable-gets

	./configure --prefix=/cross-tools		\
		--disable-static			\

	__mk
	__mk install
}

__linux-headers()
{
	__dcd linux-3.4.17

	install -dv /tools/include
	__mk mrproper
	__mk ARCH=x86_64 headers_check
	__mk ARCH=x86_64 INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* /tools/include
}

__file()
{
	__common file-5.11
}

__m4()
{
	__common m4-1.4.16
}

__ncurses()
{
	__dcd ncurses-5.9

	patch -Np1 -i $SRC_DIR/ncurses-5.9-bash_fix-1.patch

	./configure --prefix=/cross-tools	\
		--without-debug 		\
		--without-shared		\

	__mk -C include
	__mk -C progs tic

	install -v -m755 progs/tic /cross-tools/bin
}

__gmp()
{
	__dcd gmp-5.0.5

	CPPFLAGS=-fexceptions 			\
	./configure --prefix=/cross-tools	\
		--enable-cxx			\
		--disable-static		\

	__mk
	__mk install
}

__mpfr()
{
	__dcd mpfr-3.1.1

	LDFLAGS="-Wl,-rpath,/cross-tools/lib"	\
	./configure --prefix=/cross-tools	\
		--enable-shared			\
		--disable-static		\
		--with-gmp=/cross-tools		\

	__mk
	__mk install
}

__mpc()
{
	__dcd mpc-1.0.1

	LDFLAGS="-Wl,-rpath,/cross-tools/lib" 	\
	./configure --prefix=/cross-tools 	\
		--disable-static		\
		--with-gmp=/cross-tools 	\
    		--with-mpfr=/cross-tools	\

	__mk
	__mk install
}

__ppl()
{
	__dcd ppl-0.12.1

	CPPFLAGS="-I/cross-tools/include" 	\
    	LDFLAGS="-Wl,-rpath,/cross-tools/lib" 	\
    	./configure --prefix=/cross-tools	\
		--enable-shared 		\
		--disable-static		\
    		--enable-interfaces="c,cxx"	\
		--disable-optimization 		\
   		--with-gmp=/cross-tools 	\

	__mk
	__mk install
}

__cloog()
{
	__dcd cloog-0.16.3

	cp -v configure{,.orig}
	sed -e "/LD_LIBRARY_PATH=/d" configure.orig > configure

	LDFLAGS="-Wl,-rpath,/cross-tools/lib"	\
	./configure --prefix=/cross-tools	\
		--enable-shared			\
		--disable-static		\
    		--with-gmp-prefix=/cross-tools	\

	__mk
	__mk install
}

__binutils()
{
	__dcd binutils-2.23

	__cdbt

	AR=ar 					\
	AS=as 					\
	../binutils-2.23/configure --prefix=/cross-tools \
		--host=${CLFS_HOST}		\
		--target=${CLFS_TARGET} 	\
		--with-sysroot=${CLFS}		\
		--with-lib-path=/tools/lib	\
		--disable-nls			\
		--enable-shared			\
		--disable-static		\
  		--enable-64-bit-bfd		\
		--disable-multilib		\

	__mk configure-host
	__mk
	__mk install

	cp -v ../binutils-2.23/include/libiberty.h /tools/include
}

__gcc()
{
	__dcd gcc-4.6.3

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-branch_update-2.patch

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-pure64_specs-1.patch

	echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

	cp -v gcc/Makefile.in{,.orig}
	sed -e "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g" \
    		gcc/Makefile.in.orig > gcc/Makefile.in

	touch /tools/include/limits.h

	__cdbt

	AR=ar 					\
	LDFLAGS="-Wl,-rpath,/cross-tools/lib" 	\
	../gcc-4.6.3/configure --prefix=/cross-tools \
		--build=${CLFS_HOST}		\
		--host=${CLFS_HOST}		\
		--target=${CLFS_TARGET} 	\
  		--with-sysroot=${CLFS}		\
		--with-local-prefix=/tools	\
		--disable-nls 			\
		--disable-shared		\
		--with-mpfr=/cross-tools	\
		--with-gmp=/cross-tools 	\
		--with-ppl=/cross-tools		\
		--with-cloog=/cross-tools	\
		--without-headers		\
		--with-newlib			\
		--disable-decimal-float 	\
		--disable-libgomp		\
		--disable-libmudflap		\
		--disable-libssp 		\
  		--disable-threads		\
		--enable-languages=c		\
		--disable-multilib		\
		--enable-cloog-backend=isl	\

	__mk all-gcc all-target-libgcc
	__mk install-gcc install-target-libgcc
}

__eglibc()
{
	__dcd eglibc-2.15

	cp -v Makeconfig{,.orig}
	sed -e 's/-lgcc_eh//g' Makeconfig.orig > Makeconfig

	cp -v nss/Makefile{,.orig}
	sed -e 's/^install-others/#install-others/g' \
		nss/Makefile.orig > nss/Makefile

	__cdbt

cat > config.cache << "EOF"
libc_cv_forced_unwind=yes
libc_cv_c_cleanup=yes
libc_cv_gnu89_inline=yes
libc_cv_ssp=no
EOF

	BUILD_CC="gcc"				\
	CC="${CLFS_TARGET}-gcc ${BUILD64}" 	\
	AR="${CLFS_TARGET}-ar" 			\
	RANLIB="${CLFS_TARGET}-ranlib" 		\
      	../eglibc-2.15/configure --prefix=/tools \
      		--host=${CLFS_TARGET}		\
		--build=${CLFS_HOST} 		\
		--disable-profile		\
		--enable-add-ons 		\
		--with-tls			\
		--enable-kernel=2.6.32		\
		--with-__thread 		\
		--with-binutils=/cross-tools/bin \
		--with-headers=/tools/include 	\
		--cache-file=config.cache	\

	__mk
	__mk install
}

__gcc-final()
{
	__dcd gcc-4.6.3

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-branch_update-2.patch

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-pure64_specs-1.patch

	echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

	cp -v gcc/Makefile.in{,.orig}
	sed -e "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g" \
    		gcc/Makefile.in.orig > gcc/Makefile.in

	__cdbt

	AR=ar 					\
	LDFLAGS="-Wl,-rpath,/cross-tools/lib" 	\
	../gcc-4.6.3/configure --prefix=/cross-tools \
		--build=${CLFS_HOST}		\
		--target=${CLFS_TARGET}		\
		--host=${CLFS_HOST} 		\
		--with-sysroot=${CLFS}		\
		--with-local-prefix=/tools	\
		--disable-nls 			\
		--enable-shared			\
		--disable-static		\
		--enable-languages=c,c++	\
		--enable-__cxa_atexit 		\
		--with-mpfr=/cross-tools	\
		--with-gmp=/cross-tools		\
		--enable-c99			\
		--with-ppl=/cross-tools		\
		--with-cloog=/cross-tools 	\
		--enable-cloog-backend=isl	\
		--enable-long-long		\
		--enable-threads=posix		\
		--disable-multilib		\

	__mk AS_FOR_TARGET="${CLFS_TARGET}-as" \
		LD_FOR_TARGET="${CLFS_TARGET}-ld"

	__mk install
}

__init-env

__rem(){
__linux-headers
__file
__m4
__ncurses
__gmp
__mpfr
__mpc
__ppl
__cloog
__binutils
__gcc
}
__eglibc
__gcc-final

