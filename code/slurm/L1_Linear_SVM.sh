#!/bin/bash

###############################
#                             #
#  1) Job Submission Options  #
#                             #
###############################

# Name
#SBATCH --job-name=L1Linear

# Resources
# For MPI, increase ntasks-per-node
# For multithreading, increase cpus-per-task
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=20:00:00

# Account
#SBATCH --account=pschloss1
#SBATCH --partition=standard

# Logs
#SBATCH --mail-user=begumtop@umich.edu
#SBATCH --mail-type=FAIL

# Environment
##SBATCH --array=1-100
##SBATCH --export=ALL

# --array is array parameter, the same job will be submitted the length of the input,
# each with its own unique array id ($SLURM_ARRAY_TASK_ID)

# Connecting node to internet
source /etc/profile.d/http_proxy.sh 

# List compute nodes allocated to the job
if [[ $SLURM_JOB_NODELIST ]] ; then
	echo "Running on"
	scontrol show hostnames $SLURM_JOB_NODELIST
	echo -e "\n"
fi


# Load Modules:
#  1) R/3.5.0
#  2)  r-biomed-libs
#  3) run Rscript code/learning/load_caret_models_flux.R




#####################
#                   #
#  2) Job Commands  #
#                   #
#####################

# vector index starts at 0 so shift array by one
seed=$(($SLURM_ARRAY_TASK_ID - 1))

# print out which model is being run in each job
echo Using "L1 Linear SVM"

# Using $SLURM_ARRAY_TASK_ID to select parameter set
Rscript code/learning/load_caret_models_flux.R
#Rscript code/learning/main.R $seed "L1_Linear_SVM"
make data/temp/best_hp_results_L1_Linear_SVM_$seed.csv

echo "Script complete"
echo "sbatch working directory is"
echo $SLURM_SUBMIT_DIR
scontrol show job $SLURM_ARRAY_JOB_ID
exit
