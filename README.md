# Computational model of the cell nucleus including chromatin fibers, nuclear shell, and coupling with the cytoskeleton
This repository includes the necessary scripts and LAMMPS input files to reproduce some of the simulations reported in:

MC Lionetti, S Bonfanti, MR Fumagalli, Z Budrikis, F Font-Clos, G Costantini, O Chepizhko, S Zapperi, CAM La Porta.
"Chromatin and Cytoskeletal Tethering Determine Nuclear Morphology in Progerin-Expressing Cells".
Biophysical Journal, Volume 118, Issue 9, 5 May 2020, Pages 2319-2332.

https://doi.org/10.1016/j.bpj.2020.04.001

[link to publication](https://www.sciencedirect.com/science/article/abs/pii/S0006349520303015)

## Simulating nuclear blebs
You can simulate the nuclear blebs using the files in folder `Chromatin-Lamin/`: 

 -- input.lmp : initial configuration for LAMMPS

 -- input_bondcoeff.lmp: initial configuration, specification of bonds among nodes for LAMMPS

 -- run_lamin_domains.sh: bash script to launch the simulation on a cluster machine. Contains the specification of the parameters to launch the LAMMPS simulation. Specifically the parameters set are those needed to reproduce the nuclear blebs in the lamina. The user can change such parameters to reproduce other conditions reported in the paper.  

 -- lammps.in: LAMMPS simulation script. 

## Simulating nuclear blebs and cytoskeletal activity
You can simulate the nuclear blebs with cytoskeletal activity using the files in folder `Cytoskeleton-Lamin/`: 
 input_pinned.lmp : initial configuration for LAMMPS

 -- input_pinned_bondcoeff.lmp: initial configuration, specification of bonds among nodes for LAMMPS

 -- run_lamin_domains_pinned.sh: bash script to launch the simulation on a cluster machine. Contains the specification of the parameters to launch the LAMMPS simulation. Specifically the parameters set are those needed to reproduce the nuclear blebs in the lamina, with the addition of cytoskeletal elements. The user can change such parameters to reproduce other conditions reported in the paper.  

 -- sed_pinned_bondcoeff.lmp: LAMMPS simulation script, where the value of tethers is changed through the bash script. The output files is: 

 -- lammps_pinned.in: LAMMPS simulation script. 

### Parameter Setup 
The bash files run*.sh contain the parameters to pass to Lammps script.
Here we explain some relevant parameter, for more details on parameters please refer to Methods section of the paper.

 -- "nuclearImproper" : improper stiffness of all the lamina surface

 -- "softImproper" : improper stiffness of the domain walls. Therefore "softImproper" allows the swich on/off of the domain walls. Domain walls are element of the lamina which are more bendable.

Setting "nuclearImproper"="softImproper" will disable the domain walls in the simulations, since the lamin walls are no longer distinguishable from the rest of the membrane.
Tethers values are defined both in the initial configuration files or in the Lammps script. 

The initial configurations consist in 2 files, input_*.lmp containing the coordinates of the configuration with bonds, angles and impropers
and  the other one 'input_*_bondcoeff.lmp` containing the specification of bond coefficients between the nodes.
Both files are loaded at the beginning of the Lammps script.

### Run Simulations
To launch the simulation (e.g. with SLURM), in bash you can type:
```
sbatch run_lamin_domains.sh
```
### LAMMPS Version 
Lammps-22Jun18
