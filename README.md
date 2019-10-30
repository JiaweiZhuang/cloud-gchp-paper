# Code to reproduce GCHP-on-cloud paper

This repository serves as a permanent archive for the GCHP-on-cloud paper, using a frozen model version (12.3.2). This study focuses on computational performance, and only performs a sanity check on scientific results.

The operational support for serious research use is planned after version 13.0.0 release and will be added to https://github.com/geoschem/geos-chem-cloud. That will have constant version updates and more rigorous scientific validation.

# Table of Contents
  * [Related repositories](#related-repositories)
  * [Launch HPC cluster on AWS](#launch-hpc-cluster-on-aws)
  * [Run pre-compiled model](#run-pre-compiled-model)
  * [Build model on AWS from scratch](#build-model-on-aws-from-scratch)
  * [Build model on NASA Pleiades](#build-model-on-nasa-pleiades)

## Related repositories

This repo only contains GCHP-specific code and instructions. Other generic MPI benchmark & profiling codes are at:

- https://github.com/JiaweiZhuang/aws-mpi-benchmark
- https://github.com/JiaweiZhuang/pleiades-mpi-benchmark
- https://github.com/JiaweiZhuang/ipm_util

GCHP model source code:
- Before version 12.x (used for this paper): https://github.com/geoschem/gchp
- After version 13.0.0: https://github.com/geoschem/gchp_ctm

## Launch HPC cluster on AWS

## Run pre-compiled model

### Pull run directory with compiled executable

### Pull input data

### Verify simulation results

## Build model on AWS from scratch

**Requires Intel Compiler license**.

### Install Intel Compiler

### Build libraries using Spack and Intel compiler

### Compile GCHP source code

### Pull input data and run model

Exactly the same as in "Run pre-compiled model" section.

### Archive run directory for future use

## Build model on NASA Pleiades
