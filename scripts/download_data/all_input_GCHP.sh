#/bin/bash

# Usage example:
# $ ./all_input_GCHP.sh ~/ExtData

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

./CHEM_INPUTS.sh $DATA_ROOT
./HEMCO.sh $DATA_ROOT
./fix_GMI.sh $DATA_ROOT
./GCHP-restart.sh $DATA_ROOT
./metfields_4x5.sh $DATA_ROOT
