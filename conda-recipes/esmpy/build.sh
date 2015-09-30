#! /bin/bash

ESMFMKFILE=$PREFIX/lib/libO/Linux.gfortran.64.mpiuni.default/esmf.mk

cd src/addon/ESMPy
$PYTHON setup.py build --ESMFMKFILE=$ESMFMKFILE install --prefix=$PREFIX
