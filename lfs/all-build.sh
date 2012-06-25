#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

MAKE_CLEAN="make clean"
#MAKE_CLEAN=

__man-pages()
{
	cd $BASE_DIR/man-pages
	make install
	cd $BASE_DIR
}

__zlib()
{
	cd $BASE_DIR/zlib
	CFLAGS='-mstackrealign -fPIC -O4' ./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install

	mv -v $PREFIX/lib/libz.so.* /lib
	ln -sfv /lib/libz.so.1 $PREFIX/lib/libz.so
	ldconfig

	cd $BASE_DIR
}

__file()
{
	cd $BASE_DIR/file
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__binutils()
{
	rmdir $BASE_DIR/build-binutils
	mkdir -p $BASE_DIR/build-binutils

	cd $BASE_DIR/build-binutils
	$BASE_DIR/binutils/configure --prefix=$PREFIX --enable-shared
	$MAKE_CLEAN
	make tooldir=$PREFIX
	make tooldir=$PREFIX install
	cp -v $BASE_DIR/binutils/include/libiberty.h $PREFIX/include/
	ldconfig

	cd $BASE_DIR
}

# $BASE_DIR/sed/lib/stdio.h の1000行目あたりに、
# ソースコードのgetsを検知してビルド終了させるコードが含まれてるので、
# ビルドできない場合は、そこをコメントアウトしてビルドすれば通る
__sed()
{
	cd $BASE_DIR/sed
	rm $BASE_DIR/sed/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/sed/gnulib
	./autoboot
	./configure --prefix=$PREFIX --bindir=/bin
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__gmp()
{
	echo
}

__mpfr()
{
	echo
}

__mpc()
{
	echo
}

__gcc()
{
	echo
}

__bzip2()
{
	cd $BASE_DIR/bzip2
	make -f Makefile-libbz2_so
	make clean
	make
	make PREFIX=$PREFIX install

#	cp -vf bzip2-shared /bin/bzip2
#	cp -avf libbz2.so* /lib
#	ln -svf /lib/libbz2.so.1.0 /usr/lib/libbz2.so
#	rm -vf /usr/bin/{bunzip2,bzcat,bzip2}
#	ln -svf bzip2 /bin/bunzip2
#	ln -svf bzip2 /bin/bzcat
	ldconfig

	cd $BASE_DIR
}

__ncurses()
{
	cd $BASE_DIR/ncurses
	./configure --prefix=$PREFIX \
		--with-shared \
		--without-debug \
		--enable-widec
	$MAKE_CLEAN
	make
	make install
	mv -vf $PREFIX/lib/libncursesw.so.5* /lib/
	ln -sfv /lib/libncursesw.so.5 $PREFIX/lib/libncursesw.so
	ldconfig

	cd $BASE_DIR
}

__util-linux()
{
	cd $BASE_DIR/util-linux-ng
	./autogen.sh
	./configure --enable-arch \
		--enable-partx \
		--enable-write
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__psmisc()
{
	cd $BASE_DIR/psmisc
	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__e2fsprogs()
{
	rm -rf $BASE_DIR/build-e2fsprogs
	mkdir -p $BASE_DIR/build-e2fsprogs

	cd $BASE_DIR/build-e2fsprogs
	LDFLAGS=-lblkid \
	$BASE_DIR/e2fsprogs/configure --prefix=$PREFIX \
		--with-root-prefix="" \
		--enable-elf-shlibs \
		--disable-libblkid \
		--disable-libuuid \
		--disable-uuidd \
		--disable-fsck
	$MAKE_CLEAN
	make
	make install
	make install-libs
	chmod -v u+w $PREFIX/lib/{libcom_err,libe2p,libext2fs,libss}.a
	ldconfig

	cd $BASE_DIR
}

__coreutils()
{
	cd $BASE_DIR/coreutils
	rm $BASE_DIR/coreutils/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/coreutils/gnulib
	./bootstrap
	FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install

	mv -vf $PREFIX/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo,false,ln,ls,mkdir,mknod,mv,pwd,rm,rmdir,stty,sync,true,uname} /bin
	mv -vf $PREFIX/bin/chroot /usr/sbin
	mv -vf $PREFIX/bin/{head,sleep,nice} /bin

	cd $BASE_DIR
}

__iana-etc()
{
	cd $BASE_DIR/iana-etc
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

# gnulib を使う系のだと、getsの問題がどれでも関係してくるっぽい
__m4()
{
	cd $BASE_DIR/m4
	rm $BASE_DIR/m4/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/m4/gnulib
	./bootstrap
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

__bison()
{
	cd $BASE_DIR/bison
	rm $BASE_DIR/bison/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/bison/gnulib
	./bootstrap
	./configure --prefix=/usr
	echo '#define YYENABLE_NLS 1' >> lib/config.h
	$MAKE_CLEAN
	make
	make check
	make install
	ldconfig

	cd $BASE_DIR
}

__procps()
{
	cd $BASE_DIR/procps
	./autogen.sh
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__grep()
{
	cd $BASE_DIR/grep
	rm $BASE_DIR/grep/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/grep/gnulib
	./bootstrap
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__readline()
{
	cd $BASE_DIR/readline
	./configure --prefix=$PREFIX \
		--libdir=/lib \
		--enable-shared=yes \
		--enable-static=yes
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__bash()
{
	cd $BASE_DIR/bash
	./configure --prefix=$PREFIX \
		--bindir=/bin \
		--with-installed-readline
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__libtool()
{
	cd $BASE_DIR/libtool
	rm $BASE_DIR/libtool/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/libtool/gnulib
	./bootstrap
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__gdbm()
{
	cd $BASE_DIR/gdbm
	./bootstrap
	./configure --prefix=$PREFIX \
		--enable-libgdbm-compat
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__inetutils()
{
	cd $BASE_DIR/inetutils
	rm $BASE_DIR/inetutils/gnulib -rf
	ln -s $BASE_DIR/gnulib $BASE_DIR/inetutils/gnulib
	./bootstrap
	./configure --prefix=$PREFIX \
		--libexecdir=/usr/sbin \
		--localstatedir=/var \
		--disable-logger \
		--disable-syslogd \
		--disable-whois \
		--disable-servers
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__perl()
{
	cd $BASE_DIR/perl
	sh Configure -des -Dprefix=/usr \
		-Dvendorprefix=/usr           \
		-Dman1dir=/usr/share/man/man1 \
		-Dman3dir=/usr/share/man/man3 \
		-Dpager="/usr/bin/less -isR"  \
		-Duseshrplibsh \
		-Dusedevel
	$MAKE_CLEAN
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__perl_modules()
{
	cd $BASE_DIR/perl-modules
	if [ $? -eq 0 ]
	then
		for n in $(ls)
		do
			cd $BASE_DIR/perl-modules/$n
			if [ $? -eq 0 ]
			then
				perl Makefile.PL
				make
				make install
			fi
		done
		ldconfig
	fi

	cd $BASE_DIR
}

__popt()
{
	cd $BASE_DIR/popt
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__pkgconfig()
{
	cd $BASE_DIR/pkg-config
	./autogen.sh
	./configure --prefix=$PREFIX
		--with-installed-popt \
		--with-internal-glib  \
		--docdir=/usr/share/doc/pkg-config-0.26
	make
	make install
	ldconfig
}

__gettext()
{
	cd $BASE_DIR/gettext
	./autogen.sh
	./configure --prefix=$PREFIX \
		--docdir=/usr/share/doc/gettext-0.18.1.1
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}

__autoconf()
{
	cd $BASE_DIR/autoconf
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__automake()
{
	cd $BASE_DIR/automake
	./configure --prefix=$PREFIX --docdir=/usr/share/doc/automake
	make
	make install
	ldconfig
}

__diffutils()
{
	cd $BASE_DIR/diffutils
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__gawk()
{
	cd $BASE_DIR/gawk
	./configure --prefix=$PREFIX
	make
	make install

	mkdir -v /usr/share/doc/gawk-4.0.1
	cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.0.1

	ldconfig
}

__findutils()
{
	cd $BASE_DIR/findutils
	./configure --prefix=$PREFIX \
		--libexecdir=/usr/lib/findutils \
		--localstatedir=/var/lib/locate
	make
	make install

	mv -v /usr/bin/find /bin
	sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb

	ldconfig
}

__flex()
{
	cd $BASE_DIR/flex
	./configure --prefix=$PREFIX \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info
	make
	make install
	ln -sv libfl.a /usr/lib/libl.a
	ldconfig

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

__groff()
{
	cd $BASE_DIR/groff
	PAGE=A4 ./configure --prefix=$PREFIX
	make
	make install
	ln -sv eqn /usr/bin/geqn
	ln -sv tbl /usr/bin/gtbl

	ldconfig
}

__xz()
{
	cd $BASE_DIR/xz
	./autogen.sh
	./configure --prefix=$PREFIX \
		--libdir=/lib \
		--docdir=/usr/share/doc/xz
	make
	make pkgconfigdir=/usr/lib/pkgconfig install
	ldconfig
}

__grub()
{
	cd $BASE_DIR/grub
	./autogen.sh
	./configure --prefix=$PREFIX \
		--sysconfdir=/etc \
		--disable-grub-emu-usb \
		--disable-efiemu \
		--disable-werror
	make
	make install
	ldconfig
}

__less()
{
	cd $BASE_DIR/less
	./configure --prefix=$PREFIX \
		--sysconfdir=/etc
	make
	make install
	ldconfig
}

__gzip()
{
	cd $BASE_DIR/gzip
	./bootstrap
	./configure --prefix=$PREFIX \
		--bindir=/bin
	make
	make install
	ldconfig
}

__iproute2()
{
	cd $BASE_DIR/iproute2
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__kbd()
{
	cd $BASE_DIR/kbd

	patch -Np1 -i ../kbd-1.15.3-upstream_fixes-1.patch
	patch -Np1 -i ../kbd-1.15.3-backspace-1.patch

	sed -i '/guardado\ el/s/\(^.*en\ %\)\(.*\)/\14\$\2/' po/es.po

	sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/' configure &&
	sed -i 's/resizecons.8 //' man/man8/Makefile.in &&
	touch -d '2011-05-07 08:30' configure.ac

	./configure --prefix=$PREFIX \
		--datadir=/lib/kbd
	make
	make install
	ldconfig

	mkdir -v /usr/share/doc/kbd-1.15.3
	cp -R -v doc/* /usr/share/doc/kbd-1.15.3
}

__kmod()
{
	cd $BASE_DIR/kmod
	./configure --prefix=$PREFIX \
		--bindir=/bin \
		--libdir=/lib \
		--sysconfdir=/etc \
		--with-xz \
		--with-zlib
	make
	make pkgconfigdir=/usr/lib/pkgconfig install
	ldconfig
}

__libpipeline()
{
	cd $BASE_DIR/libpipeline
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__make()
{
	cd $BASE_DIR/make
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__man-db()
{
	cd $BASE_DIR/man-db
	./configure --prefix=$PREFIX \
		--libexecdir=/usr/lib \
		--docdir=/usr/share/doc/man-db-2.6.2 \
		--sysconfdir=/etc \
		--disable-setuid \
		--with-browser=/usr/bin/lynx \
		--with-vgrind=/usr/bin/vgrind \
		--with-grap=/usr/bin/grap
	make
	make install
	ldconfig
}

__patch()
{
	cd $BASE_DIR/patch
	./configure --prefix=$PREFIX
	make
	make install
	ldconfig
}

__shadow()
{
	cd $BASE_DIR/shadow
	sed -i 's/groups$(EXEEXT) //' src/Makefile.in
	find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

	sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' -e 's@/var/spool/mail@/var/mail@' etc/login.defs

	./configure --sysconfdir=/etc
	make
	make install
}

__sysvinit()
{
	cd $BASE_DIR/sysvinit
	sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

	sed -i -e 's/utmpdump wall/utmpdump/' \
		-e '/= mountpoint/d' \
		-e 's/mountpoint.1 wall.1//' src/Makefile

	make -C src
	make -C src install
}

__sysklogd()
{
	cd $BASE_DIR/sysklogd
	$MAKE_CLEAN
	make
	make BINDIR=/sbin install
	
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

	cd $BASE_DIR
}

__tar()
{
	cd $BASE_DIR/tar
	FORCE_UNSAFE_CONFIGURE=1  \
	./configure --prefix=$PREFIX \
		--bindir=/bin \
		--libexecdir=/usr/sbin
	make
	make install
	ldconfig

	make -C doc install-html docdir=/usr/share/doc/tar
}

__texinfo()
{
	cd $BASE_DIR/texinfo
	./configure --prefix=$PREFIX
	make
	make install
	make TEXMF=/usr/share/texmf install-tex
}

__udev()
{
	cd $BASE_DIR/udev
	tar -xvf ../udev-config-20100128.tar.bz2

	install -dv /lib/{firmware,udev/devices/pts}
	mknod -m0666 /lib/udev/devices/null c 1 3

	./configure  --prefix=$PREFIX \
		--with-rootprefix='' \
		--bindir=/sbin \
		--sysconfdir=/etc \
		--libexecdir=/lib \
		--enable-rule_generator \
		--disable-introspection \
		--disable-keymap \
		--disable-gudev \
		--with-usb-ids-path=no \
		--with-pci-ids-path=no \
		--with-systemdsystemunitdir=no
	make
	make install
	ldconfig

	rmdir -v /usr/share/doc/udev

	cd udev-config-20100128
	make install

	make install-doc
}

__vim()
{
	cd $BASE_DIR/vim
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
	./configure --prefix=$PREFIX \
		--enable-multibyte
	make
	make install
	ldconfig

	ln -sv vim /usr/bin/vi
	for L in  /usr/share/man/{,*/}man1/vim.1; do
		ln -sv vim.1 $(dirname $L)/vi.1
	done

	ln -sv ../vim/vim73/doc /usr/share/doc/vim-7.3
}

__test__()
{
	exit
}
#__test__

__man-pages
__zlib
__file
__binutils
__sed
__bzip2
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
__perl
__perl_modules
__popt
__pkgconfig
__autoconf
__automake
__diffutils
__gawk
__findutils
__flex
__gettext
__groff
__xz
__grub
__less
__gzip
__iproute2
__kbd
__kmod
__libpipeline
__make
__man-db
__patch
__shadow
__sysklogd
__sysvinit
__tar
__texinfo
__udev
__vim

