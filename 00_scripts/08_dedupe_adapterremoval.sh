#!/bin/bash

#SBATCH --job-name=08_dedupe_adapterremoval
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/08_dedupe_adapterremoval.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/08_dedupe_adapterremoval.out"

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/07_komplexity_adapterremoval 
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval
DEDUPE=/home/plstenge/bbmap/dedupe.sh

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate bbduk

cd $WORKING_DIRECTORY

#Dedupe in BBmap (can run in .gz, but the duplicate file will still be a fasta not fastq)
for sample in *.truncated*; do $DEDUPE in=$sample out=$OUTPUT/$sample-dedupe.gz outd=$OUTPUT/$sample-duplicates.fa ac=f; done
