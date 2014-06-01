#!/bin/bash

BASE_DIR=$(pwd)
SRC_DIR=$BASE_DIR/src

MAKE_CLEAN=
#MAKE_CLEAN="make clean"

DIST_CLEAN=
#DIST_CLEAN="make distclean"

. ../common-func/__common-func-2.sh

__emacs-24.3()
{
    __dep "?"

    __wget http://core.ring.gr.jp/pub/GNU/emacs/emacs-24.3.tar.xz
    __dcd emacs-24.3
    __bld-common --localstatedir=/var --libexecdir=/usr/lib --without-gif --with-x-toolkit=yes
}

__emacs()
{
    __emacs-24.3
}

__haskell-mode()
{
    __git-clone git://github.com/haskell/haskell-mode.git
    __cd haskell-mode
    __git-pull
    sudo cp ../haskell-mode /usr/lib/emacs/ -rf
}

__haskell-mode-config()
{
    __mes haskell-mode-config

    grep "haskell-mode" /etc/emacs.el
    if [ $? -ne 0 ]
    then
        cat >> /etc/emacs.el << .
(load "/usr/lib/emacs/haskell-mode/haskell-site-file")
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
    __emacs
    __haskell-mode
    __haskell-mode-config
}

$@

