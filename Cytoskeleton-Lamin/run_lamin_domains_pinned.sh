#!/bin/bash 
#
#SBATCH --job-name=wig_1
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

pathfolder=`pwd`

cd ${SLURM_SUBMIT_DIR}

#########################################




# qsub -v chromatinShellK="1e0",ioCoeff="1e0" run_lamin_domains.sh
chromatinShellK="1e-1"
ioCoeff="0.0"

s=10242 #38262 #152442
c=128 #1024
chrLJ=1.0
A="0.0" #0.1 #0.0 #"1e-4" # silvia mod, it was 1e-4
slinkA=1.0
pHigh=0.02 #0.002
pLow=0.001 #0.001
lr=0.45
ioDensity=0.16
radiusScale=1.1
outerImproper=0.0 #silvia modification, it was 1000
nuclearImproper="1e0"
softImproper="1e-2"
nuclearSpring="1.0"
nuclearSpring2="1.0"
dumpDir="file_vtk"

rm -rf ${dumpDir}

mkdir ${dumpDir}

inputFile="input_pinned.lmp"
bondsFile="input_pinned_bondcoeff.lmp"
sedbondsFile="sed_pinned_bondcoeff.lmp"
Kbond="1.0"
Kmove="1e-1"

#substitute bond K between lamina and cytoskeleton in bondscoefficient file
sed 's/SUBSTBONDK/'${Kbond}'/g'  ${pathfolder}/${sedbondsFile} > ${pathfolder}/${bondsFile}



/opt/share/openmpi-3.0.0-el-6.9/bin/mpiexec /home/bonfanti/Apps/lammps-22Jun18/src/lmp_mpi -in lammps_pinned.in -v bondsFile ${bondsFile}  -v dumpDir ${dumpDir} -v inputFile ${inputFile} -v yukawaA ${A} -v slinkYukawaA ${slinkA} -v innerOuterBondCoeff ${ioCoeff} -v outerImproper ${outerImproper} -v nuclearImproper ${nuclearImproper} -v chromatinShellBondCoeff ${chromatinShellK} -v chrLJ ${chrLJ} -v softImproper ${softImproper} -v Kmove ${Kmove}

