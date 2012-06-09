#!/bin/bash

BASE_DIR=$(pwd)

git clone git://github.com/mkerrisk/man-pages.git

git clone git://github.com/madler/zlib.git

#file

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

git clone git://git.samba.org/rsync.git

git clone git://git.sv.gnu.org/coreutils

git clone git://gitorious.org/baserock-morphs/iana-etc.git

git clone git://git.sv.gnu.org/m4.git

git clone git://git.sv.gnu.org/bison.git

git clone git://gitorious.org/procps/procps.git

git clone git://git.savannah.gnu.org/grep.git

git clone git://git.savannah.gnu.org/readline.git

git clone git://git.savannah.gnu.org/bash.git

git clone git://git.savannah.gnu.org/libtool.git

git clone git://git.sv.gnu.org/gdbm.git

git clone git://git.savannah.gnu.org/inetutils.git

git clone git://perl5.git.perl.org/perl.git perl

git clone git://git.sv.gnu.org/autoconf.git

git clone git://git.sv.gnu.org/automake.git

git clone git://git.sv.gnu.org/diffutils.git

git clone git://git.sv.gnu.org/gawk.git

git clone git://git.sv.gnu.org/findutils.git

#flex

git clone git://git.sv.gnu.org/gettext.git

git clone git://gitorious.org/baserock-morphs/groff.git

#grub

git clone git://git.sv.gnu.org/gzip.git

git clone git://github.com/shemminger/iproute2.git

git clone git://github.com/gooselinux/kbd.git

#less

git clone git://gitorious.org/baserock-morphs/libpipeline.git

git clone git://git.savannah.gnu.org/make.git

git clone http://git.tukaani.org/xz.git

###git clone git://gitorious.org/baserock-morphs/man-db.git

git clone git://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git

#patch

git clone git://psmisc.git.sourceforge.net/gitroot/psmisc/psmisc

git clone git://github.com/TheBreeze/shadow.git

###git clone git://git.infodrom.org/infodrom/sysklogd
wget -c http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.tar.gz
gzip -dc sysklogd-1.5.tar.gz | tar xvf -
mv sysklogd-1.5 sysklogd

#Sysvinit

git clone git://git.savannah.gnu.org/tar.git

#texinfo

git clone git://vcs.progress-linux.org/packages/udev.git

#vim

bzr branch bzr://bzr.savannah.gnu.org/grub/trunk/grub

#perl-modules
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
}
__perl_modules

