#!/bin/bash
# Modify run-time configurations to make benchmark simulation more efficient

if [ "$1" ]; then
  RUN_DIR=$1
else
  echo 'Must specify path to gchp run directory'
  exit 1
fi

cd $RUN_DIR

# correctly link restart file
ln -sf $HOME/ExtData/GEOSCHEM_RESTARTS/v2016-07/initial_GEOSChem_rst.c24_standard.nc  initial_GEOSChem_rst.c24_standard.nc
ln -sf $HOME/ExtData/GEOSCHEM_RESTARTS/v2016-07/initial_GEOSChem_rst.c48_standard.nc  initial_GEOSChem_rst.c48_standard.nc
ln -sf $HOME/ExtData/GEOSCHEM_RESTARTS/v2016-07/initial_GEOSChem_rst.c180_standard.nc  initial_GEOSChem_rst.c180_standard.nc

# Turn off CEDS as GCHP 12.3.2 still reads the old, large file.
# https://github.com/geoschem/gchp/issues/3
sed -i -e "s#.--> CEDS.*# --> CEDS                   :       false#" HEMCO_Config.rc
sed -i -e "s#.--> CEDS_SHIP.*# --> CEDS_SHIP              :       false#" HEMCO_Config.rc

# Only keep SpeciesConc collection due to https://github.com/geoschem/gchp/issues/42
sed -i -e "s/'Emissions',/#'Emissions',/" HISTORY.rc
sed -i -e "s/'StateMet_avg',/#'StateMet_avg',/" HISTORY.rc
sed -i -e "s/'StateMet_inst',/#'StateMet_inst',/" HISTORY.rc

# avoid writing out giant checkpoints
# https://github.com/geoschem/gchp/issues/20
sed -i -e "s/RECORD_FREQUENCY/# RECORD_FREQUENCY/" GCHP.rc
sed -i -e "s/RECORD_REF_DATE/# RECORD_REF_DATE/" GCHP.rc
sed -i -e "s/RECORD_REF_TIME/# RECORD_REF_TIME/" GCHP.rc
sed -i -e "s/GIGCchem_INTERNAL_CHECKPOINT_FILE/# GIGCchem_INTERNAL_CHECKPOINT_FILE/" GCHP.rc
sed -i -e "s/GIGCchem_INTERNAL_CHECKPOINT_TYPE/# GIGCchem_INTERNAL_CHECKPOINT_TYPE/" GCHP.rc
