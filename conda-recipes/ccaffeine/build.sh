export

LDFLAGS="-ltinfo"

./configure --prefix=$PREFIX --without-mpi --with-boost=$PREFIX/include
make
make install
