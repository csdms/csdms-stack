#! /bin/bash

echo Deploying $CONDA_FILES_TO_UPLOAD to $CONDA_USERNAME
anaconda login --username=$CONDA_USERNAME --password=$CONDA_PASSWORD
anaconda upload --force --user csdms --channel nightly --channel main $CONDA_FILES_TO_UPLOAD
