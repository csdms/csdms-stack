#!/bin/bash

export CC=clang
export CXX=clang++

if [ `uname` == Darwin ]; then
    export EXTRA_ARGS="--without-threads"
fi

./configure $EXTRA_ARGS --prefix=$PREFIX
make
make install
