if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

export GLIB_CFLAGS="-I$PREFIX/include/glib-2.0 -I$PREFIX/lib/glib-2.0/include"
export GLIB_LIBS="-L$PREFIX/lib -lglib-2.0 -lintl"

./configure --prefix="${PREFIX}" \
  --disable-debug \
  --disable-host-tool \
  --with-pc-path="$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig"

#  --with-internal-glib

make
make install
