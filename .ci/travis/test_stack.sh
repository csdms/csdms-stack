#! /bin/bash

if [ $CONDA_RECIPES == "runtime" ]; then
  echo "Building the CSDMS runtime"
  conda install csdms-models coupling -c csdms/channel/nightly || exit -1
  python -c 'from cmt.components import Hydrotrend; Hydrotrend()' || exit -1
else
  echo "Building the CSDMS recipes: $CONDA_RECIPES"
  (cd conda-recipes && conda build $CONDA_RECIPES) || exit -1
fi
