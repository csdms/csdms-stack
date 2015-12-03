ant dist
install -d -m755 $PREFIX/lib
install -m664 dist/$PKG_NAME.jar $PREFIX/lib
