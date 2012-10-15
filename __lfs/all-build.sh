#!/bin/bash

BASE_DIR=$(pwd)
SRC=$BASE_DIR

DIST_CLEAN=
#DIST_CLEAN="make distclean"

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

. ../common-func/__common-func.sh

__common()
{
        __cd $1

        ./autogen.sh
        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig
}

__man-pages()
{
        __cd $BASE_DIR/man-pages
	make install
}

__zlib()
{
        __cd $BASE_DIR/zlib

        CFLAGS='-mstackrealign -fPIC -O4' \
         ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install

        mv -v /usr/lib/libz.so.* /lib
        ln -sfv /lib/libz.so.1 /usr/lib/libz.so
        ldconfig
}

__file()
{
        __common $BASE_DIR/file
}

__binutils()
{
        __cdbt

        $BASE_DIR/binutils/configure --prefix=/usr \
                --enable-shared

        $MAKE_CLEAN
        __mk tooldir=/usr
        __mk tooldir=/usr install

        cp -v $BASE_DIR/binutils/include/libiberty.h /usr/include/
        ldconfig
}

__sed()
{
        __cd $BASE_DIR/sed

        ./autoboot

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        ./configure --prefix=/usr --bindir=/bin

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__bzip2()
{
        __cd $BASE_DIR/bzip2

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

        ldconfig
}

__ncurses()
{
        __cd $BASE_DIR/ncurses

        ./autogen.sh
        ./configure --prefix=/usr       \
                    --mandir=/usr/share/man \
                    --with-shared       \
                    --without-debug     \
                    --enable-widec

        $MAKE_CLEAN
        __mk
        __mk install

        mv -vf /usr/lib/libncursesw.so.5* /lib/
        ln -sfv /lib/libncursesw.so.5 /usr/lib/libncursesw.so

        for lib in ncurses form panel menu ; do
                rm -vf /usr/lib/lib${lib}.so
                echo "INPUT(-l${lib}w)" >/usr/lib/lib${lib}.so
                ln -sfv lib${lib}w.a /usr/lib/lib${lib}.a
        done

        ln -sfv libncurses++w.a /usr/lib/libncurses++.a

        rm -vf                     /usr/lib/libcursesw.so
        echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
        ln -sfv libncurses.so      /usr/lib/libcurses.so
        ln -sfv libncursesw.a      /usr/lib/libcursesw.a
        ln -sfv libncurses.a       /usr/lib/libcurses.a

        mkdir -v       /usr/share/doc/ncurses
        cp -v -R doc/* /usr/share/doc/ncurses

        ldconfig
}

__util-linux()
{
        __cd $BASE_DIR/util-linux-ng

        sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' $(grep -rl '/etc/adjtime' .)
        mkdir -pv /var/lib/hwclock

        ./autogen.sh
        ./configure --disable-su        \
                --disable-sulogin       \
                --disable-login

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__psmisc()
{
        __cd $BASE_DIR/psmisc

        ./autogen.sh
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/fuser   /bin
        mv -v /usr/bin/killall /bin
}

__e2fsprogs()
{
        __cdbt

        LDFLAGS=-lblkid \
        $BASE_DIR/e2fsprogs/configure --prefix=/usr \
                --with-root-prefix="" \
                --enable-elf-shlibs   \
                --disable-libblkid    \
                --disable-libuuid     \
                --disable-uuidd       \
                --disable-fsck

        $MAKE_CLEAN
        __mk
        __mk install
        __mk install-libs
        chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

        gunzip -v /usr/share/info/libext2fs.info.gz
        install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

        ldconfig
}

__coreutils()
{
        __cd $BASE_DIR/coreutils

       ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        FORCE_UNSAFE_CONFIGURE=1        \
        ./configure --prefix=/usr       \
                --prefix=/usr           \
                --libexecdir=/usr/lib   \
                --enable-no-install-program=kill,uptime

        $MAKE_CLEAN
        __mk
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
        __cd $BASE_DIR/iana-etc

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__m4()
{
        __cd $BASE_DIR/m4

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" gnu/stdio.in.h > /tmp/a
        cp -f /tmp/a gnu/stdio.in.h

        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__bison()
{
        __cd $BASE_DIR/bison

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        ./configure --prefix=/usr

        echo '#define YYENABLE_NLS 1' >> lib/config.h

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__procps()
{
        __cd $BASE_DIR/procps

        patch -Np1 -i ../procps-3.2.8-fix_HZ_errors-1.patch

        patch -Np1 -i ../procps-3.2.8-watch_unicode-1.patch

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__grep()
{
        __cd $BASE_DIR/grep

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a gnulib-tests/stdio.in.h

        ./configure --prefix=/usr       \
                --bindir=/bin

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__readline()
{
        __cd $BASE_DIR/readline

        ./configure --prefix=/usr       \
                --libdir=/lib           \
                --enable-shared=yes     \
                --enable-static=yes

        $MAKE_CLEAN
        __mk SHLIB_LIBS=-lncurses
        __mk install
        ldconfig

        mv -v /lib/lib{readline,history}.a /usr/lib

        rm -v /lib/lib{readline,history}.so
        ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
        ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

        mkdir   -v /usr/share/doc/readline
        install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline
}

__bash()
{
        __cd $BASE_DIR/bash

        ./autogen.sh
        ./configure --prefix=/usr       \
                --bindir=/bin           \
                --htmldir=/usr/share/doc/bash \
                --without-bash-malloc   \
                --with-installed-readline

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__libtool()
{
        __cd $BASE_DIR/libtool

        ./bootstrap

        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__gdbm()
{
        __cd $BASE_DIR/gdbm

        ./bootstrap
        ./configure --prefix=/usr \
                --enable-libgdbm-compat

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__inetutils()
{
        __cd $BASE_DIR/inetutils

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        ./configure --prefix=/usr       \
                --libexecdir=/usr/sbin  \
                --localstatedir=/var    \
                --disable-logger        \
                --disable-syslogd       \
                --disable-whois         \
                --disable-servers

        $MAKE_CLEAN
        __mk
        __mk install
        __mk -C doc html
        __mk -C doc install-html docdir=/usr/share/doc/inetutils
        ldconfig

        mv -v /usr/bin/{hostname,ping,ping6} /bin
        mv -v /usr/bin/traceroute /sbin
}

__pkgconfig()
{
        __cd $BASE_DIR/pkg-config

        ./autogen.sh
        ./configure --prefix=/usr       \
                --with-internal-glib    \
                --docdir=/usr/share/doc/pkg-config

        __mk
        __mk install
        ldconfig
}

__gettext()
{
        __cd $BASE_DIR/gettext

        sed -i -e '/gets is a/d' gettext-*/*/stdio.in.h

        ./configure --prefix=/usr       \
                --docdir=/usr/share/doc/gettext

        __mk
        __mk install
        ldconfig
}

__autoconf()
{
        __common $BASE_DIR/autoconf
}

__autoconf-archive()
{
        __common $BASE_DIR/autoconf-archive
}

__automake()
{
        __cd $BASE_DIR/automake

        ./configure --prefix=/usr       \
                --docdir=/usr/share/doc/automake

        __mk
        __mk install
        ldconfig
}

__diffutils()
{
        __cd $BASE_DIR/diffutils

        sed -i -e '/gets is a/d' lib/stdio.in.h

        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig
}

__gawk()
{
        __cd $BASE_DIR/gawk

        ./bootstrup

        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig

        mkdir -v /usr/share/doc/gawk
        cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk
}

__findutils()
{
        __cd $BASE_DIR/findutils

        ./configure --prefix=/usr       \
                --libexecdir=/usr/lib/findutils \
                --localstatedir=/var/lib/locate

        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/find /bin
        sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb
}

__flex()
{
        __cd $BASE_DIR/flex

        ./configure --prefix=/usr       \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info \
                --docdir=/usr/share/doc/flex

        __mk
        __mk install
        ln -sv libfl.a /usr/lib/libl.a
        ldconfig

cat > /usr/bin/lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF
chmod -v 755 /usr/bin/lex

        mkdir -v /usr/share/doc/flex
        cp -f doc/flex.pdf /usr/share/doc/flex
}

__groff()
{
        __cd $BASE_DIR/groff

        PAGE=A4 ./configure --prefix=/usr

        __mk
        __mk install
        ln -sv eqn /usr/bin/geqn
        ln -sv tbl /usr/bin/gtbl
        ldconfig
}

__xz()
{
        __cd $BASE_DIR/xz

        ./autogen.sh
        ./configure --prefix=/usr       \
                --libdir=/lib           \
                --docdir=/usr/share/doc/xz

        __mk
        __mk pkgconfigdir=/usr/lib/pkgconfig install
        ldconfig
}

__grub()
{
        __cd $BASE_DIR/grub

        sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

        ./autogen.sh
        ./configure --prefix=/usr       \
                --sysconfdir=/etc       \
                --disable-grub-emu-usb  \
                --disable-efiemu        \
                --disable-werror

        __mk
        __mk install
        ldconfig
}

__less()
{
        __cd $BASE_DIR/less

        ./configure --prefix=/usr       \
                --sysconfdir=/etc

        __mk
        __mk install
        ldconfig
}

__gzip()
{
        __cd $BASE_DIR/gzip

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        ./configure --prefix=/usr       \
                --bindir=/bin

        __mk
        __mk install
        ldconfig

        mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
        mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
}

__iproute2()
{
        __cd $BASE_DIR/iproute2

        ./configure --prefix=/usr

        __mk DESTDIR=

        __mk DESTDIR=              \
                MANDIR=/usr/share/man \
                DOCDIR=/usr/share/doc/iproute2 install
        ldconfig
}

__kbd()
{
        __cd $BASE_DIR/kbd

        sed -i '/guardado\ el/s/\(^.*en\ %\)\(.*\)/\14\$\2/' po/es.po

        sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/' configure
        sed -i 's/resizecons.8 //' man/man8/Makefile.in
        touch -d '2011-05-07 08:30' configure.ac

        ./configure --prefix=/usr \
                --datadir=/lib/kbd

        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/{kbd_mode,loadkeys,openvt,setfont} /bin

        mkdir -v /usr/share/doc/kbd
        cp -R -v doc/* /usr/share/doc/kbd
}

__kmod()
{
        __cd $BASE_DIR/kmod

        ./configure --prefix=/usr       \
                --bindir=/bin           \
                --libdir=/lib           \
                --sysconfdir=/etc       \
                --with-xz               \
                --with-zlib

        __mk
        __mk pkgconfigdir=/usr/lib/pkgconfig install

        for target in depmod insmod modinfo modprobe rmmod; do
                ln -sv ../bin/kmod /sbin/$target
        done

        ln -sv kmod /bin/lsmod

        ldconfig
}

__libpipeline()
{
        __cd $BASE_DIR/libpipeline

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        PKG_CONFIG_PATH=/tools/lib/pkgconfig \
        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig
}

__make()
{
        __cd $BASE_DIR/make

        ./configure --prefix=/usr

        __mk
        __mk install
        ldconfig
}

__man-db()
{
        __cd $BASE_DIR/man-db

        ./configure --prefix=/usr       \
                --libexecdir=/usr/lib   \
                --docdir=/usr/share/doc/man-db \
                --sysconfdir=/etc       \
                --disable-setuid        \
                --with-browser=/usr/bin/lynx \
                --with-vgrind=/usr/bin/vgrind \
                --with-grap=/usr/bin/grap

        __mk
        __mk install
        ldconfig
}

__shadow()
{
        __cd $BASE_DIR/shadow

        sed -i 's/groups$(EXEEXT) //' src/Makefile.in
        find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

        sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
                -e 's@/var/spool/mail@/var/mail@' etc/login.defs

        ./configure --prefix=/usr       \
                --sysconfdir=/etc

        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/passwd /bin

        pwconv
        grpconv
        sed -i 's/yes/no/' /etc/default/useradd

        __mes "Setting the root password"
        passwd root
}

__sysvinit()
{
        __cd $BASE_DIR/sysvinit

        sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

        sed -i -e '/utmpdump/d' -e '/mountpoint/d' src/Makefile

        __mk -C src
        __mk -C src install
        ldconfig
}

__sysklogd()
{
        __cd $BASE_DIR/sysklogd

        $MAKE_CLEAN
        __mk
        __mk BINDIR=/sbin install
        ldconfig

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

__tar()
{
        __cd $BASE_DIR/tar

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a gnu/stdio.in.h

        FORCE_UNSAFE_CONFIGURE=1        \
        ./configure --prefix=/usr       \
                --bindir=/bin           \
                --libexecdir=/usr/sbin

        __mk
        __mk install
        ldconfig

        make -C doc install-html docdir=/usr/share/doc/tar
}

__texinfo()
{
        __cd $BASE_DIR/texinfo

        ./configure --prefix=/usr

        __mk
        __mk install
        __mk TEXMF=/usr/share/texmf install-tex
        ldconfig
}

__systemd()
{
        __cd $BASE_DIR/systemd

        ./configure

        __mk
        __mk install
        ldconfig
}

__udev()
{
        __cd $BASE_DIR/systemd

        tar -xvf ../udev-lfs-193.tar.bz2
        make -f udev-lfs-193/Makefile.lfs
        make -f udev-lfs-193/Makefile.lfs install
        bash udev-lfs-193/init-net-rules.sh
}

__vim()
{
        __cd $BASE_DIR/vim

        echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

        ./configure --prefix=/usr	\
                --enable-multibyte

        make
        make install
        ldconfig

        ln -sv vim /usr/bin/vi
        for L in  /usr/share/man/{,*/}man1/vim.1; do
                ln -sv vim.1 $(dirname $L)/vi.1
        done

        ln -sv ../vim/vim73/doc /usr/share/doc/vim
}

#__rem(){
__man-pages
__zlib
__file
__binutils
__sed
__bzip2
__pkgconfig
__ncurses
__util-linux
__psmisc
__e2fsprogs
__shadow
__coreutils
__iana-etc
__m4
__bison
__procps
###__grep
__readline
__bash
__libtool
__gdbm
__inetutils
__autoconf
__autoconf-archive
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
__sysklogd
__sysvinit
###__tar
__texinfo
__systemd
__udev
__vim

