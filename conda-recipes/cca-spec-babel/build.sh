BABEL_CONFIG=$PREFIX/bin/babel-config
export USER=huttone
export SHELL=/bin/bash

./configure --prefix=$PREFIX --disable-contrib --with-babel-config=$BABEL_CONFIG
make all
make install
