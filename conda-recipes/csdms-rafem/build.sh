#! /bin/bash

REPOSITORY="https://github.com/mcflugen/avulsion-bmi,add-bmi-metadata"

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

mkdir -p $PREFIX/share/cca
mkdir -p $PREFIX/lib

OLD=$(echo $(pwd)/install | sed -e 's/[]\/$*.^|[]/\\&/g')
NEW=$(echo "/opt/anaconda1anaconda2anaconda3" | sed -e 's/[\/&]/\\&/g')

if [ `uname` == Darwin ]; then
  SED_OPTS="-i bak"
else
  SED_OPTS="--in-place=bak"
fi

for f in install/share/cca/*.cca; do
  sed $SED_OPTS  s/$OLD/$NEW/g $f
  cp $f $PREFIX/share/cca/
done
for f in install/lib/libcsdms*la; do
  sed $SED_OPTS s/$OLD/$NEW/g $f
done

for f in install/lib/libcsdms*; do
  cp $f $PREFIX/lib/
done

for f in install/lib/python2.7/site-packages/csdms/*py; do
  cp $f $PREFIX/lib/python2.7/site-packages/csdms/
done
