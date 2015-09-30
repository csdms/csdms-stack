#! /bin/bash

export SIDL_DLL_PATH=$PREFIX/share/cca
export LD_LIBRARY_PATH=$(cca-spec-babel-config --var CCASPEC_BABEL_LIBS)

ipython
