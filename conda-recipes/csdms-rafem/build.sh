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

$PREFIX/bin/bmi-babel-fetch --no-build --file=_repos.yaml --prefix=$PREFIX > _models.yaml
$PREFIX/bin/bmi-babel-make _models.yaml

cd csdms && ./configure --prefix=$PREFIX && make all && make install

mkdir -p $PREFIX/share/cca
mkdir -p $PREFIX/lib

OLD=$(echo $(pwd)/install | sed -e 's/[]\/$*.^|[]/\\&/g')
NEW=$(echo "/opt/anaconda1anaconda2anaconda3" | sed -e 's/[\/&]/\\&/g')

if [ `uname` == Darwin ]; then
  SED_OPTS="-i bak"
else
  SED_OPTS="--inplace=bak"
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

#cp install/share/cca/*.cca $PREFIX/share/cca/
#cp install/lib/libcsdms*.la $PREFIX/lib/
