#!/bin/bash

__cabal()
{
    sudo cabal install --force-reinstall --reinstall \
                       --enable-shared --enable-executable-dynamic \
                       --enable-optimization=2 \
                       --enable-documentation --haddock-hyperlink-source --haddock-html \
                       --global --prefix=/usr $@
    sudo ghc-pkg recache
}

#sudo cabal update

for __tmp in `ghc-pkg list`
do
    __cabal `echo ${__tmp} | sed -e "s/-[0-9.]*//g"`
done

