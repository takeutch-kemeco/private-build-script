#!/tools/bin/bash

BASE_DIR=/sources/clfs-system
SRC_DIR=/sources/src
. $SRC_DIR/__common-func.sh

__common()
{
	__dcd $1

	./configure --prefix=/usr

	__mk
	__mk install
}

__tcl()
{
	__dcd tcl8.5.12

	cd unix
	./configure --prefix=/tools

	__mk
	__mk install
	__mk install-private-headers

	ln -sv tclsh8.5 /tools/bin/tclsh
}

__expect()
{
	__dcd expect5.45

	./configure --prefix=/tools			\
		--with-tcl=/tools/lib 			\
    		--with-tclinclude=/tools/include	\

	__mk
	__mk SCRIPTS="" install
}

__dejagnu()
{
	__dcd dejagnu-1.5

	./configure --prefix=/tools

	__mk install
}

__temporary-perl()
{
	__dcd perl-5.16.2

	patch -Np1 -i $SRC_DIR/perl-5.16.2-libc-1.patch

	sed -i 's@/usr/include@/tools/include@g' ext/Errno/Errno_pm.PL

	./configure.gnu --prefix=/tools -Dcc="gcc"

	__mk
	__mk install
	ln -sfv /tools/bin/perl /usr/bin
}

