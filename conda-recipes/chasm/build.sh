./configure --prefix=$PREFIX --with-F90=$(which gfortran) --with-F90-vendor=GNU
make all
make install-dirs
make install
