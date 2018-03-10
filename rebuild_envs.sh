#!/bin/bash

set -e
set -x

DATE="2018-03-09"
CONDA_VERSION="miniconda3-4.3.27"

# Get machine
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Rebuilding environments
for environment_name in primary py2; do
    pyenv uninstall -f ${environment_name}-${DATE}
    pyenv virtualenv --force ${CONDA_VERSION} ${environment_name}-${DATE}
    pyenv local ${environment_name}-${DATE}
    conda env update --name ${environment_name}-${DATE} --file ${environment_name}.environment.yaml
    conda env export --name ${environment_name}-${DATE} > versions/${machine}.${DATE}.environment.yaml
done;

rm .python-version
