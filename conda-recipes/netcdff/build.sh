if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

export CPPFLAGS="-I$PREFIX/include"

ln -s "$PREFIX/lib" "$PREFIX/lib64"

./configure --prefix=$PREFIX --disable-dependency-tracking --disable-dap-remote-tests --enable-static --enable-shared
make all
make install

rm "$PREFIX"/lib64
