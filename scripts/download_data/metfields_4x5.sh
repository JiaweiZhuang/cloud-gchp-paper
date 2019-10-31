#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

# GEOSFP 4x5 CN field
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2011/01/ $DATA_ROOT/GEOS_4x5/GEOS_FP/2011/01/

# GEOSFP 4x5 1-month (~2.5GB)
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/ $DATA_ROOT/GEOS_4x5/GEOS_FP/2016/07/
