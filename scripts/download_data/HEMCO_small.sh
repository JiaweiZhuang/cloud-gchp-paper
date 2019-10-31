#!/bin/bash
# From https://github.com/geoschem/geos-chem-cloud/issues/25#issuecomment-548188720

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/ACET/v2014-07 $DATA_ROOT/HEMCO/ACET/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/AEIC/v2015-01 $DATA_ROOT/HEMCO/AEIC/v2015-01
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/ALD2/v2017-03 $DATA_ROOT/HEMCO/ALD2/v2017-03
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/APEI/v2016-11 $DATA_ROOT/HEMCO/APEI/v2016-11
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/AnnualScalar/v2014-07 $DATA_ROOT/HEMCO/AnnualScalar/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/BCOC_BOND/v2014-07 $DATA_ROOT/HEMCO/BCOC_BOND/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/BIOFUEL/v2014-07 $DATA_ROOT/HEMCO/BIOFUEL/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/BROMINE/v2015-02 $DATA_ROOT/HEMCO/BROMINE/v2015-02
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/C2H6_2010/v2017-05 $DATA_ROOT/HEMCO/C2H6_2010/v2017-05
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/DICE_Africa/v2016-10 $DATA_ROOT/HEMCO/DICE_Africa/v2016-10
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/DMS/v2015-07 $DATA_ROOT/HEMCO/DMS/v2015-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/DUST_DEAD/v2014-07 $DATA_ROOT/HEMCO/DUST_DEAD/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/DUST_DEAD/v2018-04 $DATA_ROOT/HEMCO/DUST_DEAD/v2018-04
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/EDGARv42/v2015-02 $DATA_ROOT/HEMCO/EDGARv42/v2015-02
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/EDGARv43/v2016-11 $DATA_ROOT/HEMCO/EDGARv43/v2016-11
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/EMEP/v2015-03 $DATA_ROOT/HEMCO/EMEP/v2015-03
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/GEIA/v2014-07 $DATA_ROOT/HEMCO/GEIA/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/GFED4/v2015-10 $DATA_ROOT/HEMCO/GFED4/v2015-10
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/GMI/v2015-02 $DATA_ROOT/HEMCO/GMI/v2015-02
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/IODINE/v2017-09 $DATA_ROOT/HEMCO/IODINE/v2017-09
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/MASKS/v2018-09 $DATA_ROOT/HEMCO/MASKS/v2018-09
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/MEGAN/v2018-05 $DATA_ROOT/HEMCO/MEGAN/v2018-05
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/MIX/v2015-03 $DATA_ROOT/HEMCO/MIX/v2015-03
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/NEI2005/v2014-09 $DATA_ROOT/HEMCO/NEI2005/v2014-09
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/NEI2011/v2017-02-MM_for_GCHP $DATA_ROOT/HEMCO/NEI2011/v2017-02-MM_for_GCHP
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/NH3/v2014-07 $DATA_ROOT/HEMCO/NH3/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/NH3/v2018-04 $DATA_ROOT/HEMCO/NH3/v2018-04
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/NOAA_GMD/v2018-01 $DATA_ROOT/HEMCO/NOAA_GMD/v2018-01
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/OFFLINE_LNOX/v2018-06 $DATA_ROOT/HEMCO/OFFLINE_LNOX/v2018-06
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/OFFLINE_SSALT/v2018-06 $DATA_ROOT/HEMCO/OFFLINE_SSALT/v2018-06
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/OMOC/v2018-01 $DATA_ROOT/HEMCO/OMOC/v2018-01
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/POET/v2017-03 $DATA_ROOT/HEMCO/POET/v2017-03
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/RETRO/v2014-07 $DATA_ROOT/HEMCO/RETRO/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/SOA/v2014-07 $DATA_ROOT/HEMCO/SOA/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/SOILNOX/v2014-07 $DATA_ROOT/HEMCO/SOILNOX/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/STRAT/v2015-01 $DATA_ROOT/HEMCO/STRAT/v2015-01
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/STREETS/v2014-07 $DATA_ROOT/HEMCO/STREETS/v2014-07
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/TIMEZONES/v2015-02 $DATA_ROOT/HEMCO/TIMEZONES/v2015-02
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/TOMS_SBUV/v2016-11 $DATA_ROOT/HEMCO/TOMS_SBUV/v2016-11
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/UVALBEDO/v2015-03 $DATA_ROOT/HEMCO/UVALBEDO/v2015-03
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/VOLCANO/v2015-02 $DATA_ROOT/HEMCO/VOLCANO/v2015-02
