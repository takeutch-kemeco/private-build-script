#!/bin/bash

BASE_DIR=$(pwd)
PREFIX=/usr

#MAKE_CLEAN="make clean"
MAKE_CLEAN=

man-pages()
{
	cd $BASE_DIR/man-pages
	make install
	cd $BASE_DIR
}

zlib()
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

file()
{
	cd $BASE_DIR/file
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

binutils()
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
sed()
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

gmp()
{
	echo
}

mpfr()
{
	echo
}

mpc()
{
	echo
}

gcc()
{
	echo
}

bzip2()
{
	cd $BASE_DIR/bzip2
	make -f Makefile-libbz2_so
	make clean
	make
	make PREFIX=$PREFIX install

	cp -vf bzip2-shared /bin/bzip2
	cp -avf libbz2.so* /lib
	ln -svf /lib/libbz2.so.1.0 /usr/lib/libbz2.so
	rm -vf /usr/bin/{bunzip2,bzcat,bzip2}
	ln -svf bzip2 /bin/bunzip2
	ln -svf bzip2 /bin/bzcat
	ldconfig

	cd $BASE_DIR
}

ncurses()
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

util-linux()
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

psmisc()
{
	cd $BASE_DIR/psmisc
	./autogen.sh --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

e2fsprogs()
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

rsync()
{
	cd $BASE_DIR/rsync
	./configure --prefix=$PREFIX
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

coreutils()
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

iana-etc()
{
	cd $BASE_DIR/iana-etc
	$MAKE_CLEAN
	make
	make install
	ldconfig

	cd $BASE_DIR
}

# gnulib を使う系のだと、getsの問題がどれでも関係してくるっぽい
m4()
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

bison()
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

procps()
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

grep()
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

readline()
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

bash()
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

libtool()
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

gdbm()
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

inetutils()
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

perl()
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

gettext()
{
	cd $BASE_DIR/gettext
	./autogen.sh --prefix=PREFIX
	make
	make install
	ldconfig
	
	cd $BASE_DIR
}




sysklogd()
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


__test__()
{
#man-pages
#zlib
###file
#binutils
#sed
#bzip2
#ncurses
#util-linux
#psmisc
#e2fsprogs
#coreutils
#iana-etc
###m4
#bison
#procps
#grep
#readline
#bash
###libtool
#gdbm
#inetutils
perl




#perl
#procps
	exit
}
__test__

man-pages
#zlib
#file
#binutils
#sed
bzip2
ncurses
util-linux
e2fsprogs
rsync
###err### coreutils



gettext



sysklogd




