export CPPFLAGS="-I$PREFIX/include"

./configure --prefix=$PREFIX
make install
