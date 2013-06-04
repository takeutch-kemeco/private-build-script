#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=${BASE_DIR}/src

#DIST_CLEAN=
DIST_CLEAN="make distclean"

#MAKE_CLEAN=
MAKE_CLEAN="make clean"

. ./__common-func.sh

__emacs()
{
	__wget http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-24.2.tar.xz
	__dcd emacs-24.2

	$DIST_CLEAN
	__cfg --prefix=/usr			\
              --sysconfdir=/etc			\
              --libexecdir=/usr/lib		\
              --localstatedir=/var 		\
	      --without-gif

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__haskell-mode()
{
	__wget http://projects.haskell.org/haskellmode-emacs/haskell-mode-2.8.0.tar.gz
	__dcd haskell-mode-2.8.0

	cp -rf ${BASE_DIR}/haskell-mode-2.8.0 /usr/share/emacs/site-lisp/haskell-mode/
}

__haskell-mode-config()
{
	__mes ${BASE_DIR}/haskell-mode-config

	grep -e "haskell-mode-hook" /etc/emacs.el
	if [ $? -ne 0 ]
	then
cat >> /etc/emacs.el << .

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(setq haskell-program-name "/usr/bin/ghci")

.
	fi
}

__all()
{
#	__rem() {
	__emacs
	__haskell-mode
	__haskell-mode-config
}

$@

