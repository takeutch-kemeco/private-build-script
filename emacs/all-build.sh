#!/bin/bash

PREFIX=/usr
BASE_DIR=$(pwd)

. ../common-func/__common-func.sh

__emacs()
{
	__cd $BASE_DIR/emacs

	./autogen.sh
	./configure --prefix=$PREFIX

	__mk
	__mk install
	ldconfig
}

__haskell-mode()
{
	__cd $BASE_DIR/haskell-mode

	cp ../haskell-mode $PREFIX/lib/emacs/ -rf
}

__haskell-mode-config()
{
	__mes $BASE_DIR/haskell-mode-config

cat >> /etc/emacs.el << "EOF"

(load "/usr/lib/emacs/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq haskell-program-name "/usr/bin/ghci")

EOF
}

#__emacs
__haskell-mode
#__haskell-mode-config

