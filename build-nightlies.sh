#! /bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/etc:/usr/lib

GIT=/usr/bin/git
WGET=/usr/bin/wget

tmpdir=$(mktemp -d --suffix=.stack)
echo $tmpdir > stack-build-dir.txt

cd $tmpdir || exit -1

echo Building in $tmpdir

$GIT clone git@github.com:csdms/csdms-stack.git
cd csdms-stack
PYTHON_PREFIX=$(pwd)/conda

$WGET http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh -f -b -p $PYTHON_PREFIX
export PATH=$PYTHON_PREFIX/bin:$PATH

conda install conda-build anaconda-client

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

cd conda-recipes
for r in $RECIPES; do
  conda build $r && anaconda upload --force --channel nightly --user csdms $PYTHON_PREFIX/conda-bld/linux-64/$r*tar.bz2
  wait
done
#bash ./build-stack.sh

#anaconda upload --force --channel dev --user csdms -c https://conda.anaconda.org/csdms pkgs/*tar.bz2

#rm -rf $tmpdir
