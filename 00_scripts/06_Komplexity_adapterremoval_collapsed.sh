#!/bin/bash

#SBATCH --job-name=06_Komplexity_adapterremoval_collapsed
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/06_Komplexity_adapterremoval_collapsed.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/06_Komplexity_adapterremoval_collapsed.out"

# https://github.com/eclarke/komplexity

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/05_bbduk_after_Adapteremoval_collapsed
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/07_komplexity_adapterremoval_collapsed

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $WORKING_DIRECTORY

module load conda/4.12.0
source ~/.bashrc
conda activate base
conda activate komplexity

# uncompress files
gunzip *

# run Komplexity (filtering of low-complexity-reads)
for sample in *.collapsed ; do kz --filter --threshold 0.55 < $sample > $sample.komplex0.55; done 

# compress files
gzip *komplex0.55* 

scp -r *komplex0.55* $OUTPUT
