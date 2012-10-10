#/tools/bin/bash

SRC=$(pwd)

CFLAGS="-O4 -march=native -mtune=native -msse3"
CXXFLAGS=$CFLAGS

export SRC CFLAGS CXXFLAGS

. __common-func.sh

__init()
{
	touch /var/log/{btmp,lastlog,wtmp}
	chgrp -v utmp /var/log/lastlog
	chmod -v 664  /var/log/lastlog
	chmod -v 600  /var/log/btmp

#	cp /tools/lib/* /lib/ -rf
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
	__dcd $SRC/linux-3.5

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
	__dcd $SRC/glibc-2.16.0

	sed -i 's#<rpc/types.h>#"rpc/types.h"#' sunrpc/rpc_clntout.c

	sed -i '/test-installation.pl/d' Makefile

	sed -i 's|@BASH@|/bin/bash|' elf/ldd.bash.in

	__cdbt

	case `uname -m` in
		i?86) echo "CFLAGS += -O4 -march=native -mtune=native -msse3 -pipe" > configparms ;;
	esac

	../glibc-2.16.0/configure  	\
 		--prefix=/usr          	\
    		--disable-profile      	\
    		--enable-add-ons       	\
    		--enable-kernel=3.1 	\
    		--libexecdir=/usr/lib/glibc

	__mk

	cp -v ../glibc-2.16.0/iconvdata/gconv-modules iconvdata
	make -k check 2>&1 | tee glibc-check-log
	grep Error glibc-check-log

	touch /etc/ld.so.conf

	__mk install

	cp -v ../glibc-2.16.0/sunrpc/rpc/*.h /usr/include/rpc
	cp -v ../glibc-2.16.0/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
	cp -v ../glibc-2.16.0/nis/rpcsvc/*.h /usr/include/rpcsvc

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

#/opt/lib
#/usr/local/lib
/usr/lib
/lib

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
	__common $SRC/zlib-1.2.7

	mv -v /usr/lib/libz.so.* /lib
	ln -sfv ../../lib/libz.so.1.2.7 /usr/lib/libz.so
}

__file()
{
	__common $SRC/file-5.11
}

__binutils()
{
	__dcd $SRC/binutils-2.22

	###test
	expect -c "spawn ls"
	__mes "do you have this message appear in the above?" "spawn ls"
	__wait

	###build
	rm -fv etc/standards.info
	sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

	patch -Np1 -i ../binutils-2.22-build_fix-1.patch

	__cdbt

	../binutils-2.22/configure --prefix=/usr \
		--enable-shared

	__mk tooldir=/usr

	###test
	__mk -k check

	__mk tooldir=/usr install

	cp -v ../binutils-2.22/include/libiberty.h /usr/include
}

__gmp()
{
	__dcd $SRC/gmp-5.0.5

	ABI=32				\
	./configure --prefix=/usr	\
		--enable-cxx		\
		--enable-mpbsd

	__mk

	### not use __mk() !!
	make check 2>&1 | tee gmp-check-log

	awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log

	__mk install

	mkdir -v /usr/share/doc/gmp-5.0.5
	cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/gmp-5.0.5
}

__mpfr()
{
	__dcd $SRC/mpfr-3.1.1

	./configure --prefix=/usr 	\
		--enable-thread-safe 	\
		--docdir=/usr/share/doc/mpfr-3.1.1

	__mk

	__mk check

	__mk install

	__mk html
	__mk install-html
}

__mpc()
{
	__common $SRC/mpc-1.0
}

__gcc()
{
	__dcd $SRC/gcc-4.7.1

	sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

	case `uname -m` in
		i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
	esac

	__cdbt

	../gcc-4.7.1/configure --prefix=/usr            \
	                       --libexecdir=/usr/lib    \
	                       --enable-shared          \
	                       --enable-threads=posix   \
	                       --enable-__cxa_atexit    \
	                       --enable-clocale=gnu     \
	                       --enable-languages=c,c++,fortran \
	                       --disable-multilib       \
	                       --disable-bootstrap      \
	                       --with-system-zlib

	__mk

	###test
	ulimit -s 16384

	### not use __mk() !!
	make -k check

	../gcc-4.7.1/contrib/test_summary | grep -A7 Summ

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
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.7.1/../../../crt1.o succeeded"
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.7.1/../../../crti.o succeeded"
	__echo-g "/usr/lib/gcc/i686-pc-linux-gnu/4.7.1/../../../crtn.o succeeded"
	__echo-g ""
	__echo-g "#include <...> search starts here:"
	__echo-g " /usr/lib/gcc/i686-pc-linux-gnu/4.7.1/include"
	__echo-g " /usr/lib/gcc/i686-pc-linux-gnu/4.7.1/include-fixed"
	__echo-g " /usr/include"
	__echo-g ""
	__echo-g 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib")'
	__echo-g 'SEARCH_DIR("/lib")'
	__echo-g 'SEARCH_DIR("/usr/lib");'
	__echo-g ""
	__echo-g "attempt to open /lib/libc.so.6 succeeded"
	__echo-g ""
	__echo-g "found ld-linux.so.2 at /lib/ld-linux.so.2"
	__wait
}

__sed()
{
	__dcd $SRC/sed-4.2.1

	./configure --prefix=/usr 	\
		--bindir=/bin 		\
		--htmldir=/usr/share/doc/sed-4.2.1

	__mk

	__mk html

	__mk check

	__mk install

	__mk -C doc install-html
}

__bzip2()
{
	__dcd $SRC/bzip2-1.0.6

	patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch

	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

	__mk -f Makefile-libbz2_so
	__mk clean

	__mk

	__mk PREFIX=/usr install

	cp -v bzip2-shared /bin/bzip2
	cp -av libbz2.so* /lib
	ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
	rm -v /usr/bin/{bunzip2,bzcat,bzip2}
	ln -sv bzip2 /bin/bunzip2
	ln -sv bzip2 /bin/bzcat
}

__pkg-config()
{
	__dcd $SRC/pkg-config-0.27

	./configure --prefix=/usr	\
		--with-internal-glib	\
		--docdir=/usr/share/doc/pkg-config-0.27

	__mk

	__mk check

	__mk install
}

__ncurses()
{
	__dcd $SRC/ncurses-5.9

	./configure --prefix=/usr 	\
		--with-shared 		\
		--without-debug 	\
		--enable-widec

	__mk

	__mk install

	mv -v /usr/lib/libncursesw.so.5* /lib

	ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so

	for lib in ncurses form panel menu
	do
    		rm -vf /usr/lib/lib${lib}.so
    		echo "INPUT(-l${lib}w)" >/usr/lib/lib${lib}.so
		ln -sfv lib${lib}w.a /usr/lib/lib${lib}.a
	done
	ln -sfv libncurses++w.a /usr/lib/libncurses++.a

	rm -vf /usr/lib/libcursesw.so
	echo "INPUT(-lncursesw)" >/usr/lib/libcursesw.so
	ln -sfv libncurses.so /usr/lib/libcurses.so
	ln -sfv libncursesw.a /usr/lib/libcursesw.a
	ln -sfv libncurses.a /usr/lib/libcurses.a

	mkdir -v       /usr/share/doc/ncurses-5.9
	cp -v -R doc/* /usr/share/doc/ncurses-5.9
}

__util-linux()
{
	__dcd $SRC/util-linux-2.21.2

	sed -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' -i $(grep -rl '/etc/adjtime' .)
	mkdir -pv /var/lib/hwclock

	./configure

	__mk

	__mk install
}

__psmisc()
{
	__common $SRC/psmisc-22.19

	mv -v /usr/bin/fuser /bin
	mv -v /usr/bin/killall /bin
}

__e2fsprogs()
{
	__dcd $SRC/e2fsprogs-1.42.5

	mkdir -v build
	cd build

	../configure --prefix=/usr 	\
		--with-root-prefix="" 	\
		--enable-elf-shlibs	\
		--disable-libblkid	\
		--disable-libuuid	\
		--disable-uuidd		\
		--disable-fsck

	__mk

	### not use __mk() !!
	make check

	__mk install

	__mk install-libs

	chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

	gunzip -v /usr/share/info/libext2fs.info.gz
	install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

	makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
	install -v -m644 doc/com_err.info /usr/share/info
	install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
}

__coreutils()
{
	__dcd $SRC/coreutils-8.17

	sed -i -e 's/! isatty/isatty/' \
	       -e '45i\              || errno == ENOENT' gnulib-tests/test-getlogin.c

	patch -Np1 -i ../coreutils-8.17-i18n-1.patch

	FORCE_UNSAFE_CONFIGURE=1 ./configure \
            	--prefix=/usr         	\
            	--libexecdir=/usr/lib 	\
            	--enable-no-install-program=kill,uptime

	__mk

	make NON_ROOT_USERNAME=nobody check-root

	echo "dummy:x:1000:nobody" >> /etc/group

	chown -Rv nobody .

	su nobody -s /bin/bash -c "make RUN_EXPENSIVE_TESTS=yes -k check || true"	

	sed -i '/dummy/d' /etc/group

	__mk install

	mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
	mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
	mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
	mv -v /usr/bin/chroot /usr/sbin
	mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
	sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

	mv -v /usr/bin/{head,sleep,nice} /bin
}

__iana-etc()
{
	__common $SRC/iana-etc-2.30
}

__m4()
{
	__dcd $SRC/m4-1.4.16

	sed -i -e '/gets is a/d' lib/stdio.in.h

	./configure --prefix=/usr

	__mk

	sed -i -e '41s/ENOENT/& || errno == EINVAL/' tests/test-readlink.h
	### not use __mk() !!
	make check

	__mk install
}

__bison()
{
	__dcd $SRC/bison-2.6.2

	./configure --prefix=/usr

	echo '#define YYENABLE_NLS 1' >> lib/config.h

	__mk

	__mk check

	__mk install
}

__procps()
{
	__dcd $SRC/procps-3.2.8

	patch -Np1 -i ../procps-3.2.8-fix_HZ_errors-1.patch

	patch -Np1 -i ../procps-3.2.8-watch_unicode-1.patch

	sed -i -e 's@\*/module.mk@proc/module.mk ps/module.mk@' Makefile

	__mk

	__mk install
}

