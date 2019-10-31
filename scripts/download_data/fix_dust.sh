#!/bin/bash
# HEMCO/DUST_DEAD has some softlinks that are ignored by S3
# https://github.com/geoschem/geos-chem-cloud/issues/33

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

aws s3 cp  --request-payer=requester --recursive s3://gcgrid/HEMCO/AFCID/v2018-04/ $DATA_ROOT/HEMCO/AFCID/v2018-04/

cd $DATA_ROOT/HEMCO/DUST_DEAD
rmdir v2018-04
ln -s ../AFCID/v2018-04 ./
