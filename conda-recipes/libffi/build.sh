#!/bin/bash
export CC=$(which clang)
export CXX=$(which clang++)

if [[ -z $CC ]]; then
  export CC=$(which gcc)
  export CXX=$(which g++)
fi

./configure --prefix="${PREFIX}"
make
make install

# Put headers in regular location
mkdir -p "${PREFIX}/include/"
mv "${PREFIX}"/lib/libffi-3.2.1/include/*.h "${PREFIX}/include/"
rm -rf "${PREFIX}/lib/libffi-3.2.1"
