#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

# GEOSFP 0.25x0.3125 CN field
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_0.25x0.3125/GEOS_FP/2011/01/ $DATA_ROOT/GEOS_0.25x0.3125/GEOS_FP/2011/01/

# GEOSFP 0.25x0.3125 8-day field (~80 GB)
for DATE in {01..08}
do
  aws s3 cp --request-payer=requester --recursive \
  s3://gcgrid/GEOS_0.25x0.3125/GEOS_FP/2016/07/ $DATA_ROOT/GEOS_0.25x0.3125/GEOS_FP/2016/07/ \
  --exclude "*" \
  --include "GEOSFP.201607$DATE.*.025x03125.nc"
done