__linux-headers()
{
	__dcd linux-3.4.17

	__mk mrproper
	__mk headers_check
	__mk INSTALL_HDR_PATH=dest headers_install
	cp -rv dest/include/* /usr/include
	find /usr/include -name .install -or -name ..install.cmd | xargs rm -fv
}

__man-pages()
{
	__dcd man-pages-3.43

	__mk install
}

__eglibc()
{
	__decord eglibc-2.15-r21467
	__cd eglibc-2.15

	sed -i 's/\(&& $name ne\) "db1"/ & \1 "nss_test1"/' scripts/test-installation.pl

	LINKER=$(readelf -l /tools/bin/bash | sed -n 's@.*interpret.*/tools\(.*\)]$@\1@p')
	sed -i "s|libs -o|libs -L/usr/lib -Wl,-dynamic-linker=${LINKER} -o|" \
  		scripts/test-installation.pl
	unset LINKER

	patch -Np1 -i $SRC_DIR/eglibc-2.15-fixes-1.patch

	__cdbt

	echo "slibdir=/lib" >> configparms

	CFLAGS="-mtune=generic -g -O2" 			\
    	../eglibc-2.15/configure --prefix=/usr 		\
    		--disable-profile			\
		--enable-add-ons			\
		--enable-kernel=2.6.32 			\
    		--libexecdir=/usr/lib/eglibc		\
		--libdir=/usr/lib			\

	__mk

	cp -v ../eglibc-2.15/iconvdata/gconv-modules iconvdata
	__mk -k check 2>&1 | tee eglibc-check-log; grep Error eglibc-check-log

	touch /etc/ld.so.conf

	ln -sv ld-2.15.so /lib/ld-linux.so.2

	__mk install

	rm -v /lib/ld-linux.so.2
	cp -v /usr/bin/ldd{,.bak}
	sed '/RTLDLIST/s%/ld-linux.so.2 /lib64%%' /usr/bin/ldd.bak >/usr/bin/ldd

	rm -v /usr/bin/ldd.bak

	cp -v ../eglibc-2.15/sunrpc/rpc/*.h /usr/include/rpc
	cp -v ../eglibc-2.15/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
	cp -v ../eglibc-2.15/nis/rpcsvc/*.h /usr/include/rpcsvc

	__mk localedata/install-locales

	mkdir -pv /usr/lib/locale
	localedef -i en_US -f ISO-8859-1 en_US
	localedef -i ja_JP -f EUC-JP ja_JP
	localedef -i ja_JP -f UTF-8 ja_JP

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

	cp -v --remove-destination /usr/share/zoneinfo/Asia/Tokyo \
    		/etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf

/usr/local/lib
/opt/lib

# End /etc/ld.so.conf
EOF
}

__adjusting-the-toolchain()
{
	gcc -dumpspecs | \
	perl -p -e 's@/tools/lib/ld@/lib/ld@g;' \
     		-e 's@\*startfile_prefix_spec:\n@$_/usr/lib/ @g;' > \
     		$(dirname $(gcc --print-libgcc-file-name))/specs

	###test
	echo 'main(){}' > dummy.c
	gcc dummy.c
	readelf -l a.out | grep ': /lib'
	rm -v dummy.c a.out
}

__gmp()
{
	__dcd gmp-5.0.5

	CPPFLAGS=-fexceptions 				\
	CC="gcc -isystem /usr/include" 			\
	CXX="g++ -isystem /usr/include" 		\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	./configure --prefix=/usr			\
		--enable-cxx 				\
		--enable-mpbsd				\

	__mk
#	__mk check
	__mk install	
}

__mpfr()
{
	__dcd mpfr-3.1.1

	CC="gcc -isystem /usr/include"			\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	./configure --prefix=/usr			\
		--enable-shared 			\
		--with-gmp=/usr				\

	__mk
#	__mk check
	__mk install
}

__mpc()
{
	__dcd mpc-1.0.1

	CC="gcc -isystem /usr/include" 			\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	./configure --prefix=/usr			\

	__mk
#	__mk check
	__mk install
}

__ppl()
{
	__dcd ppl-0.12.1

	CPPFLAGS=-fexceptions CC="gcc -isystem /usr/include" \
	CXX="g++ -isystem /usr/include"	 		\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	./configure --prefix=/usr			\
		--enable-shared	 			\
    		--disable-optimization			\

	__mk
#	__mk check
	__mk install
}

__cloog()
{
	__dcd cloog-0.16.3

	CC="gcc -isystem /usr/include" 			\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
  	./configure --prefix=/usr 			\
		--enable-shared 			\

	__mk
#	__mk check
	__mk install
}

__zlib()
{
	__dcd zlib-1.2.7

	CC="gcc -isystem /usr/include" 			\
	CXX="g++ -isystem /usr/include" 		\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	./configure --prefix=/usr			\

	__mk
	__mk install

	mv -v /usr/lib/libz.so.* /lib
	ln -svf ../../lib/libz.so.1 /usr/lib/libz.so
}

__binutils()
{
	__dcd binutils-2.23

	expect -c "spawn ls"

	__cdbt

	CC="gcc -isystem /usr/include" 			\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	../binutils-2.23/configure --prefix=/usr 	\
    		--libdir=/usr/lib 			\
		--enable-shared 			\
    		--disable-multilib 			\
		--enable-64-bit-bfd			\

	__mk configure-host
	__mk tooldir=/usr

	ln -sv /lib /lib64

#	__mk check

	rm -v /lib64

	rm -v /usr/lib64/libstd*so*
	rmdir -v /usr/lib64

	__mk tooldir=/usr install

	cp -v ../binutils-2.23/include/libiberty.h /usr/include
}

__gcc()
{
	__dcd gcc-4.6.3

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-branch_update-2.patch

	patch -Np1 -i $SRC_DIR/gcc-4.6.3-pure64-1.patch

	sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

	__cdbt

	CC="gcc -isystem /usr/include" 			\
	CXX="g++ -isystem /usr/include" 		\
	LDFLAGS="-Wl,-rpath-link,/usr/lib:/lib" 	\
	../gcc-4.6.3/configure --prefix=/usr 		\
		--libexecdir=/usr/lib			\
		--enable-shared				\
		--enable-threads=posix 			\
    		--enable-__cxa_atexit			\
		--enable-c99				\
		--enable-long-long 			\
    		--enable-clocale=gnu			\
		--enable-languages=c,c++ 		\
    		--disable-multilib 			\
		--disable-libstdcxx-pch			\
		--enable-cloog-backend=isl		\

	__mk

#	__mk -k check

	../gcc-4.6.3/contrib/test_summary

	__mk install

	ln -sv ../usr/bin/cpp /lib

	ln -sv gcc /usr/bin/cc
}

__sed()
{
	__dcd sed-4.2.1

	./configure --prefix=/usr 			\
		--bindir=/bin				\

	__mk
	__mk html
	__mk install
	__mk -C doc install-html
}

__ncurses()
{
	__dcd ncurses-5.9

	patch -Np1 -i $SRC_DIR/ncurses-5.9-branch_update-4.patch

	./configure --prefix=/usr			\
		--libdir=/lib 				\
    		--with-shared 				\
		--without-debug				\
		--enable-widec 				\
    		--with-manpage-format=normal		\
		--with-default-terminfo-dir=/usr/share/terminfo \

	__mk
	__mk install

	mv -v /lib/lib{panelw,menuw,formw,ncursesw,ncurses++w}.a /usr/lib

	rm -v /lib/lib{ncursesw,menuw,panelw,formw}.so
	ln -svf ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so
	ln -svf ../../lib/libmenuw.so.5 /usr/lib/libmenuw.so
	ln -svf ../../lib/libpanelw.so.5 /usr/lib/libpanelw.so
	ln -svf ../../lib/libformw.so.5 /usr/lib/libformw.so

	for lib in curses ncurses form panel menu ; do
        	echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
        	ln -sfv lib${lib}w.a /usr/lib/lib${lib}.a
	done
	ln -sfv libncursesw.so /usr/lib/libcursesw.so
	ln -sfv libncursesw.a /usr/lib/libcursesw.a
	ln -sfv libncurses++w.a /usr/lib/libncurses++.a
	ln -sfv ncursesw5-config /usr/bin/ncurses5-config

	ln -sfv ../share/terminfo /usr/lib/terminfo
}

__pkg-config-lite()
{
	__common pkg-config-lite-0.27.1-1
}

__util-linux()
{
	__dcd util-linux-2.22.1

	sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
    		$(grep -rl '/etc/adjtime' .) 
	mkdir -pv /var/lib/hwclock

	./configure --enable-arch 			\
    		--enable-write 				\
		--disable-login				\
		--disable-su				\

	__mk
	__mk install
	mv -v /usr/bin/logger /bin
}

__e2fsprogs()
{
	__dcd e2fsprogs-1.42.6

	mkdir -v build
	cd build

	../configure --prefix=/usr			\
		--with-root-prefix="" 			\
    		--enable-elf-shlibs 			\
		--disable-libblkid 			\
    		--disable-libuuid 			\
		--disable-fsck 				\
    		--disable-uuidd				\

	__mk
	__mk install
	__mk install-libs
}

__shadow()
{
	__dcd shadow-4.1.5.1

	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i '/groups\.1\.xml/d' '{}' \;
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

	./configure --sysconfdir=/etc			\

	__mk
	__mk install

	sed -i /etc/login.defs \
    		-e 's@#\(ENCRYPT_METHOD \).*@\1SHA512@' \
		-e 's@/var/spool/mail@/var/mail@'

	mv -v /usr/bin/passwd /bin

	pwconv

	grpconv

	passwd root
}

__coreutils()
{
	__dcd coreutils-8.20

	patch -Np1 -i $SRC_DIR/coreutils-8.20-uname-1.patch

	FORCE_UNSAFE_CONFIGURE=1 			\
	./configure --prefix=/usr 			\
    		--enable-no-install-program=kill,uptime	\
    		--enable-install-program=hostname	\

	__mk

	###test
	echo "dummy1:x:1000:" >> /etc/group
	echo "dummy2:x:1001:dummy" >> /etc/group
	echo "dummy:x:1000:1000::/root:/bin/bash" >> /etc/passwd

	make NON_ROOT_USERNAME=dummy check-root

	chown -Rv dummy .

	su dummy -s /bin/bash \
    		-c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes -k check || true"

	sed -i '/dummy/d' /etc/passwd /etc/group

	__mk install

	mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date} /bin
	mv -v /usr/bin/{dd,df,echo,false,hostname,ln,ls,mkdir,mknod} /bin
	mv -v /usr/bin/{mv,pwd,rm,rmdir,stty,true,uname} /bin
	mv -v /usr/bin/chroot /usr/sbin

	mv -v /usr/bin/{[,basename,head,install,nice} /bin
	mv -v /usr/bin/{readlink,sleep,sync,test,touch} /bin
	ln -svf ../../bin/install /usr/bin
}

__iana-etc()
{
	__dcd iana-etc-2.30

	patch -Np1 -i $SRC_DIR/iana-etc-2.30-numbers_update-20120610-2.patch

	__mk
	__mk install
}

__m4()
{
	__common m4-1.4.16
}

__bison()
{
	__dcd bison-2.6.4

	echo "ac_cv_prog_lex_is_flex=yes" > config.cache

	./configure --prefix=/usr			\
		--cache-file=config.cache		\

	__mk
	__mk install
}

__procps()
{
	__dcd procps-3.2.8

	patch -Np1 -i $SRC_DIR/procps-3.2.8-ps_cgroup-1.patch

	patch -Np1 -i $SRC_DIR/procps-3.2.8-fix_HZ_errors-1.patch

	sed -i -r '/^-include/s/\*(.*)/proc\1 ps\1/' Makefile

	__mk
	__mk SKIP='/bin/kill /usr/share/man/man1/kill.1' install
}

__libtool()
{
	__common libtool-2.4.2
}

__flex()
{
	__dcd flex-2.5.37

	./configure --prefix=/usr			\

	__mk
	__mk install

	ln -sv libfl.a /usr/lib/libl.a

cat > /usr/bin/lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF

	chmod -v 755 /usr/bin/lex
}

__iproute2()
{
	__dcd iproute2-3.4.0

	sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
	sed -i '/ARPD/d' Makefile
	rm man/man8/arpd.8

	sed -i '/netlink\//d' ip/ipl2tp.c

	__mk DESTDIR= DOCDIR=/usr/share/doc/iproute2 \
    		MANDIR=/usr/share/man

	__mk DESTDIR= DOCDIR=/usr/share/doc/iproute2 \
		MANDIR=/usr/share/man install
}

__perl()
{
	__dcd perl-5.16.2

	sed -i -e '/^BUILD_ZLIB/s/True/False/' \
       		-e '/^INCLUDE/s,\./zlib-src,/usr/include,' \
       		-e '/^LIB/s,\./zlib-src,/usr/lib,' \
       		cpan/Compress-Raw-Zlib/config.in

	echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

	./configure.gnu --prefix=/usr 			\
   		-Dvendorprefix=/usr 			\
   		-Dman1dir=/usr/share/man/man1 		\
   		-Dman3dir=/usr/share/man/man3 		\
   		-Dpager="/bin/less -isR" 		\
   		-Dusethreads -Duseshrplib		\

	__mk
	__mk install
}

__readline()
{
	__dcd readline-6.2

	patch -Np1 -i $SRC_DIR/readline-6.2-branch_update-3.patch

	./configure --prefix=/usr 			\
		--libdir=/lib				\

	__mk SHLIB_LIBS=-lncurses
	__mk install
	__mk install-doc

	mv -v /lib/lib{readline,history}.a /usr/lib

	rm -v /lib/lib{readline,history}.so
	ln -svf ../../lib/libreadline.so.6 /usr/lib/libreadline.so
	ln -svf ../../lib/libhistory.so.6 /usr/lib/libhistory.so
}

__autoconf()
{
	__common autoconf-2.69
}

__automake()
{
	__common automake-1.12.4
}

__bash()
{
	__dcd bash-4.2

	patch -Np1 -i $SRC_DIR/bash-4.2-branch_update-6.patch

	./configure --prefix=/usr 			\
		--bindir=/bin 				\
    		--without-bash-malloc 			\
		--with-installed-readline		\

	__mk
	__mk htmldir=/usr/share/doc/bash-4.2 install

	exec /bin/bash --login +h
}

__rem(){
__tcl
__expect
__dejagnu
__temporary-perl
__linux-headers
__man-pages
__eglibc
__adjusting-the-toolchain
__gmp
__mpfr
__mpc
__ppl
__cloog
__zlib
__binutils
__gcc
__sed
__ncurses
}
__pkg-config-lite
__util-linux
__e2fsprogs
__shadow
__coreutils
__iana-etc
__m4
__bison
__procps
__libtool
__flex
__iproute2
__perl
__readline
__autoconf
__bash