__grep()
{
	__dcd $SRC/grep-2.13

	./configure --prefix=/usr	\
		--bindir=/bin

	__mk

	__mk check

	__mk install
}

__readline()
{
	__dcd $SRC/readline-6.2

	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install

	patch -Np1 -i ../readline-6.2-fixes-1.patch

	./configure --prefix=/usr	\
		--libdir=/lib

	__mk SHLIB_LIBS=-lncurses

	__mk install

	mv -v /lib/lib{readline,history}.a /usr/lib

	rm -v /lib/lib{readline,history}.so
	ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
	ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

	mkdir -v /usr/share/doc/readline-6.2
	install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-6.2
}

__bash()
{
	__dcd $SRC/bash-4.2

	patch -Np1 -i ../bash-4.2-fixes-8.patch

	./configure --prefix=/usr	\
		--bindir=/bin		\
		--htmldir=/usr/share/doc/bash-4.2 \
		--without-bash-malloc	\
		--with-installed-readline

	__mk

	###test
#	chown -Rv nobody .

#	su-tools nobody -s /bin/bash -c "make tests"
#	__mk tests

	__mk install

###	exec /bin/bash --login +h
}

__libtool()
{
	__common $SRC/libtool-2.4.2
}

__gdbm()
{
	__dcd $SRC/gdbm-1.10

	./configure --prefix=/usr	\
		--enable-libgdbm-compat

	__mk

	__mk check

	__mk install
}

