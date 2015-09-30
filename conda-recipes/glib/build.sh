export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export LIBFFI_CFLAGS="-I$PREFIX/include"
export LIBFFI_LIBS="-L$PREFIX/lib -lffi"
mkdir _build && cd _build
../configure --prefix=$PREFIX --disable-maintainer-mode --disable-dependency-tracking --disable-silent-rules --disable-dtrace --disable-libelf
make all
make install
