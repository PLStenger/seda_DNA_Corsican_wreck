#!/bin/bash

#SBATCH --job-name=06_Komplexity_trimmomatic
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/06_Komplexity_trimmomatic.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/06_Komplexity_trimmomatic.out"

# https://github.com/eclarke/komplexity


WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/05_bbduk_after_trimmomatic

cd $WORKING_DIRECTORY

#Komplexity (filtering of low-complexity-reads)
for sample in *_paired.fastq.gz; do kz --filter --threshold 0.55 < $sample > $sample.komplex0.55; done #compress files
gzip *komplex0.55 
