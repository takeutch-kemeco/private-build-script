#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN="make clean"
DIST_CLEAN="make distclean"

. __common-func.sh

__emacs()
{
	__wget http://core.ring.gr.jp/pub/GNU/emacs/emacs-24.3.tar.xz
	__dcd emacs-24.3

	$DIST_CLEAN
	__cfg --prefix=/usr				\
	      --sysconfdir=/etc				\
	      --localstatedir=/var			\
	      --libexecdir=/usr/lib			\
	      --without-gif                             \
              --with-x-toolkit=yes

	$MAKE_CLEAN
	__mk
	__mk install
	ldconfig
}

__haskell-mode()
{
	git clone git://github.com/haskell/haskell-mode.git
	__cd haskell-mode
	git pull

	cp ../haskell-mode $PREFIX/lib/emacs/ -rf
}

__haskell-mode-config()
{
	__mes haskell-mode-config

grep "haskell-mode" /etc/emacs.el
if [ $? -ne 0 ]
then 
cat >> /etc/emacs.el << "EOF"

(load "/usr/lib/emacs/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq haskell-program-name "/usr/bin/ghci")

EOF
fi
}

__all()
{
#__rem() {
	__emacs
	__haskell-mode
	__haskell-mode-config
}

$@

