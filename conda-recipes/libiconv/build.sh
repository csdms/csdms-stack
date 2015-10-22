mkdir _build
cd _build

../configure --prefix=$PREFIX --enable-shared --enable-static

#  --disable-debug
#  --disable-dependency-tracking
#  --enable-extra-encodings

# make -f Makefile.devel
make
make install
