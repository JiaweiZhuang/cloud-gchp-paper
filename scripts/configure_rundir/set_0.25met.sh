#!/bin/bash
# read native-resolution metfields for scientifically solid C180 simulation

if [ "$1" ]; then
  RUN_DIR=$1
else
  echo 'Must specify path to gchp run directory'
  exit 1
fi

cd $RUN_DIR

rm MetDir && ln -s $HOME/ExtData/GEOS_0.25x0.3125/GEOS_FP MetDir
sed -i -e 1,120s/4x5.nc/025x03125.nc/g ExtData.rc # only scan the first few lines, do not modify non-metfields
