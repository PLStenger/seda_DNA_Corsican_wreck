#!/bin/bash

#SBATCH --job-name=00_adapterremoval_whole_pipeline
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_adapterremoval_whole_pipeline.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_adapterremoval_whole_pipeline.out"

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/00_scripts

cd $WORKING_DIRECTORY

sbatch 02_adapterremoval.sh
sbatch 03_quality_check_by_FastQC_adapteremoval.sh
sbatch 04_Komplexity_adapterremoval.sh
sbatch 05_quality_check_after_komplexity_adpaterremoval.sh
sbatch 06_dedupe_adapterremoval.sh
sbatch 07_quality_check_after_dedup_adapterremoval.sh
sbatch 08_bbduk_after_Adapteremoval.sh
sbatch 09_quality_check_after_bbduk_adapterremoval.sh
