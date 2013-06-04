#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__git-clone()
{
        cd ${BASE_DIR}
        git clone $@
}

__bld-common()
{
        $DIST_CLEAN
        ./autogen.sh
        __cfg --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libexecdir=/usr/lib $@

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__common()
{
        __cd $1
        git pull
        __bld-common
}

__man-pages()
{
        git clone git://github.com/mkerrisk/man-pages.git
        __cd man-pages
        git pull

        $MAKE_CLEAN
        make install
}

__zlib()
{
        __wget http://zlib.net/zlib-1.2.8.tar.gz
        __dcd zlib-1.2.8

        $DIST_CLEAN
        CFLAGS='-mstackrealign -fPIC -O4 -msse3 -march=native' \
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
        __wget ftp://ftp.astron.com/pub/file/file-5.14.tar.gz
        __dcd file-5.14

        $DIST_CLEAN
        __cfg --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__binutils()
{
        __wget http://ftp.gnu.org/gnu/binutils/binutils-2.23.2.tar.bz2
        __dcd binutils-2.23.2
        __cdbt

        $DIST_CLEAN
        $BASE_DIR/binutils-2.23.2/configure     \
                --prefix=/usr                   \
                --enable-shared                 \
                --enable-werror=no

        $MAKE_CLEAN
        __mk tooldir=/usr
        __mk tooldir=/usr install

        cp -vf $BASE_DIR/binutils-2.23.2/include/libiberty.h /usr/include/
        ldconfig
}

__sed()
{
        __git-clone git://git.savannah.gnu.org/sed.git sed.git
        __cd sed.git
        git pull

        $DIST_CLEAN
        ./autoboot

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -vf /tmp/a lib/stdio.in.h

        __cfg --prefix=/usr --bindir=/bin

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__bzip2()
{
        __wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
        __dcd bzip2-1.0.6

        $MAKE_CLEAN
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

__pkgconfig()
{
        __git-clone git://anongit.freedesktop.org/pkg-config
        __cd pkg-config
        git pull

        $DIST_CLEAN
        ./autogen.sh
        __cfg --prefix=/usr                             \
              --with-internal-glib                      \
              --docdir=/usr/share/doc/pkg-config

        $MAKE_CLEAN
        __mk
        make install
        ldconfig
}

__ncurses()
{
        __wget ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
        __dcd ncurses-5.9

        $DIST_CLEAN
        ./autogen.sh
        __cfg --prefix=/usr             \
              --mandir=/usr/share/man   \
              --with-shared             \
              --without-debug           \
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
        __git-clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
        __cd util-linux
        git pull

        sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' $(grep -rl '/etc/adjtime' .)
        mkdir -pv /var/lib/hwclock

        $DIST_CLEAN
        ./autogen.sh
        __cfg --disable-su      \
              --disable-sulogin \
              --disable-login

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__psmisc()
{
        __git-clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc
        __cd psmisc
        git pull

        $DIST_CLEAN
        ./autogen.sh
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/fuser   /bin
        mv -v /usr/bin/killall /bin
}

__procps-ng()
{
        __wget http://sourceforge.net/projects/procps-ng/files/Production/procps-ng-3.3.7.tar.xz
        __dcd procps-ng-3.3.7

        $DIST_CLEAN
        __cfg --prefix=/usr                           \
              --exec-prefix=                          \
              --libdir=/usr/lib                       \
              --docdir=/usr/share/doc/procps-ng-3.3.7 \
              --disable-static                        \
              --disable-skill                         \
              --disable-kill

        $MAKE_CLEAN
        make
        make install

        mv -v /usr/lib/libprocps.so.* /lib
        ln -sfv ../../lib/libprocps.so.1.1.1 /usr/lib/libprocps.so

        ldconfig
}

__e2fsprogs()
{
        __git-clone git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
        cd e2fsprogs
        git pull

        __cdbt

        $DIST_CLEAN
        $BASE_DIR/e2fsprogs/configure   \
                --prefix=/usr           \
                --with-root-prefix=""   \
                --enable-elf-shlibs     \
                --disable-libblkid      \
                --disable-libuuid       \
                --disable-uuidd         \
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

__linux-pam()
{
#        __wget http://linux-pam.org/library/Linux-PAM-1.1.6.tar.bz2
#        __wget http://linux-pam.org/documentation/Linux-PAM-1.1.6-docs.tar.bz2
#        __dcd Linux-PAM-1.1.6
#        tar -xf ../Linux-PAM-1.1.6-docs.tar.bz2 --strip-components=1

	git clone git://git.fedorahosted.org/linux-pam.git linux-pam.git
	__cd linux-pam.git
	git pull

	$DIST_CLEAN
	./autogen.sh
        __cfg --prefix=/usr                             \
              --sysconfdir=/etc                         \
              --docdir=/usr/share/doc/Linux-PAM-git	\
              --disable-nis

        $MAKE_CLEAN
        __mk
        install -v -m755 -d /etc/pam.d

        __mk install
        chmod -v 4755 /sbin/unix_chkpwd
        ldconfig
}

__shadow()
{
        __wget http://pkg-shadow.alioth.debian.org/releases/shadow-4.1.5.1.tar.bz2
        __dcd shadow-4.1.5.1

        sed -i 's/groups$(EXEEXT) //' src/Makefile.in
        find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
        sed -i -e 's/ ko//' -e 's/ zh_CN zh_TW//' man/Makefile.in

        sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
                -e 's@/var/spool/mail@/var/mail@' etc/login.defs

        sed -i -e 's@PATH=/sbin:/bin:/usr/sbin:/usr/bin@&:/usr/local/sbin:/usr/local/bin@' \
                -e 's@PATH=/bin:/usr/bin@&:/usr/local/bin@' etc/login.defs

        __cfg --prefix=/usr --sysconfdir=/etc --enable-man=no

        $MAKE_CLEAN
        __mk
        __mk install
        mv -v /usr/bin/passwd /bin

        sed -i 's/yes/no/' /etc/default/useradd
}

__shadow-config()
{
install -v -m644 /etc/login.defs /etc/login.defs.orig &&
for FUNCTION in FAIL_DELAY FAILLOG_ENAB \
                LASTLOG_ENAB \
                MAIL_CHECK_ENAB \
                OBSCURE_CHECKS_ENAB \
                PORTTIME_CHECKS_ENAB \
                QUOTAS_ENAB \
                CONSOLE MOTD_FILE \
                FTMP_FILE NOLOGINS_FILE \
                ENV_HZ PASS_MIN_LEN \
                SU_WHEEL_ONLY \
                CRACKLIB_DICTPATH \
                PASS_CHANGE_TRIES \
                PASS_ALWAYS_WARN \
                CHFN_AUTH ENCRYPT_METHOD \
                ENVIRON_FILE
do
    sed -i "s/^${FUNCTION}/# &/" /etc/login.defs
done

cat > /etc/pam.d/system-account << "EOF"
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

cat > /etc/pam.d/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

cat > /etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use sha512 hash for encryption, use shadow, and try to use any previously
# defined authentication token (chosen password) set by any prior module
password  required    pam_unix.so       sha512 shadow try_first_pass

# End /etc/pam.d/system-password
EOF

cat > /etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

cat > /etc/pam.d/login << "EOF"
# Begin /etc/pam.d/login

# Set failure delay before next prompt to 3 seconds
auth      optional    pam_faildelay.so  delay=3000000

# Check to make sure that the user is allowed to login
auth      requisite   pam_nologin.so

# Check to make sure that root is allowed to login
# Disabled by default. You will need to create /etc/securetty
# file for this module to function. See man 5 securetty.
#auth      required    pam_securetty.so

# Additional group memberships - disabled by default
#auth      optional    pam_group.so

# include the default auth settings
auth      include     system-auth

# check access for the user
account   required    pam_access.so

# include the default account settings
account   include     system-account

# Set default environment variables for the user
session   required    pam_env.so

# Set resource limits for the user
session   required    pam_limits.so

# Display date of last login - Disabled by default
#session   optional    pam_lastlog.so

# Display the message of the day - Disabled by default
#session   optional    pam_motd.so

# Check user's mail - Disabled by default
#session   optional    pam_mail.so      standard quiet

# include the default session and password settings
session   include     system-session
password  include     system-password

# End /etc/pam.d/login
EOF

cat > /etc/pam.d/passwd << "EOF"
# Begin /etc/pam.d/passwd

password  include     system-password

# End /etc/pam.d/passwd
EOF

cat > /etc/pam.d/su << "EOF"
# Begin /etc/pam.d/su

# always allow root
auth      sufficient  pam_rootok.so
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/su
EOF

cat > /etc/pam.d/chage << "EOF"
#Begin /etc/pam.d/chage

# always allow root
auth      sufficient  pam_rootok.so

# include system defaults for auth account and session
auth      include     system-auth
account   include     system-account
session   include     system-session

# Always permit for authentication updates
password  required    pam_permit.so

# End /etc/pam.d/chage
EOF

for PROGRAM in chfn chgpasswd chpasswd chsh groupadd groupdel \
               groupmems groupmod newusers useradd userdel usermod
do
    install -v -m644 /etc/pam.d/chage /etc/pam.d/${PROGRAM}
    sed -i "s/chage/$PROGRAM/" /etc/pam.d/${PROGRAM}
done

cat > /etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF

[ -f /etc/login.access ] && mv -v /etc/login.access{,.NOUSE}

[ -f /etc/limits ] && mv -v /etc/limits{,.NOUSE}
}

__coreutils()
{
#       __git-clone git://git.sv.gnu.org/coreutils
#       __cd coreutils
#       git pull

#      ./bootstrap

        __wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.21.tar.xz
        __dcd coreutils-8.21

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        $DIST_CLEAN
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

        $DIST_CLEAN
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__bison()
{
	git clone git://git.savannah.gnu.org/bison.git bison.git
        __cd bison.git
	git pull

        ./bootstrap

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" lib/stdio.in.h > /tmp/a
        cp -f /tmp/a lib/stdio.in.h

        echo "ac_cv_prog_lex_is_flex=yes" > config.cache

        $DIST_CLEAN
        ./configure --prefix=/usr

        echo '#define YYENABLE_NLS 1' >> lib/config.h

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

        $DIST_CLEAN
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

        $DIST_CLEAN
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

        $DIST_CLEAN
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

        $DIST_CLEAN
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

        $DIST_CLEAN
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

        $DIST_CLEAN
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

__gettext()
{
        __cd $BASE_DIR/gettext

        sed -i -e '/gets is a/d' gettext-*/*/stdio.in.h

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --docdir=/usr/share/doc/gettext

        $MAKE_CLEAN
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

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --docdir=/usr/share/doc/automake

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__diffutils()
{
	__wget ftp://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz
        __dcd diffutils-3.3

        sed -i -e '/gets is a/d' lib/stdio.in.h

        $DIST_CLEAN
        __cfg --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__gawk()
{
	git clone git://git.savannah.gnu.org/gawk.git gawk.git
        __cd gawk.git
	git pull

        ./bootstrup

        $DIST_CLEAN
        __cfg --prefix=/usr --sysconfdir=/etc

        $MAKE_CLEAN
        __mk
        __mk install
        dconfig

        mkdir -v /usr/share/doc/gawk
        cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk
}

__findutils()
{
        __cd $BASE_DIR/findutils

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --libexecdir=/usr/lib/findutils \
                --localstatedir=/var/lib/locate

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        mv -v /usr/bin/find /bin
        sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb
}

__flex()
{
        __cd $BASE_DIR/flex

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info \
                --docdir=/usr/share/doc/flex

        $MAKE_CLEAN
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

        $DIST_CLEAN
        PAGE=A4 ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ln -sv eqn /usr/bin/geqn
        ln -sv tbl /usr/bin/gtbl
        ldconfig
}

__xz()
{
        __cd $BASE_DIR/xz

        $DIST_CLEAN
        ./autogen.sh
        ./configure --prefix=/usr       \
                --libdir=/lib           \
                --docdir=/usr/share/doc/xz

        $MAKE_CLEAN
        __mk
        __mk pkgconfigdir=/usr/lib/pkgconfig install
        ldconfig
}

__grub()
{
        __cd $BASE_DIR/grub

        sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

        $DIST_CLEAN
        ./autogen.sh
        CFLAGS="" ./configure --prefix=/usr       \
                --sysconfdir=/etc       \
                --disable-grub-emu-usb  \
                --disable-efiemu        \
                --disable-werror

        $MAKE_CLEAN
        CFLAGS="" __mk
        CFLAGS="" __mk install
        ldconfig
}

__less()
{
        __cd $BASE_DIR/less

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --sysconfdir=/etc

        $MAKE_CLEAN
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

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --bindir=/bin

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
        mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
}

__iproute2()
{
        __cd $BASE_DIR/iproute2

        $DIST_CLEAN
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk DESTDIR=

        __mk DESTDIR=              \
                MANDIR=/usr/share/man \
                DOCDIR=/usr/share/doc/iproute2 install
        ldconfig
}

__kbd()
{
	git clone git://git.altlinux.org/people/legion/packages/kbd.git kbd.git
        __cd kbd.git
	git pull

        sed -i '/guardado\ el/s/\(^.*en\ %\)\(.*\)/\14\$\2/' po/es.po

        sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/' configure
        sed -i 's/resizecons.8 //' man/man8/Makefile.in
        touch -d '2011-05-07 08:30' configure.ac

        $DIST_CLEAN
	./autogen.sh
        __cfg --prefix=/usr --datadir=/lib/kbd

        $MAKE_CLEAN
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

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --bindir=/bin           \
                --libdir=/lib           \
                --sysconfdir=/etc       \
                --with-xz               \
                --with-zlib

        $MAKE_CLEAN
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

        $DIST_CLEAN
        PKG_CONFIG_PATH=/tools/lib/pkgconfig \
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__make()
{
        __cd $BASE_DIR/make

        $DIST_CLEAN
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__man-db()
{
        __cd $BASE_DIR/man-db

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --libexecdir=/usr/lib   \
                --docdir=/usr/share/doc/man-db \
                --sysconfdir=/etc       \
                --disable-setuid        \
                --with-browser=/usr/bin/lynx \
                --with-vgrind=/usr/bin/vgrind \
                --with-grap=/usr/bin/grap

        $MAKE_CLEAN
        __mk
        __mk install
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

        sed -e "s/^_GL_WARN_ON_USE (gets,.*$//g" gnu/stdio.in.h > /tmp/a
        cp -f /tmp/a gnu/stdio.in.h

        $DIST_CLEAN
        FORCE_UNSAFE_CONFIGURE=1        \
        ./configure --prefix=/usr       \
                --bindir=/bin           \
                --libexecdir=/usr/sbin

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        make -C doc install-html docdir=/usr/share/doc/tar
}

__texinfo()
{
        __cd $BASE_DIR/texinfo

        $DIST_CLEAN
        ./configure --prefix=/usr

        $MAKE_CLEAN
        __mk
        __mk install
        __mk TEXMF=/usr/share/texmf install-tex
        ldconfig
}

__dbus()
{
        __cd $BASE_DIR/dbus

        groupadd -g 27 messagebus
        useradd -c "D-Bus Message Daemon User" -d /var/run/dbus \
                -u 27 -g messagebus -s /bin/false messagebus

        $DIST_CLEAN
        ./autogen.sh --prefix=$PREFIX   \
                --sysconfdir=/etc       \
                --localstatedir=/var    \
                --libexecdir=/usr/lib/dbus-1.0 \
                --with-console-auth-dir=/run/console/ \
                --disable-static        \
                --disable-Werror        \

#                --enable-systemd

        $MAKE_CLEAN
        __mk
        __mk install

        dbus-uuidgen --ensure

cat > /etc/dbus-1/session-local.conf << "EOF"
<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

  <!-- Search for .service files in /usr/local -->
  <servicedir>/usr/local/share/dbus-1/services</servicedir>

</busconfig>
EOF

#       cd $BASE_DIR/blfs-bootscripts
#       __mk install-dbus
}

__udev()
{
        __cd $BASE_DIR/systemd-196

        tar -xvf ../udev-lfs-196-3.tar.bz2

        sed -i -e 's/create/update/' src/udev/udevadm-hwdb.c

        $MAKE_CLEAN
        __mk -f udev-lfs-196-3/Makefile.lfs

        __mk -f udev-lfs-196-3/Makefile.lfs install

        build/udevadm hwdb --update

        bash udev-lfs-196-3/init-net-rules.sh
}

__systemd()
{
        __cd $BASE_DIR/systemd

        $DIST_CLEAN
        ./configure

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__systemd-ui()
{
        __cd $BASE_DIR/systemd-ui

        $DIST_CLEAN
        ./configure

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig
}

__vim()
{
        __cd $BASE_DIR/vim

        echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

        $DIST_CLEAN
        ./configure --prefix=/usr       \
                --enable-multibyte

        $MAKE_CLEAN
        __mk
        __mk install
        ldconfig

        ln -sv vim /usr/bin/vi
        for L in  /usr/share/man/{,*/}man1/vim.1; do
                ln -sv vim.1 $(dirname $L)/vi.1
        done

        ln -sv ../vim/vim73/doc /usr/share/doc/vim
}

__iptables()
{
        __cd $BASE_DIR/iptables

        $DIST_CLEAN
        LDFLAGS="-L$PWD/libiptc/.libs"                  \
        ./configure --prefix=/usr                       \
                --exec-prefix=                          \
                --bindir=/usr/bin                       \
                --with-xtlibdir=/lib/xtables            \
                --with-pkgconfigdir=/usr/lib/pkgconfig  \
                --enable-libipq                         \
                --enable-devel

        $MAKE_CLEAN
        __mk
        __mk install

        ln -sfv ../../sbin/xtables-multi /usr/bin/iptables-xml
#       for file in libip4tc libip6tc libipq libiptc libxtables
#       do
#               ln -sfv ../../lib/`readlink /lib/${file}.so` /usr/lib/${file}.so
#               rm -v /lib/${file}.so
#               mv -v /lib/${file}.la /usr/lib
#               sed -i "s@libdir='@&/usr@g" /usr/lib/${file}.la
#       done

        ldconfig
}

__all()
{
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
__procps-ng
__e2fsprogs
###__linux-pam
###__shadow
###__shadow-config
__coreutils
__iana-etc
__m4
__bison
__grep
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
__tar
__texinfo
__dbus
###__udev
__systemd
__systemd-ui
__vim
__iptables
}

$@

