#!/bin/bash
EXTRA_ARGS=""

if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
  EXTRA_ARGS="--with-libiconv-prefix=/usr"
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

./configure --prefix="${PREFIX}" $EXTRA_ARGS \
    --disable-dependency-tracking \
    --disable-silent-rules \
    --disable-debug \
    --with-included-gettext \
    --with-included-glib \
    --with-included-libcroco \
    --with-included-libunistring \
    --disable-java \
    --disable-csharp \
    --without-git \
    --without-cvs \
    --without-xz \

make
make install
