export ESMF_NETCDF="split"
export ESMF_NETCDF_INCLUDE=$PREFIX/include
export ESMF_NETCDF_LIBPATH=$PREFIX/lib
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf"

export ESMF_CXX=$(which g++)
export ESMF_F90=$(which gfortran)
export ESMF_COMM="mpiuni"
export ESMF_DIR=$(pwd)
export ESMF_INSTALL_PREFIX=$PREFIX
export ESMF_COMPILER=gfortran

export

make
make install
