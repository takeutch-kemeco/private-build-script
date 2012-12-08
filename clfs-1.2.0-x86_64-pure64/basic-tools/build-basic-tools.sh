#!/bin/bash

BASE_DIR=/mnt/clfs/sources/basic-tools
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

	export CC="${CLFS_TARGET}-gcc"
	export CXX="${CLFS_TARGET}-g++"
	export AR="${CLFS_TARGET}-ar"
	export AS="${CLFS_TARGET}-as"
	export RANLIB="${CLFS_TARGET}-ranlib"
	export LD="${CLFS_TARGET}-ld"
	export STRIP="${CLFS_TARGET}-strip"
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

	./configure --prefix=/cross-tools
	__mk
	__mk install
}

__gmp()
{
	__dcd gmp-5.0.2

	HOST_CC=gcc 				\
	CPPFLAGS=-fexceptions			\
	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}"			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
		--enable-cxx

	__mk
	__mk install
}

__mpfr()
{
	__dcd mpfr-3.0.1

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--enable-shared			\

	__mk
	__mk install
}

__mpc()
{
	__dcd mpc-0.9

	CC="${CC} ${BUILD64}"			\
	EGREP="grep -E" 			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST} 		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__ppl()
{
	__dcd ppl-0.11.2

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--enable-interfaces="c,cxx"	\
		--enable-shared 		\
		--disable-optimization		\
		--with-libgmp-prefix=/tools 	\
		--with-libgmpxx-prefix=/tools	\

	echo '#define PPL_GMP_SUPPORTS_EXCEPTIONS 1' >> confdefs.h

	__mk
	__mk install
}

__cloog-ppl()
{
	__dcd cloog-ppl-0.15.11

	cp -v configure{,.orig}
	sed -e "/LD_LIBRARY_PATH=/d" configure.orig > configure

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
	 	--host=${CLFS_TARGET}		\
		--with-bits=gmp 		\
    		--enable-shared			\
		--with-gmp=/tools		\
		--with-ppl=/tools		\

	__mk
	__mk install
}

__zlib()
{
	__dcd zlib-1.2.5

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools		\

	__mk
	__mk install
}

__binutils()
{
	__decord binutils-2.21.1a
	__cd binutils-2.21.1

	__cdbt

	CC="${CC} ${BUILD64}" 			\
	../binutils-2.21.1/configure 		\
    		--prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--target=${CLFS_TARGET}		\
		--with-lib-path=/tools/lib	\
		--disable-nls 			\
    		--enable-shared 		\
		--enable-64-bit-bfd		\
		--disable-multilib		\

	__mk configure-host
	__mk
	__mk install
}
__gcc()
{
	__dcd gcc-4.6.0

	patch -Np1 -i $SRC_DIR/gcc-4.6.0-branch_update-1.patch

	patch -Np1 -i $SRC_DIR/gcc-4.6.0-pure64_specs-1.patch

	patch -Np1 -i $SRC_DIR/gcc-4.6.0-fix-gengtype.patch

	echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
	echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

	cp -v gcc/Makefile.in{,.orig}
	sed -e 's@\(^NATIVE_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g' \
    		gcc/Makefile.in.orig > gcc/Makefile.in

	__cdbt

	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}" 		\
    	../gcc-4.6.0/configure --prefix=/tools	\
	 	--disable-multilib 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\
		--target=${CLFS_TARGET} 	\
    		--libexecdir=/tools/lib		\
		--with-local-prefix=/tools	\
		--enable-long-long 		\
    		--enable-c99 			\
		--enable-shared			\
		--enable-threads=posix		\
		--disable-nls 			\
    		--enable-__cxa_atexit		\
		--enable-languages=c,c++	\
		--disable-libstdcxx-pch		\

	cp -v Makefile{,.orig}
	sed "/^HOST_\(GMP\|PPL\|CLOOG\)\(LIBS\|INC\)/s:-[IL]/\(lib\|include\)::" \
	    	Makefile.orig > Makefile

	__mk AS_FOR_TARGET="${AS}" LD_FOR_TARGET="${LD}"
	__mk install
}

__ncurses()
{
	__dcd ncurses-5.9

	patch -Np1 -i $SRC_DIR/ncurses-5.9-bash_fix-1.patch

	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}" 		\
   	./configure --prefix=/tools		\
		--with-shared			\
		--build=${CLFS_HOST} 		\
		--host=${CLFS_TARGET}		\
		--without-debug			\
		--without-ada 			\
		--enable-overwrite		\
		--with-build-cc=gcc		\

	__mk
	__mk install
}

__bash()
{
	__dcd bash-4.2

	patch -Np1 -i $SRC_DIR/bash-4.2-branch_update-2.patch

cat > config.cache << "EOF"
ac_cv_func_mmap_fixed_mapped=yes
ac_cv_func_strcoll_works=yes
ac_cv_func_working_mktime=yes
bash_cv_func_sigsetjmp=present
bash_cv_getcwd_malloc=yes
bash_cv_job_control_missing=present
bash_cv_printf_a_format=yes
bash_cv_sys_named_pipes=present
bash_cv_ulimit_maxfds=yes
bash_cv_under_sys_siglist=yes
bash_cv_unusable_rtsigs=no
gt_cv_int_divbyzero_sigfpe=yes
EOF

	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}" 		\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\
		--without-bash-malloc		\
		--cache-file=config.cache	\

	__mk
	__mk install
	ln -sv bash /tools/bin/sh
}

