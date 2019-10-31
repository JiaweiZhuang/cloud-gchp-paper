#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

# exclude huge data directories that are not in use by default
time aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/HEMCO/ $DATA_ROOT/HEMCO \
--exclude "NEI2011/v2015-03/*" \
--exclude "NEI2011ek/v2018-04/*" \
--exclude "NEI2008/*" \
--exclude "CH4/*" \
--exclude "QFED/*" \
--exclude "GFAS/*" \
--exclude "CEDS/*" \
--include "CEDS/v2018-08/2014/*" \
--exclude "OFFLINE_LNOX/v2018-11/*" \
--exclude "OFFLINE_BIOVOC/*" \
--exclude "OFFLINE_DUST/*" \
--exclude "OFFLINE_SEASALT/*" \
--exclude "OFFLINE_SOILNOX/*"
