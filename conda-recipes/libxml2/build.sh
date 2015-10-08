#!/bin/bash

#export CC=$(which clang)
#export CXX=$(which clang++)

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

if [ `uname` == Darwin ]; then
    export EXTRA_ARGS="--without-threads"
fi

./configure $EXTRA_ARGS --prefix=$PREFIX
make
make install
