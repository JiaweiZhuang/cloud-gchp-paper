#!/bin/bash
# read low-resolution metfields to save space and time

if [ "$1" ]; then
  RUN_DIR=$1
else
  echo 'Must specify path to gchp run directory'
  exit 1
fi

cd $RUN_DIR

rm MetDir && ln -s $HOME/ExtData/GEOS_4x5/GEOS_FP MetDir 
sed -i -e 1,120s/025x03125.nc/4x5.nc/g ExtData.rc # only scan the first few lines, do not modify non-metfields
