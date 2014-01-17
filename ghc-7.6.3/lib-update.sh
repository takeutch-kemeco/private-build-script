#!/bin/bash

__cabal()
{
    sudo cabal install --force-reinstall --reinstall \
                       --enable-documentation --haddock-html \
                       --global --prefix=/usr $@
}

sudo cabal update

for __tmp in `ghc-pkg list`
do
    __cabal `echo ${__tmp} | sed -e "s/-[0-9.]*//g"`
done

