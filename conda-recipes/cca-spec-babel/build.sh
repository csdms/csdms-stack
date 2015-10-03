BABEL_CONFIG=$PREFIX/bin/babel-config
export CC=$($BABEL_CONFIG --query-var=CC)
export CXX=$($BABEL_CONFIG --query-var=CXX)

export USER=nobody
export SHELL=/bin/bash

./configure --prefix=$PREFIX --disable-contrib \
  --with-babel-config=$BABEL_CONFIG --with-libxml2=$PREFIX

make all
make install
