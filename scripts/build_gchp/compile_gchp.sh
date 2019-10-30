#!/bin/bash

GC_VERSION="12.3.2"
GCHP_VERSION="12.3.2-intelmpi-cloud-gchp-paper"
TOP_DIR="$HOME/gchp_12.3.2"

# Mock input data directory, need to pull real data later
mkdir -p $HOME/ExtData/HEMCO

# Create tutorial folder for demo project
mkdir $TOP_DIR
cp ./gchp.intelmpi.env $TOP_DIR/gchp.env
cd $TOP_DIR

# Source code
git clone https://github.com/geoschem/geos-chem.git Code.GCHP
cd Code.GCHP
git checkout $GC_VERSION

# GCHP subdirectory
git clone https://github.com/JiaweiZhuang/gchp.git GCHP
cd GCHP
git checkout $GCHP_VERSION

# generate run directory
cd Run
rm ${HOME}/.geoschem/config
printf "$HOME/ExtData \n 2 \n 1 \n $TOP_DIR \n gchp_standard \n n" | ./createRunDir.sh

# compile source code
cd $TOP_DIR/gchp_standard
ln -sf $TOP_DIR/gchp.env ./gchp.env
make build_all
