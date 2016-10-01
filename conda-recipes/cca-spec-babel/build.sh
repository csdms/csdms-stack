BABEL_CONFIG=$PREFIX/bin/babel-config
JAVA_HOME=$($BABEL_CONFIG --query-var=JAVAPREFIX)
export CC=$($BABEL_CONFIG --query-var=CC)
export CXX=$($BABEL_CONFIG --query-var=CXX)

export USER=nobody
export SHELL=/bin/bash

if [[ -z $JAVA_HOME ]]; then
  echo "warning: JAVA_HOME is not set."
else
  export PATH=$JAVA_HOME/bin:$PATH
fi

ln -s "$PREFIX/lib" "$PREFIX/lib64"

./configure --prefix=$PREFIX --disable-contrib \
  --with-babel-config=$BABEL_CONFIG --with-libxml2=$PREFIX

make all -j$CPU_COUNT
make install

rm "$PREFIX"/lib64
