#! /bin/bash

REPOSITORY="https://github.com/csdms/cem-old,mcflugen/add-function-pointers"

JAVA_HOME=$(babel-config --query-var=JAVAPREFIX)
export CC=$(babel-config --query-var=CC)
export CXX=$(babel-config --query-var=CXX)
export USER=nobody

if [[ -z $JAVA_HOME ]]; then
  echo "warning: JAVA_HOME is not set."
else
  export PATH=$JAVA_HOME/bin:$PATH
fi

echo "- $REPOSITORY" > _repos.yaml

SHARE_DIR=$PREFIX/share/csdms
mkdir -p $SHARE_DIR

$PREFIX/bin/bmi-babel-fetch --no-build --file=_repos.yaml --prefix=$PREFIX --output=$SHARE_DIR > _models.yaml
$PREFIX/bin/bmi-babel-make _models.yaml

if [ $(uname) == Darwin ]; then
  export LDFLAGS="-headerpad_max_install_names"
fi

ln -s "$PREFIX/lib" "$PREFIX/lib64"

cd csdms && ./configure --prefix=$PREFIX --with-languages="python c" && make all && make install

rm "$PREFIX"/lib64
