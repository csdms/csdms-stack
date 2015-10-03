#! /bin/bash

ESMFMKFILE=$(find $PREFIX/lib/libO/* -name esmf.mk)

cd src/addon/ESMPy
$PYTHON setup.py build --ESMFMKFILE=$ESMFMKFILE install --prefix=$PREFIX
