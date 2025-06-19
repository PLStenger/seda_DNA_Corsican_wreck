#!/bin/bash

#SBATCH --job-name=quality_check_by_FastQC_bbduk
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/03_quality_check_by_FastQC_bbduk.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/03_quality_check_by_FastQC_bbduk.out"

# installing FastQC from https://www.bioinformatics.babraham.ac.uk/projects/download.html
# FastQC v0.11.9 (Mac DMG image)

# Correct tool citation : Andrews, S. (2010). FastQC: a quality control tool for high throughput sequence data.

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/05_bbduk_outpur
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/04_quality_check_adapterremoval_bbduk

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate fastqc

cd $WORKING_DIRECTORY

for FILE in $(ls $WORKING_DIRECTORY/*)
do
      fastqc $FILE -o $OUTPUT
done ;

conda deactivate

module load conda/4.12.0
source ~/.bashrc
conda activate multiqc

# Run multiqc for quality summary

multiqc $OUTPUT

conda deactivate
