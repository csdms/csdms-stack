#! /bin/bash
export CC=$($PREFIX/babel-config --query-var=CC)
export CXX=$($PREFIX/babel-config --query-var=CXX)
export USER=nobody

echo "- https://github.com/mcflugen/sedflux,add-function-pointers" > _repos.yaml
echo "- https://github.com/mcflugen/hydrotrend,add-bmi-metadata" >> _repos.yaml
echo "- https://github.com/csdms/bmi-python" >> _repos.yaml

$PREFIX/bin/bmi-babel-fetch --file=_repos.yaml --prefix=$PREFIX > _models.yaml
$PREFIX/bin/bmi-babel-make _models.yaml
cd csdms && ./configure --prefix=$PREFIX && make all install
