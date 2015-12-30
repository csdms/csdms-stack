BABEL_CONFIG=$PREFIX/bin/babel-config
JAVA_HOME=$($BABEL_CONFIG --query-var=JAVAPREFIX)
export CC=$($BABEL_CONFIG --query-var=CC)
export CXX=$($BABEL_CONFIG --query-var=CXX)

if [[ -z $JAVA_HOME ]]; then
  echo "warning: JAVA_HOME is not set."
else
  export PATH=$JAVA_HOME/bin:$PATH
fi

ln -s "$PREFIX/lib" "$PREFIX/lib64"

./configure --prefix=$PREFIX --without-mpi --with-boost=$PREFIX/include
make
make install

rm "$PREFIX"/lib64