__inetutils()
{
	__dcd $SRC/inetutils-1.9.1

	sed -i -e '/gets is a/d' lib/stdio.in.h

	./configure --prefix=/usr	\
		--libexecdir=/usr/sbin	\
		--localstatedir=/var	\
		--disable-logger	\
		--disable-syslogd	\
		--disable-whois		\
		--disable-servers

	__mk

	### not use __mk() !!
	make check

	__mk install
	__mk -C doc html
	__mk -C doc install-html docdir=/usr/share/doc/inetutils-1.9.1

	mv -v /usr/bin/{hostname,ping,ping6} /bin
	mv -v /usr/bin/traceroute /sbin
}

__perl()
{
	__dcd $SRC/perl-5.16.0

	echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

	sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|"           \
	       -e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	       -e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|"         \
	    cpan/Compress-Raw-Zlib/config.in

	sh Configure -des -Dprefix=/usr		\
		-Dvendorprefix=/usr           	\
		-Dman1dir=/usr/share/man/man1 	\
		-Dman3dir=/usr/share/man/man3 	\
		-Dpager="/usr/bin/less -isR"  	\
		-Duseshrplib

	sed -i '/test-installation.pl/d' Makefile

	make

	### not use __mk() !!
#	make test

	__mk install
}

__autoconf()
{
	__common $SRC/autoconf-2.69
}

