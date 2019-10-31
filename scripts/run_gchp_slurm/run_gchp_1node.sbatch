#!/bin/bash

#SBATCH --job-name=gchp
#SBATCH --output=run_N1n6.log

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --time=1:00:00

rm cap_restart
source gchp.env
mpirun ./geos
