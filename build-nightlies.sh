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
  bmi-babel \
  csdms-components \
  esmf \
  esmpy \
  coupling \
  wmt-exe \
  csdms-stack \
"

RECIPES=" \
  sedflux \
  hydrotrend \
"


export PATH=/usr/bin:/bin:/usr/sbin:/etc:/usr/lib

GIT=/usr/bin/git
CURL=/usr/bin/curl

CONDA_URL_PREFIX=http://repo.continuum.io/miniconda/
if [ `uname` == 'Darwin' ]; then
  MINICONDA=Miniconda-latest-MacOSX-x86_64.sh
else
  MINICONDA=Miniconda-latest-Linux-x86_64.sh
fi

TMPDIR=_temp
#TMPDIR=$(mktemp -d --suffix=.stack)

mkdir $TMPDIR

cd $TMPDIR || exit -1
echo Building in $TMPDIR

$GIT clone git@github.com:csdms/csdms-stack.git
cd csdms-stack
PYTHON_PREFIX=$(pwd)/conda

$CURL $CONDA_URL_PREFIX/$MINICONDA -o miniconda.sh
bash miniconda.sh -f -b -p $PYTHON_PREFIX
export PATH=$PYTHON_PREFIX/bin:$PATH

conda install conda-build anaconda-client

cd conda-recipes
for recipe in $RECIPES; do
  conda build $recipe && anaconda upload --force --channel nightly --channel main --user csdms $(conda build $recipe --output)
  wait
done
#bash ./build-stack.sh

#anaconda upload --force --channel dev --user csdms -c https://conda.anaconda.org/csdms pkgs/*tar.bz2

#rm -rf $TMPDIR
