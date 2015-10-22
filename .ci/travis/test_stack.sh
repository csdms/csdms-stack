#! /bin/bash

if [ $CONDA_RECIPES == "runtime" ]; then
  conda install csdms-models coupling -c csdms/channel/nightly || exit -1
  python -c 'from cmt.components import Hydrotrend; Hydrotrend()' || exit -1
else
  (cd conda-recipes && conda build $CONDA_RECIPES -c csdms/channel/nightly) || exit -1
fi
