if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

if [ $(uname) == Darwin ]; then
  #export JAVAPREFIX=$(/usr/libexec/java_home)
  export JAVAPREFIX=/usr
else
  JAVAPREFIX="${JAVA_HOME:-/usr/java/default}"
fi
export JAVA=$JAVAPREFIX/bin/java

export FC=$(which gfortran)
export F77=$(which gfortran)
export F90=$(which gfortran)
export F03=$(which gfortran)

export PYTHON=$PREFIX/bin/python
export PATH=$JAVAPREFIX/bin:$PATH

./configure --prefix=$PREFIX --disable-documentation --disable-java
make all -j4
make install
