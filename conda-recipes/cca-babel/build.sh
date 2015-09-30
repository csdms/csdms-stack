export CC=$(which gcc)
export CXX=$(which g++)
export PYTHON=$PREFIX/bin/python
export JAVA=/usr/java/default/bin/java
export JAVAPREFIX=/usr/java/default
export FC=$(which gfortran)
export F77=$(which gfortran)
export F90=$(which gfortran)
export F03=$(which gfortran)

./configure --prefix=$PREFIX --disable-documentation --disable-java
make all -j4
make install
