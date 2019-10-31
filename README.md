# Code to reproduce GCHP-on-cloud paper

Please open an issue on [issue tracker](https://github.com/JiaweiZhuang/cloud-gchp-paper/issues) if you encounter problems in any steps.

This repository serves as a permanent archive for the GCHP-on-cloud paper, using a frozen model version (12.3.2). This study focuses on computational performance, and only performs a sanity check on scientific results.

The operational support for serious research use is planned after version 13.0.0 release and will be added to https://github.com/geoschem/geos-chem-cloud. That will have constant version updates and more rigorous scientific validation.


# Table of Contents
  * [Related repositories](#related-repositories)
  * [Reproduce scalability plots](#reproduce-scalability-plots)
  * [Launch HPC cluster on AWS](#launch-hpc-cluster-on-aws)
  * [Run pre-compiled model](#run-pre-compiled-model)
  * [Build model on AWS from scratch](#build-model-on-aws-from-scratch)
  * [MPI Profiling with IPM](#mpi-profiling-with-ipm)
  * [Build model on NASA Pleiades](#build-model-on-nasa-pleiades)

## Related repositories

This repo only contains GCHP-specific code and instructions. Other generic MPI benchmark & profiling codes are at:

- https://github.com/JiaweiZhuang/aws-mpi-benchmark
- https://github.com/JiaweiZhuang/pleiades-mpi-benchmark
- https://github.com/JiaweiZhuang/ipm_util

GCHP model source code:
- Before version 12.x (used for this paper): https://github.com/geoschem/gchp
- After version 13.0.0: https://github.com/geoschem/gchp_ctm

## Reproduce scalability plots

See notebooks and log files. No need to rerun the model or set up any cluster.

## Launch HPC cluster on AWS

Follow my [cloud HPC guide](https://jiaweizhuang.github.io/blog/aws-hpc-guide/) to get familiar with [AWS ParallelCluster](https://github.com/aws/aws-parallelcluster). Current benchmark uses this specific version with [EFA enabled](https://aws.amazon.com/hpc/efa/):

    pip install --upgrade aws-parallelcluster==2.4.1

Important parameters in `~/.parallelcluster/config` are:

    enable_efa = compute
    cluster_type = spot
    placement_group = DYNAMIC
    placement = cluster
    scheduler = slurm
    base_os = centos7
    master_instance_type = c5n.large
    compute_instance_type = c5n.18xlarge
    master_root_volume_size = 80
    ebs_settings = shared

    [ebs shared]
    shared_dir = shared
    volume_type = st1
    volume_size = 500

Other parameters like key names, VPC and subnet IDs are user-specific. `spot` pricing is highly recommended, as the cost of large-scale HPC jobs can add up quickly.

## Run pre-compiled model

### Pull run directory with compiled executable

### Pull input data

Configure AWSCLI permission with `aws configure` (ref [AWS official tutorial](https://aws.amazon.com/getting-started/tutorials/backup-to-s3-cli/)), and make sure that `aws s3 ls --request-payer=requester s3://gcgrid/` runs successfully.

    mkdir -p /shared/ExtData/  # put data in the large shared volume
    ln -s /shared/ExtData/ $HOME/ExtData  # to match run directory link

    cd $HOME
    git clone https://github.com/JiaweiZhuang/cloud-gchp-paper.git
    cd cloud-gchp-paper/scripts/download_data/
    ./all_input_GCHP.sh /shared/ExtData/

By default, the model reads 4x5 metfields to save space and time. For a scientifically solid simulation, should pull the native resolution metfields via [scripts/download_data/metfields_native.sh](./scripts/download_data/metfields_native.sh) and set [scripts/configure_rundir/set_0.25met.sh](./scripts/configure_rundir/set_0.25met.sh). That will slow down I/O by 3x.

### Verify simulation results


## Build model on AWS from scratch

GCHP version 12.3.2 **requires Intel Compiler**, because the open-source GNU Fortran compiler leads to several run-time bugs like [this one](https://github.com/geoschem/gchp/issues/15). For university students, you can use the free [Intel student license](https://software.intel.com/en-us/qualify-for-free-software/student). Intel compiler license is only required for compiling source code, but not for running pre-compiled executable.

GNU Fortran compiler support is planned for version 13.0.0, especially after we have [Continuous Integration](https://github.com/geoschem/gchp/issues/36) working.

Commands in this session are better run inside `tmux` session, as compiling the libraries and model code can take about an hour.

    sudo yum install -y tmux

### Install Intel Compiler with Spack

1. Install Spack on a fresh AWS HPC cluster

```bash
cd $HOME
git clone https://github.com/spack/spack.git
cd spack
git checkout 3f1c78128ed8ae96d2b76d0e144c38cbc1c625df  # Spack v0.13.0 release in Oct 26 2019 broke some previous commands. Freeze it to ~Sep 2019.
echo 'source $HOME/spack/share/spack/setup-env.sh' >> $HOME/.bashrc
source $HOME/.bashrc
spack compilers  # check whether Spack can find system compilers
```

2. Put the Intel license file (`*.lic`) under the directory `/opt/intel/licenses/` on the AWS cluster. **This step is extremely important, otherwise the installation later will fail.**

3. Follow the steps for [Installing Intel tools within Spack](https://spack.readthedocs.io/en/latest/build_systems/intelpackage.html#installing-intel-tools-within-spack). Basically, run `spack config --scope=user/linux edit compilers` to edit the file `~/.spack/linux/compilers.yaml`. Copy and paste the following block into the file, in addition to the original `gcc` section:

```
- compiler:
    target:     x86_64
    operating_system:   centos7
    modules:    []
    spec:       intel@19.0.4
    paths:
        cc:       stub
        cxx:      stub
        f77:      stub
        fc:       stub
```

3. Run `spack install intel@19.0.4 %intel@19.0.4` to install the compiler. Spack will spend a long time downloading the installer `http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15537/parallel_studio_xe_2019_update4_composer_edition.tgz`. When the download finishes, need to confirm the license term, by simply exiting the prompted text editor (`:wq` in `vim`).

Tip: If the installation needs to be done frequently, better save the `.tgz` file to S3 and follow [Integration of Intel tools installed external to Spack](https://spack.readthedocs.io/en/latest/build_systems/intelpackage.html#integration-of-intel-tools-installed-external-to-spack) instead.

4. Run `find $(spack location -i intel) -name icc -type f -ls` to get the compiler executable path like `/home/centos/spack/opt/spack/.../icc`. Run `spack config --scope=user/linux edit compilers` again and fill in the previous `stub` entries with the actual paths: `.../icc`, `.../icpc`, `.../ifort`. (Without this step, will get `configure: error: C compiler cannot create executables` when later building NetCDF with Spack).

5. Discover the compiler executable:

```bash
source $(spack location -i intel)/bin/compilervars.sh -arch intel64
which icc icpc ifort
icc --version  # will fail if license is not available
```

**Recommend adding the `source` line to `~/.bashrc`** to avoid setting it every time.

### Build libraries using Spack and Intel compiler

1. Configure Intel-MPI

AWS ParallelCluster comes with an Intel MPI installation, which can be found by `module show intelmpi` and `module load intelmpi`.

Switching between internal compilers is done by setting [Compilation Environment Variables](https://software.intel.com/en-us/mpi-developer-reference-windows-compilation-environment-variables). To wrap Intel compilers instead of GNU compilers:

```bash
export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_FC=ifort
export I_MPI_F77=ifort
export I_MPI_F90=ifort
```

Verify that `mpicc` actually wraps `icc`:

    module load intelmpi
    mpicc --version  # should be icc instead of gcc

2. Install NetCDF with Intel compiler. Built it without MPI dependency as GCHP does not need MPI-enabled NetCDF.

    spack -v install netcdf-fortran %intel ^netcdf~mpi ^hdf5~mpi+fortran+hl

3. (optional) Here we only use IntelMPI to compile model code, not to further compile other libraries like NetCDF. If you want to further use IntelMPI to compile libraries within Spack, should add the pre-installed IntelMPI as [External Packages](https://spack.readthedocs.io/en/latest/build_settings.html#external-packages) to Spack by editing `~/.spack/packages.yaml`:

```
packages:
  intel-mpi:
    paths:
      intel-mpi@2019.4.243: /opt/intel/compilers_and_libraries_2019.4.243/linux/mpi/intel64/
    buildable: False
```

Note that unlike other open-source MPI libraries that need to be rebuilt with every compiler, a single installation of Intel-MPI works with multiple compilers. No need to specify the compiler dependency like `intel-mpi%intel` in the above Spack config file.

4. (Optional) Can also build OpenMPI as an alternative MPI implementation, although Intel-MPI is recommended for getting the best performance on AWS.

Add the following section to `~/.spack/packages.yaml`:

```
packages:
  slurm:
    paths:
      slurm@18.08.6: /opt/slurm/
    buildable: False
```

Then install by:

    spack -v install openmpi+pmi schedulers=slurm %intel

### Archive Spack directory for future use

    spack clean --all
    cd $HOME
    tar zcvf spack-gchp-env.tar.gz spack
    aws s3 cp spack-gchp-env.tar.gz s3://[your-bucket-name]/

### Compile GCHP source code

**Before compiling the model, apply those fixes**.

1. To fix https://github.com/geoschem/gchp/issues/37


```bash
ln -s $(spack location -i hdf5)/lib/* $(spack location -i netcdf)/lib/
```

2. GCHP hardcodes both `mpif90` and `mpifort` (ref [GCHP doc](http://wiki.seas.harvard.edu/geos-chem/index.php/Setting_Up_the_GCHP_Environment#Expanding_MPI_Options_.28Advanced.29)),  but Intel-MPI only has `mpif90` and `mpiifort` (ref [Intel compiler doc](https://software.intel.com/en-us/mpi-developer-guide-linux-compilers-support)). Quick fix:

```bash
cd /opt/intel/compilers_and_libraries/linux/mpi/intel64/bin
sudo ln -s ./mpif90 ./mpifort

module load intelmpi
which mpif90 mpifort  # should be the same path
```

Then, run the model build script:

    cd $HOME
    git clone https://github.com/JiaweiZhuang/cloud-gchp-paper.git
    cd cloud-gchp-paper/scripts/build_gchp/
    ./compile_gchp.sh

The build process takes ~30 minutes. Should see a success message `GCHP executable exists!` at the end.

### Pull input data

Exactly the same as in "Run pre-compiled model" section.

### Tweak run-time configurations

First apply necessary tweakings:

    cd cloud-gchp-paper/scripts/configure_rundir/
    ./setup_benchmark.sh
    ./set_4x5.met.sh

In `runConfig.sh`, set:

```bash
# 7-day simulation
Start_Time="20160701 000000"
End_Time="20160708 000000"
Duration="00000007 000000"

# write one output per day
common_freq="240000"
common_dur="240000"
common_mode="'instantaneous'"
```

Recommend first testing C24 resolution on a single node, as in the default setting:

```
CS_RES=24

NUM_NODES=1
NUM_CORES_PER_NODE=6
NY=6
NX=1
```

[`scripts/run_gchp_slurm/run_gchp_1node.sbatch`](scripts/run_gchp_slurm/run_gchp_1node.sbatch) to the run directory, and `sbatch run_gchp_1node.sbatch` to submit the job.

Then, run C180 resolution on multiple nodes:

```
CS_RES=180

NUM_NODES=8
NUM_CORES_PER_NODE=36
NY=48
NX=6
```

This setting is exactly the same as in "Run pre-compiled model" section. Use [`scripts/run_gchp_slurm/run_gchp.sbatch`](scripts/run_gchp_slurm/run_gchp.sbatch).

Domain decomposition for different core numbers:

(nodes, cores) : (NX, NY)
- (4, 144) : (24, 6)
- (8, 288) : (48, 6)
- (16, 576) : (72, 8)
- (32, 1152) : (96, 12)

### Archive run directory for future use

## MPI Profiling with IPM

Build IPM with Intel compiler and Intel MPI:

```bash
source $(spack location -i intel)/bin/compilervars.sh -arch intel64
module load intelmpi
export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_FC=ifort
export I_MPI_F77=ifort
export I_MPI_F90=ifort

wget https://github.com/nerscadmin/IPM/archive/2.0.6.tar.gz
tar zxvf 2.0.6.tar.gz
cd IPM-2.0.6

export IPM_PREFIX=$HOME/IPM
./bootstrap.sh
./configure --prefix=$IPM_PREFIX CC=icc CXX=icpc FC=ifort F77=ifort
make
make install
```

Enabled IPM using the `LD_PRELOAD` magic:

```bash
export IPM_PREFIX=$HOME/IPM
export LD_PRELOAD="$IPM_PREFIX/lib/libipm.so $IPM_PREFIX/lib/libipmf.so"
export IPM_REPORT=full
export IPM_LOG=terse  # aggregated results. still have per-rank information.
# export IPM_LOG=full  # record every MPI call, leading to GBs of log files
```

To turn off IPM profiling, just set:

    unset LD_PRELOAD

Analyze IPM results by https://github.com/JiaweiZhuang/ipm_util

## Build model on NASA Pleiades
