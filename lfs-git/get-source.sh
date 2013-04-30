#!/bin/bash

BASE_DIR=$(pwd)

git clone git://github.com/mkerrisk/man-pages.git

git clone git://github.com/madler/zlib.git

###file
wget -c ftp://ftp.astron.com/pub/file/file-5.10.tar.gz
gzip -dc file-5.10.tar.gz | tar xvf -
ln -s file-5.10 file

cvs -z 9 -d :pserver:anoncvs@sourceware.org:/cvs/src co binutils
mv src binutils

git clone git://git.savannah.gnu.org/gnulib.git
git clone git://git.savannah.gnu.org/sed.git
ln -s gnulib sed/gnulib

wget -c http://bzip.org/1.0.6/bzip2-1.0.6.tar.gz
gzip -dc bzip2-1.0.6.tar.gz | tar xvf -
mv bzip2-1.0.6 bzip2

wget -c ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
gzip -dc ncurses-5.9.tar.gz | tar xvf -
mv ncurses-5.9 ncurses

git clone git://gitorious.org/util-linux-ng/util-linux-ng.git

git clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc

git clone git://e2fsprogs.git.sourceforge.net/gitroot/e2fsprogs/e2fsprogs

###git clone git://git.sv.gnu.org/coreutils
wget -c http://ftp.gnu.org/gnu/coreutils/coreutils-8.17.tar.xz
xz -dc coreutils-8.17.tar.xz | tar xvf -
ln -s coreutils-8.17 coreutils

git clone git://gitorious.org/baserock-morphs/iana-etc.git

###git clone git://git.sv.gnu.org/m4.git
wget -c http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.bz2
bzip2 -dc m4-1.4.16.tar.bz2 | tar xvf -
ln -s m4-1.4.16 m4

git clone git://git.sv.gnu.org/bison.git

git clone git://gitorious.org/procps/procps.git

git clone git://git.savannah.gnu.org/grep.git

git clone git://git.savannah.gnu.org/readline.git

git clone git://git.savannah.gnu.org/bash.git

###git clone git://git.savannah.gnu.org/libtool.git
wget -c http://ftp.gnu.org/gnu/libtool/libtool-2.4.2.tar.gz
gzip -dc libtool-2.4.2.tar.gz | tar xvf -
ln -s libtool-2.4.2 libtool

git clone git://git.sv.gnu.org/gdbm.git

###git clone git://git.savannah.gnu.org/inetutils.git
wget -c http://ftp.gnu.org/gnu/inetutils/inetutils-1.9.1.tar.gz
gzip -dc inetutils-1.9.1.tar.gz | tar xvf -
ln -s inetutils-1.9.1 inetutils

git clone git://perl5.git.perl.org/perl.git perl

###git clone git://git.sv.gnu.org/autoconf.git
wget -c http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz
xz -dc autoconf-2.69.tar.xz | tar xvf -
ln -s autoconf-2.69 autoconf

###git clone git://git.sv.gnu.org/automake.git
wget -c http://ftp.gnu.org/gnu/automake/automake-1.12.1.tar.xz
xz -dc automake-1.12.1.tar.xz | tar xvf -
ln -s automake-1.12.1 automake

git clone git://git.sv.gnu.org/diffutils.git

git clone git://git.sv.gnu.org/gawk.git

git clone git://git.sv.gnu.org/findutils.git

###flex
wget -c http://prdownloads.sourceforge.net/flex/flex-2.5.35.tar.bz2
bzip2 -dc flex-2.5.35.tar.bz2 | tar xvf -
ln -s flex-2.5.35 flex

###git clone git://git.sv.gnu.org/gettext.git
wget -c http://ftp.gnu.org/gnu/gettext/gettext-0.18.1.1.tar.gz
gzip -dc gettext-0.18.1.1.tar.gz | tar xvf -
ln -s gettext-0.18.1.1 gettext

