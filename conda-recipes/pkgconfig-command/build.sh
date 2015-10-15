if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

./configure --prefix="${PREFIX}" \
  --disable-debug \
  --disable-host-tool \
  --with-pc-path="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig"

#  --with-internal-glib

make
make install
