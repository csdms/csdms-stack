export CC=$(which clang)
export CXX=$(which clang++)

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

if [ $(uname) == Darwin ]; then
  export JAVAPREFIX=$(/usr/libexec/java_home)
  export JAVA=$JAVAPREFIX/bin/java
else
  export JAVA=/usr/java/default/bin/java
  export JAVAPREFIX=/usr/java/default
fi

export FC=$(which gfortran)
export F77=$(which gfortran)
export F90=$(which gfortran)
export F03=$(which gfortran)

export PYTHON=$PREFIX/bin/python

./configure --prefix=$PREFIX --disable-documentation --disable-java
make all -j4
make install
