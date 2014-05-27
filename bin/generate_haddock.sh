#!/bin/sh

OUT="$HOME/htdocs/hdocs"
PKG_DB="$HOME/.ghc/x86_64-freebsd-7.8.2/package.conf.d"
DIR="/tmp/standalone-haddock"

CMD="standalone-haddock -o $OUT --package-db $PKG_DB --hyperlink-source"

# input

PKGS="$@"

# run

mkdir "$DIR" 2>/dev/null

cd $DIR

for pkg in $PKGS; do

  if [ ! -d $pkg ]; then

    # get package from haddock
    cabal unpack $pkg
    $CMD $pkg*

  else

    # run standalone-haddock in directory
    $CMD $pkg

  fi

done