###git clone git://gitorious.org/baserock-morphs/groff.git
wget -c http://ftp.gnu.org/gnu/groff/groff-1.21.tar.gz
gzip -dc groff-1.21.tar.gz | tar xvf -
ln -s groff-1.21 groff

###grub
wget -c http://ftp.gnu.org/gnu/grub/grub-1.99.tar.gz
gzip -dc grub-1.99.tar.gz | tar xvf -
ln -s grub-1.99 grub

git clone git://git.sv.gnu.org/gzip.git

git clone git://github.com/shemminger/iproute2.git

###kbd
wget -c http://ftp.altlinux.org/pub/people/legion/kbd/kbd-1.15.3.tar.gz
gzip -dc kbd-1.15.3.tar.gz | tar xvf -
ln -s kbd-1.15.3 kbd
wget -c http://www.linuxfromscratch.org/patches/lfs/development/kbd-1.15.3-upstream_fixes-1.patch
wget -c http://www.linuxfromscratch.org/patches/lfs/development/kbd-1.15.3-backspace-1.patch

###less
wget -c http://www.greenwoodsoftware.com/less/less-444.tar.gz
gzip -dc less-444.tar.gz | tar xvf -
ln -s less-444 less

###libpipeline
wget -c http://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.2.1.tar.gz
gzip -dc libpipeline-1.2.1.tar.gz | tar xvf -
ln -s libpipeline-1.2.1 libpipeline

###git clone git://git.savannah.gnu.org/make.git
wget -c http://ftp.gnu.org/gnu/make/make-3.82.tar.bz2
bzip2 -dc make-3.82.tar.bz2 | tar xvf -
ln -s make-3.82 make

git clone http://git.tukaani.org/xz.git

###git clone git://gitorious.org/baserock-morphs/man-db.git
wget -c http://download.savannah.gnu.org/releases/man-db/man-db-2.6.1.tar.gz
gzip -dc man-db-2.6.1.tar.gz | tar xvf -
ln -s man-db-2.6.1 man-db

git clone git://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git

###patch
wget -c http://ftp.gnu.org/gnu/patch/patch-2.6.1.tar.bz2
bzip2 -dc patch-2.6.1.tar.bz2 | tar xvf -
ln -s patch-2.6.1 patch

git clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc

###shadow
wget -c http://pkg-shadow.alioth.debian.org/releases/shadow-4.1.5.1.tar.bz2
bzip2 -dc shadow-4.1.5.1.tar.bz2 | tar xvf -
ln -s shadow-4.1.5.1 shadow

###git clone git://git.infodrom.org/infodrom/sysklogd
wget -c http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
gzip -dc sysklogd-1.5.tar.gz | tar xvf -
mv sysklogd-1.5 sysklogd

###Sysvinit
wget -c http://download.savannah.gnu.org/releases/sysvinit/sysvinit-2.88dsf.tar.bz2
bzip2 -dc sysvinit-2.88dsf.tar.bz2 | tar xvf -
ln -s sysvinit-2.88dsf sysvinit

###git clone git://git.savannah.gnu.org/tar.git
wget -c http://ftp.gnu.org/gnu/tar/tar-1.26.tar.bz2
bzip2 -dc tar-1.26.tar.bz2 | tar xvf -
ln -s tar-1.26 tar

###texinfo
wget -c http://ftp.gnu.org/gnu/texinfo/texinfo-4.13a.tar.gz
gzip -dc texinfo-4.13a.tar.gz | tar xvf -
ln -s texinfo-4.13a texinfo

###systemd
git clone git://anongit.freedesktop.org/systemd/systemd

###systemd-ui
git clone git://anongit.freedesktop.org/systemd/systemd-ui

###dbus
git clone git://anongit.freedesktop.org/dbus/dbus

###vim
wget -c ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
bzip2 -dc vim-7.3.tar.bz2 | tar xvf -
ln -s vim-7.3 vim

