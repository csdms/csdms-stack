BABEL_CONFIG=$PREFIX/bin/babel-config
export CC=$($BABEL_CONFIG --query-var=CC)
export CXX=$($BABEL_CONFIG --query-var=CXX)

if [[ -z $JAVA_HOME ]]; then
  echo "warning: JAVA_HOME is not set."
else
  export PATH=$JAVA_HOME/bin:$PATH
fi

./configure --prefix=$PREFIX --without-mpi --with-boost=$PREFIX/include
make
make install
