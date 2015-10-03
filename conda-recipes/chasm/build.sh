FC=$(which gfortran)

./configure --prefix=$PREFIX --with-F90=$FC --with-F90-vendor=GNU

make all
make install-dirs
make install
