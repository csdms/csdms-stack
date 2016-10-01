if [[ -z $CC ]]; then
  if [ `uname` == Darwin ]; then
    export CC=$(which gcc)
    export CXX=$(which g++)
    # export CC=$(which clang)
    # export CXX=$(which clang++)
  else
    export CC=$(which gcc)
    export CXX=$(which g++)
  fi
fi

if [[ -z $FC ]]; then
  export FC=$(which gfortran)
fi

export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)

export F77=$FC
export F90=$FC
export F03=$FC

if [ $(uname) == Darwin ]; then
  export JAVAPREFIX=$(/usr/libexec/java_home)
  #export JAVAPREFIX=/usr
else
  export JAVAPREFIX="${JAVA_HOME:-/usr/java/default}"
  # export JAVAPREFIX="/usr/java/default"
  # export JAVAPREFIX=/usr
fi
export JAVA=$JAVAPREFIX/bin/java

export PYTHON=$PREFIX/bin/python
export PATH=$JAVAPREFIX/bin:$PATH

ln -s "$PREFIX/lib" "$PREFIX/lib64"

export FCFLAGS="-Wl,-rpath,${PREFIX}/lib"
export FFLAGS="-Wl,-rpath,${PREFIX}/lib"

# export LC_RPATH=$PREFIX/lib
# export DYLD_LIBRARY_PATH=$PREFIX/lib
# export LD_LIBRARY_PATH=$PREFIX/lib

# install_name_tool -id @rpath/./libgfortran.3.dylib $PREFIX/bin/gfortran

./configure --prefix=$PREFIX --disable-documentation \
  --with-libparsifal=$PREFIX --with-ltdl-include=$PREFIX/include \
  --with-ltdl-lib=$PREFIX/lib --with-libxml2=$PREFIX --with-chasm=$PREFIX \
  --without-sidlx

make all -j$CPU_COUNT
make install

rm "$PREFIX"/lib64
