if [ `uname` == Darwin ]; then
  export CC=$(which clang)
  export CXX=$(which clang++)
fi

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi
FC=$(which gfortran)

# if [ $(uname) == Darwin ]; then
#   export LDFLAGS="-headerpad_max_install_names"
# fi

./configure --prefix=$PREFIX --with-F90=$FC --with-F90-vendor=GNU

make all
make install-dirs
make install
