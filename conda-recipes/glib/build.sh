#if [ `uname` == Darwin ]; then
#  export CC=$(which clang)
#  export CXX=$(which clang++)
#fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

unset PYTHON
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export CFLAGS="-I$PREFIX/include"
export CPPFLAGS="-I$PREFIX/include"
export CXXFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
#export LDFLAGS="-L$PREFIX/lib64 -L$PREFIX/lib"
export LIBFFI_CFLAGS=" "
export LIBFFI_LIBS="-lffi"
export DYLD_LIBRARY_PATH="$PREFIX/lib"

./configure --prefix=$PREFIX
make -j4
make install
