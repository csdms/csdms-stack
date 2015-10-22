#! /bin/bash

if [ "$CONDA_RECIPES" != "runtime" ]; then
  cd conda-recipes

  CONDA_FILES_TO_UPLOAD=$(conda build --output --python=$TRAVIS_PYTHON_VERSION --numpy=$NUMPY_VERSION $CONDA_RECIPES)

  echo Deploying $CONDA_FILES_TO_UPLOAD to $CONDA_USERNAME
  anaconda login --username=$CONDA_USERNAME --password=$CONDA_PASSWORD
  anaconda upload --force --user csdms --channel nightly --channel main $CONDA_FILES_TO_UPLOAD
fi
