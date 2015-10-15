#mkdir _build && cd _build
#cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX
#make all -j4
#make install
export CC=$(babel-config --query-var=CC)
export CXX=$(babel-config --query-var=CXX)
export USER=nobody

if [[ -z $JAVA_HOME ]]; then
  echo "warning: JAVA_HOME is not set."
else
  export PATH=$JAVA_HOME/bin:$PATH
fi

echo "- https://github.com/csdms/cem-old,mcflugen/add-function-pointers" > _repos.yaml

$PREFIX/bin/bmi-babel-fetch --no-build --file=_repos.yaml --prefix=$PREFIX > _models.yaml
$PREFIX/bin/bmi-babel-make _models.yaml

cd csdms && ./configure --prefix=$PREFIX && make all install