bzr branch bzr://bzr.savannah.gnu.org/grub/trunk/grub

###perl-modules
__perl_modules() {
	mkdir -p $BASE_DIR/perl-modules
	cd $BASE_DIR/perl-modules
	if [ $? -eq 0 ]
	then
		wget -c http://www.cpan.org/authors/id/A/AD/ADAMK/Archive-Zip-1.30.tar.gz
		wget -c http://cpan.org/authors/id/S/SB/SBECK/Date-Manip-6.31.tar.gz
		wget -c http://www.cpan.org/authors/id/F/FL/FLORA/ExtUtils-Depends-0.304.tar.gz
		wget -c http://www.cpan.org/authors/id/T/TS/TSCH/ExtUtils-PkgConfig-1.12.tar.gz
		wget -c http://www.cpan.org/authors/id/X/XA/XAOC/Glib-1.242.tar.gz
		wget -c http://cpan.org/authors/id/G/GA/GAAS/HTML-Parser-3.69.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/HTML-Tagset-3.20.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/D/DW/DWHEELER/Test-Pod-1.45.tar.gz
		wget -c http://cpan.org/authors/id/M/MS/MSISK/HTML-TableExtract-2.11.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/M/MS/MSISK/HTML-Element-Extended-1.18.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/J/JF/JFEARN/HTML-Tree-4.2.tar.gz
		wget -c http://cpan.org/authors/id/G/GA/GAAS/libwww-perl-6.04.tar.gz
		wget -c http://www.cpan.org/authors/id/G/GA/GAAS/URI-1.60.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/N/NA/NANIS/Crypt-SSLeay-0.59_03.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/XML-Parser-2.41.tar.gz
		wget -c http://cpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.18.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/G/GR/GRANTM/XML-SAX-0.99.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.11.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/B/BJ/BJOERN/XML-SAX-Expat-0.40.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/XML-LibXML-1.99.tar.gz
		wget -c http://search.cpan.org/CPAN/authors/id/C/CH/CHORNY/Tie-IxHash-1.22.tar.gz
	fi

	cd $BASE_DIR/perl-modules
	if [ $? -eq 0 ]
	then
		for n in $(ls)
		do
			gzip -dc $n | tar xvf -
		done
	fi

	cd $BASE_DIR
}
__perl_modules

###popt
wget -c http://rpm5.org/files/popt/popt-1.16.tar.gz
gzip -dc popt-1.16.tar.gz | tar xvf -
ln -s popt-1.16 popt

###pkgconfig
git clone git://anongit.freedesktop.org/pkg-config

###diffutils
wget -c http://ftp.gnu.org/gnu/diffutils/diffutils-3.2.tar.gz
gzip -dc diffutils-3.2.tar.gz | tar xvf -
ln -s diffutils-3.2 diffutils

###gawk
wget -c http://ftp.gnu.org/gnu/gawk/gawk-4.0.1.tar.xz
xz -dc gawk-4.0.1.tar.xz | tar xvf -
ln -s gawk-4.0.1 gawk

###findutils
wget -c http://ftp.gnu.org/gnu/findutils/findutils-4.4.2.tar.gz
gzip -dc findutils-4.4.2.tar.gz | tar xvf -
ln -s findutils-4.4.2 findutils

###kmod
wget -c http://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-9.tar.xz
xz -dc kmod-9.tar.xz | tar xvf -
ln -s kmod-9 kmod

###libpipeline
wget -c http://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.2.1.tar.gz
gzip -dc libpipeline-1.2.1.tar.gz | tar xvf -
ln -s libpipeline-1.2.1 libpipeline

###gnutls
wget -c http://ftp.gnu.org/gnu/gnutls/gnutls-3.0.19.tar.xz
xz -dc gnutls-3.0.19.tar.xz | tar xvf -
ln -s gnutls-3.0.19 gnutls

