#!/bin/bash 
#
#SBATCH --job-name=parEnv1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=0
#SBATCH --mail-type=NONE
#SBATCH --output=run.out

export PATH=${PATH}:/bin

echo "Job ${SLURM_JOB_NAME} submitted from host ${SLURM_SUBMIT_HOST} ; started "$(date)" ; jobid ${SLURM_JOB_ID}"
echo "Running on host: $(hostname)."
echo "In directory: $(pwd) (Should be the same than this ${SLURM_SUBMIT_DIR})."

cd ${SLURM_SUBMIT_DIR}

######################################### PARAMETER FOR SIMULATION

chromatinShellK="1e-1"
ioCoeff="0.0" 
s=10242 
c=128 
chrLJ=1.0
A="0.0" 
slinkA=1.0
pHigh=0.02 
pLow=0.001 
lr=0.45
ioDensity=0.16
radiusScale=1.1
outerImproper=0.0
nuclearImproper="1e0"
softImproper="1e-2"
nuclearSpring="5.0"
nuclearSpring2="5.0"
dumpDir="file_vtk"
inputFile="input.lmp"
bondsFile="input_bondcoeff.lmp"

######################################### LAUNCH SIMULATION

rm -rf ${dumpDir}
mkdir ${dumpDir}

/opt/share/openmpi-3.0.0-el-6.9/bin/mpiexec /home/bonfanti/Apps/lammps-22Jun18/src/lmp_mpi -in lammps.in -v bondsFile ${bondsFile}  -v dumpDir ${dumpDir} -v inputFile ${inputFile} -v yukawaA ${A} -v slinkYukawaA ${slinkA} -v innerOuterBondCoeff ${ioCoeff} -v outerImproper ${outerImproper} -v nuclearImproper ${nuclearImproper} -v chromatinShellBondCoeff ${chromatinShellK} -v chrLJ ${chrLJ} -v softImproper ${softImproper}