__automake()
{
	__dcd $SRC/automake-1.12.2

	sed -i -e '48i$sleep' t/aclocal7.sh

	./configure --prefix=/usr	\
		--docdir=/usr/share/doc/automake-1.12.2

	__mk

#	__mk check

	__mk install
}

__diffutils()
{
	__dcd $SRC/diffutils-3.2

	sed -i -e '/gets is a/d' lib/stdio.in.h

	./configure --prefix=/usr

	__mk

#	__mk check

	__mk install
}

__gawk()
{
	__dcd $SRC/gawk-4.0.1

	./configure --prefix=/usr	\
		--libexecdir=/usr/lib

	__mk

#	__mk check

	__mk install

	mkdir -v /usr/share/doc/gawk-4.0.1
	cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.0.1
}

__findutils()
{
	__dcd $SRC/findutils-4.4.2

	./configure --prefix=/usr	\
		--libexecdir=/usr/lib/findutils \
		--localstatedir=/var/lib/locate

	__mk

	__mk check

	__mk install
}

__flex()
{
	__dcd $SRC/flex-2.5.35

	patch -Np1 -i ../flex-2.5.35-gcc44-1.patch

	./configure --prefix=/usr 	\
		--mandir=/usr/share/man	\
		--infodir=/usr/share/info

	__mk

#	__mk check

	__mk install

	ln -sv libfl.a /usr/lib/libl.a

cat > /usr/bin/lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF

	chmod -v 755 /usr/bin/lex

	mkdir -v /usr/share/doc/flex-2.5.35
	cp -v doc/flex.pdf /usr/share/doc/flex-2.5.35
}