__bison()
{
	__dcd bison-2.5

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__bzip2()
{
	__dcd bzip2-1.0.6

	cp -v Makefile{,.orig}
	sed -e 's@^\(all:.*\) test@\1@g' Makefile.orig > Makefile

	make CC="${CC} ${BUILD64}" AR="${AR}" RANLIB="${RANLIB}"

	make PREFIX=/tools install
}

__coreutils()
{
	__dcd coreutils-8.12

	touch man/uname.1 man/hostname.1

cat > config.cache << EOF
fu_cv_sys_stat_statfs2_bsize=yes
gl_cv_func_working_mkstemp=yes
EOF

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--enable-install-program=hostname \
		--cache-file=config.cache	\

	__mk
	__mk install
}

__diffutils()
{
	__dcd diffutils-3.0

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__findutils()
{
	__dcd findutils-4.4.2

	echo "gl_cv_func_wcwidth_works=yes" > config.cache
	echo "ac_cv_func_fnmatch_gnu=yes" >> config.cache

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
		--cache-file=config.cache	\

	__mk
	__mk install
}

__file()
{
	__dcd file-5.07

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__flex()
{
	__dcd flex-2.5.35

	patch -Np1 -i $SRC_DIR/flex-2.5.35-gcc44-1.patch

cat > config.cache << EOF
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
EOF

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--cache-file=config.cache	\

	__mk
	__mk install
}

__gawk()
{
	__dcd gawk-3.1.8

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__gettext()
{
	__dcd gettext-0.18.1.1

	cd gettext-tools

	echo "gl_cv_func_wcwidth_works=yes" > config.cache

	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}" 		\
    	./configure --prefix=/tools		\
		--disable-shared 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--cache-file=config.cache	\

	__mk -C gnulib-lib
	__mk -C src msgfmt

	cp -v src/msgfmt /tools/bin
}

__grep()
{
	__dcd grep-2.8

cat > config.cache << EOF
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
EOF

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--disable-perl-regexp		\
		--without-included-regex 	\
    		--cache-file=config.cache	\

	__mk
	__mk install
}

__gzip()
{
	__dcd gzip-1.4

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__m4()
{
	__dcd m4-1.4.16

cat > config.cache << EOF
gl_cv_func_btowc_eof=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_sanitycheck=yes
gl_cv_func_mbrtowc_null_arg=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_wcrtomb_retval=yes
gl_cv_func_wctob_works=yes
EOF

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\
    		--cache-file=config.cache	\

	__mk
	__mk install
}

__make()
{
	__dcd make-3.82

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST} 		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__patch()
{
	__dcd patch-2.6.1

	echo "ac_cv_func_strnlen_working=yes" > config.cache

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
    		--cache-file=config.cache	\

	__mk
	__mk install
}

__sed()
{
	__dcd sed-4.2.1

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__tar()
{
	__dcd tar-1.26

cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
gl_cv_func_btowc_eof=yes
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_mbrtowc_null_arg=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_wcrtomb_retval=yes
EOF

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET} 		\
   		--cache-file=config.cache	\

	__mk
	__mk install
}

__texinfo()
{
	__decord texinfo-4.13a
	__cd texinfo-4.13

	CC="${CC} ${BUILD64}" 			\
	./configure --prefix=/tools 		\
   		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk -C tools/gnulib/lib
	__mk -C tools
	__mk
	__mk install
}

__vim()
{
	__decord vim-7.3
	__cd vim73

	patch -Np1 -i $SRC_DIR/vim-7.3-branch_update-2.patch

	sed -i "/using uint32_t/s/as_fn_error/#&/" src/auto/configure

cat > src/auto/config.cache << "EOF"
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
ac_cv_sizeof_int=4
ac_cv_sizeof_long=4
ac_cv_sizeof_time_t=4
ac_cv_sizeof_off_t=4
EOF

	echo '#define SYS_VIMRC_FILE "/tools/etc/vimrc"' >> src/feature.h

	CC="${CC} ${BUILD64}" 			\
	CXX="${CXX} ${BUILD64}" 		\
	./configure --build=${CLFS_HOST}	\
		--host=${CLFS_TARGET} 		\
  		--prefix=/tools			\
		--enable-multibyte		\
		--enable-gui=no 		\
  		--disable-gtktest		\
 		--disable-xim			\
		--with-features=normal 		\
  		--disable-gpm			\
		--without-x			\
		--disable-netbeans 		\
  		--with-tlib=ncurses		\

	__mk
	__mk install

	ln -sv vim /tools/bin/vi

cat > /tools/etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
"set number
set shiftwidth=8
set tabstop=8
set ruler
syntax on

" End /etc/vimrc
EOF
}

__xz()
{
	__dcd xz-5.0.2

	CC="${CC} ${BUILD64}"			\
	./configure --prefix=/tools 		\
    		--build=${CLFS_HOST}		\
		--host=${CLFS_TARGET}		\

	__mk
	__mk install
}

__init-env

#__rem(){
__gmp
__mpfr
__mpc
__ppl
__cloog-ppl
__zlib
__binutils
__gcc
__ncurses
__bash
__bison
__bzip2
__coreutils
__diffutils
__findutils
__file
__flex
__gawk
__gettext
__grep
__gzip
__m4
__make
__patch
__sed
__tar
__texinfo
__vim
__xz

