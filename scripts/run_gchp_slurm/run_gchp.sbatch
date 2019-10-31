#!/bin/bash

#SBATCH --job-name=gchp
#SBATCH --output=run_N8n288.log

#SBATCH --nodes=8
#SBATCH --ntasks-per-node=36
#SBATCH --time=12:00:00

rm cap_restart
source gchp.env
mpirun ./geos
