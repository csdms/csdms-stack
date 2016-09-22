#! /bin/bash

RECIPES=" \
  libffi \
  glib \
  netcdff \
  libxml2 \
  boost-headers \
  chasm \
  cca-babel \
  cca-spec-babel \
  ccaffeine \
  cca-bocca \
"

RECIPES=" \
  cca-bocca \
"

COMPILER_PREFIX=/usr/local/gfortran
GCC_VERSION=$($COMPILER_PREFIX/bin/gcc -dumpversion)
GCC_MAJOR=$(echo $GCC_VERSION | cut -f 1 -d .)
GCC_MINOR=$(echo $GCC_VERSION | cut -f 2 -d .)

export COMPILER=gcc${GCC_MAJOR}${GCC_MINOR}
export PATH=/usr/bin:/bin:/usr/sbin:/etc:/usr/lib:$COMPILER_PREFIX/bin

GIT=/usr/bin/git
CURL=/usr/bin/curl

CONDA_URL_PREFIX=http://repo.continuum.io/miniconda/
if [ `uname` == 'Darwin' ]; then
  MINICONDA=Miniconda-latest-MacOSX-x86_64.sh
else
  MINICONDA=Miniconda-latest-Linux-x86_64.sh
fi

TMPDIR=$(pwd)/_temp
#TMPDIR=$(mktemp -d --suffix=.stack)
PYTHON_PREFIX=$TMPDIR/csdms-stack/conda
export PATH=$PYTHON_PREFIX/bin:$PATH

if [ -d "$TMPDIR" ]; then
  cd $TMPDIR/csdms-stack
else
  mkdir $TMPDIR && cd $TMPDIR
  $GIT clone git@github.com:csdms/csdms-stack.git
  cd csdms-stack
  $CURL $CONDA_URL_PREFIX/$MINICONDA -o miniconda.sh
  bash miniconda.sh -f -b -p $PYTHON_PREFIX
  conda install conda-build anaconda-client
fi

conda config --set show_channel_urls yes

if [ `uname` == 'Darwin' ]; then
  (cd /usr/local && mv bin bin.hide && mv lib lib.hide && mv include include.hide)
fi

cd conda-recipes
for recipe in $RECIPES; do
  conda build $recipe
  # (conda build -c csdms $recipe && anaconda upload --force --channel nightly --channel main --user csdms $(conda build $recipe --output)) || exit -1
  wait
done

#rm -rf $TMPDIR
if [ `uname` == 'Darwin' ]; then
  (cd /usr/local && mv bin.hide bin && mv lib.hide lib && mv include.hide include)
fi

