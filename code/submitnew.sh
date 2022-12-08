#!/bin/bash
#SBATCH -t 01:00:00
#SBATCH --array=1-2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1500MB
module load R/R-4.0.1
Rscript Project.R "mydata$SLURM_ARRAY_TASK_ID.csv"
