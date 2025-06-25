#!/bin/bash

#SBATCH --job-name=04_Komplexity_adapterremoval.
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_Komplexity_adapterremoval.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_Komplexity_adapterremoval.out"

# https://github.com/eclarke/komplexity

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/05_komplexity_adapterremoval

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $WORKING_DIRECTORY

# uncompress files
#gunzip *

# run Komplexity (filtering of low-complexity-reads)
for sample in *truncated ; do kz --filter --threshold 0.55 < $sample > $sample.komplex0.55; done 

# compress files
gzip *komplex0.55* 

scp -r *komplex0.55* $OUTPUT

