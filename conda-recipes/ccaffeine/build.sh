BABEL_CONFIG=$PREFIX/bin/babel-config
export CC=$($BABEL_CONFIG --query-var=CC)
export CXX=$($BABEL_CONFIG --query-var=CXX)

./configure --prefix=$PREFIX --without-mpi --with-boost=$PREFIX/include
make
make install
