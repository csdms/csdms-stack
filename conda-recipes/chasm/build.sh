export CC=$(which clang)
export CXX=$(which clang++)

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi
FC=$(which gfortran)

./configure --prefix=$PREFIX --with-F90=$FC --with-F90-vendor=GNU

make all
make install-dirs
make install
