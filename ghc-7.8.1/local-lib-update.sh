#!/bin/bash

### haskellの各ライブラリーはバージョン間依存が非常に強いので、
### 全てのライブラリー間で、依存関係が丸く収まる組み合わせを行うことは難しいです。
### そのため、haskellのライブラリーは、
### （動的ライブラリーではなく）静的ライブラリーで構成することが推奨されます。
### 静的ライブラリーだと、バイナリーのサイズは巨大になりますが、
### そのかわり、ライブラリーバージョン間の依存関係への配慮が、狭い範囲で済ませられます。

### この関数は $HOME/.cabal 以下に動的ライブラリー(.so)をインストールします。
### これは非推奨です。
__cabal-so()
{
    cabal install --force-reinstall --reinstall \
                  --enable-shared --enable-executable-dynamic \
                  --enable-optimization=2 \
                  --enable-documentation --haddock-hyperlink-source --haddock-html \
                  --user $@
    sudo ghc-pkg recache
}

### この関数は $HOME/.cabal 以下に静的ライブラリー(.a)をインストールします。
### これを推奨します。
__cabal()
{
    cabal install --force-reinstall --reinstall \
                  --disable-shared --disable-executable-dynamic \
                  --enable-optimization=2 \
                  --enable-documentation --haddock-hyperlink-source --haddock-html \
                  --user $@
    sudo ghc-pkg recache
}

__all()
{
    #sudo cabal update

    for __tmp in `ghc-pkg list user`
    do
        __cabal `echo ${__tmp} | sed -e "s/-[0-9.]*//g"`
    done
}

$@


