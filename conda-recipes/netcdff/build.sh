export CC=$(which clang)
export CXX=$(which clang++)

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

export CPPFLAGS="-I$PREFIX/include"

./configure --prefix=$PREFIX --disable-dependency-tracking --disable-dap-remote-tests --enable-static --enable-shared
make all
make install
