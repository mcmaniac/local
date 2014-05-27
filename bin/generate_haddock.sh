#!/bin/sh

OUT="$HOME/htdocs/hdocs"
PKG_DB="$HOME/.ghc/x86_64-freebsd-7.8.2/package.conf.d"

TMP="/tmp/standalone-haddock"
PWD=`pwd`

CMD="standalone-haddock -o $OUT --package-db $PKG_DB --hyperlink-source"

# input

PKGS="$@"

# run

for pkg in $PKGS; do

  if [ -d ${pkg} -a -f ${pkg}/*.cabal ]; then

    # run standalone-haddock in directory
    $CMD $pkg

  else

    echo "Downloading $pkg from haddock"

    mkdir "$TMP" 2>/dev/null
    cd $TMP
    # get package from haddock
    cabal unpack $pkg
    $CMD $pkg*
    cd $PWD

  fi

done
