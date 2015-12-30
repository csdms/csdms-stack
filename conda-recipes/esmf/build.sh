if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

export ESMF_NETCDF="split"
export ESMF_NETCDF_INCLUDE=$PREFIX/include
export ESMF_NETCDF_LIBPATH=$PREFIX/lib
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf"

export ESMF_CXX=$CXX
export ESMF_F90=$(which gfortran)
export ESMF_COMM="mpiuni"
export ESMF_DIR=$(pwd)
export ESMF_INSTALL_PREFIX=$PREFIX
export ESMF_COMPILER=gfortran

export

ln -s "$PREFIX/lib" "$PREFIX/lib64"

make
make install

rm "$PREFIX"/lib64