__gettext()
{
	__dcd $SRC/gettext-0.18.1.1

	sed -i -e '/gets is a/d' gettext-*/*/stdio.in.h

	./configure --prefix=/usr	\
        	--docdir=/usr/share/doc/gettext-0.18.1.1

	__mk

	__mk check

	__mk install
}

__groff()
{
	__dcd $SRC/groff-1.21

	PAGE=A4 ./configure --prefix=/usr

	__mk

	__mk install

	ln -sv eqn /usr/bin/geqn
	ln -sv tbl /usr/bin/gtbl
}

__xz()
{
	__dcd $SRC/xz-5.0.4

	./configure --prefix=/usr	\
		--libdir=/lib		\
		--docdir=/usr/share/doc/xz-5.0.4

	__mk

	__mk check

	__mk pkgconfigdir=/usr/lib/pkgconfig install
}

__grub()
{
	__dcd $SRC/grub-2.00

	sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

	./configure --prefix=/usr	\
        	--sysconfdir=/etc      	\
             	--disable-grub-emu-usb 	\
             	--disable-efiemu

	__mk

	__mk install
}

__less()
{
	__dcd $SRC/less-444

	./configure --prefix=/usr	\
		--sysconfdir=/etc

	__mk

	__mk install
}

__gzip()
{
	__dcd $SRC/gzip-1.5

	./configure --prefix=/usr	\
		--bindir=/bin

	__mk

	__mk check

	__mk install

	mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
	mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
}

__iproute()
{
	__dcd $SRC/iproute2-3.5.0

	sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
	sed -i /ARPD/d Makefile
	rm man/man8/arpd.8

	sed -i -e '/netlink\//d' ip/ipl2tp.c

	__mk DESTDIR=

	__mk DESTDIR= MANDIR=/usr/share/man DOCDIR=/usr/share/doc/iproute2-3.5.0 install
}

__kbd()
{
	__dcd $SRC/kbd-1.15.3

	patch -Np1 -i ../kbd-1.15.3-upstream_fixes-1.patch
	
	patch -Np1 -i ../kbd-1.15.3-backspace-1.patch

	sed -i '/guardado\ el/s/\(^.*en\ %\)\(.*\)/\14\$\2/' po/es.po

	sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/' configure &&
	sed -i 's/resizecons.8 //' man/man8/Makefile.in &&
	touch -d '2011-05-07 08:30' configure.ac

	./configure --prefix=/usr	\
		--datadir=/lib/kbd

	__mk

	__mk install

	mv -v /usr/bin/{kbd_mode,loadkeys,openvt,setfont} /bin

	mkdir -v /usr/share/doc/kbd-1.15.3
	cp -R -v doc/* /usr/share/doc/kbd-1.15.3
}

__kmod()
{
	__dcd $SRC/kmod-9

	patch -Np1 -i ../kmod-9-testsuite-1.patch

	./configure --prefix=/usr	\
            	--bindir=/bin       	\
            	--libdir=/lib       	\
            	--sysconfdir=/etc   	\
            	--with-xz           	\
	    	--with-zlib

	__mk

	__mk check

	make pkgconfigdir=/usr/lib/pkgconfig install
	for target in depmod insmod modinfo modprobe rmmod
	do
		ln -sv ../bin/kmod /sbin/$target
	done
	ln -sv kmod /bin/lsmod
}

__libpipeline()
{
	__dcd $SRC/libpipeline-1.2.1

	sed -i -e '/gets is a/d' gnulib/lib/stdio.in.h

	PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

	__mk

	__mk check

	__mk install
}

__make()
{
	__common $SRC/make-3.82
}

__man-db()
{
	__dcd $SRC/man-db-2.6.2

	sed -i -e '/gets is a/d' gnulib/lib/stdio.in.h

	./configure --prefix=/usr	\
            	--libexecdir=/usr/lib	\
            	--docdir=/usr/share/doc/man-db-2.6.2 \
            	--sysconfdir=/etc	\
            	--disable-setuid	\
            	--with-browser=/usr/bin/lynx \
           	--with-vgrind=/usr/bin/vgrind \
           	--with-grap=/usr/bin/grap

	__mk

	__mk check

	__mk install
}

__patch()
{
	__dcd $SRC/patch-2.6.1

	patch -Np1 -i ../patch-2.6.1-test_fix-1.patch

	./configure --prefix=/usr

	__mk

	__mk check

	__mk install
}

__shadow()
{
	__dcd $SRC/shadow-4.1.5.1

	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

	sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
		-e 's@/var/spool/mail@/var/mail@' etc/login.defs

	./configure --sysconfdir=/etc

	__mk

	__mk install

	mv -v /usr/bin/passwd /bin
}

__shadow-config()
{
	__mes "shadow configure" ""
	echo

	pwconv

	grpconv

	sed -i 's/yes/no/' /etc/default/useradd

	__echo-setcol-green
	passwd root
	__echo-setcol-def
}

__sysklogd()
{
	__dcd $SRC/sysklogd-1.5

	__mk

	__mk BINDIR=/sbin install

cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF
}

__sysvinit()
{
	__dcd $SRC/sysvinit-2.88dsf

	sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

	sed -i -e 's/utmpdump wall/utmpdump/' \
		-e '/= mountpoint/d' \
		-e 's/mountpoint.1 wall.1//' src/Makefile

	__mk -C src

	__mk -C src install
}

__tar()
{
	__dcd $SRC/tar-1.26

	sed -i -e '/gets is a/d' gnu/stdio.in.h

	FORCE_UNSAFE_CONFIGURE=1	\
	./configure --prefix=/usr 	\
		--bindir=/bin		\
		--libexecdir=/usr/sbin

	__mk

	__mk check

	__mk install
	__mk -C doc install-html docdir=/usr/share/doc/tar-1.26
}

__texinfo()
{
	gzip -dc $SRC/texinfo-4.13a.tar.gz | tar xvf -

	cd $SRC/texinfo-4.13

	./configure --prefix=/usr

	__mk

#	__mk check

	__mk install

	__mk TEXMF=/usr/share/texmf install-tex

	cd /usr/share/info
	rm -v dir
	for f in *
	do install-info $f dir 2>/dev/null
	done
}

__udev()
{
	__dcd systemd-188

	tar -xvf ../udev-lfs-188.tar.bz2	

	__mk -f udev-lfs-188/Makefile.lfs

	__mk -f udev-lfs-188/Makefile.lfs install

	bash udev-lfs-188/init-net-rules.sh
}

__vim()
{
	__decord $SRC/vim-7.3
	__cd $SRC/vim73

	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

	./configure --prefix=/usr	\
		--enable-multibyte

	__mk

#	__mk test

	__mk install

	ln -sv vim /usr/bin/vi
	for L in  /usr/share/man/{,*/}man1/vim.1
	do
		ln -sv vim.1 $(dirname $L)/vi.1
	done

	ln -sv ../vim/vim73/doc /usr/share/doc/vim-7.3

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2

