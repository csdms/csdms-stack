if [ `uname` == Darwin ]; then
  export EXTRA_ARGS="--without-threads"
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

./configure $EXTRA_ARGS --prefix=$PREFIX
make
make install
