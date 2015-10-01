export CPPFLAGS="-I$PREFIX/include"

./configure --prefix=$PREFIX --disable-dependency-tracking --disable-dap-remote-tests --enable-static --enable-shared
make all
make install