"set number
set shiftwidth=8
set tabstop=8

set ruler

syntax on

set background=dark
"set background=light

" End /etc/vimrc
EOF
}

__dhcpcd()
{
	__dcd dhcpcd-5.5.6

	./configure --libexecdir=/lib/dhcpcd \
        	    --dbdir=/run	     \
		    --sysconfdir=/etc

	__mk

	__mk install


	sed -i "s;/var/lib;/run;g" dhcpcd-hooks/50-dhcpcd-compat
	install -v -m 644 dhcpcd-hooks/50-dhcpcd-compat /lib/dhcpcd/dhcpcd-hooks/
}

__wireless-tools()
{
	__dcd wireless_tools.29

	__mk

	__mk PREFIX=/usr INSTALL_MAN=/usr/share/man install
}

#rem(){
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
__gcc

__sed
__bzip2
__pkg-config
__ncurses
__util-linux
__psmisc
__e2fsprogs
__coreutils
__iana-etc
__m4
__bison
__procps
__grep
__readline
__bash

__libtool
__gdbm
__inetutils
###__perl
__autoconf
__automake
__diffutils
__gawk
__findutils
__flex
###__gettext
__groff
__xz
###__grub
__less
__gzip
__iproute
__kbd
__kmod
__libpipeline
__make
__man-db
__patch
__shadow
__shadow-config
__sysklogd
__sysvinit
__tar
__texinfo
__udev
__vim

__dhcpcd
__wireless-tools

__mes "build-stage2 compleate" ""

