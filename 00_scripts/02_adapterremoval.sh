#!/bin/bash

#SBATCH --job-name=02_adapterremoval
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval.out"

# installing FastQC from https://anaconda.org/bioconda/adapterremoval
# adapterremoval v2.3.4 
# And see https://github.com/MikkelSchubert/adapterremoval

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/01_raw_data
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_adapterremoval

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate adapterremoval

# Infos de Thibaut AULAGNON:
# Les séquences sont de « trop bonnes » qualité et certains outils (Adapterremoval2 et bbduk) plantent car ils ne reconnaissent pas le Phred+33.
# La parade est d’augmenter la –qualitymax : de 41 à 50 pour Adapterremoval. (Il ne faut pas monter à 93 car c’est rejeté ensuite par bbduk).
# Aussi, avec  Adapterremoval, les adaptateur sont trimmé sur les séquences mergées uniquement, ça ne marche pas pour les « PE ». Mais bbduk peut gérer après en même temps que le phix.

cd $WORKING_DIRECTORY

#for R1 in *R1*
#do
#   R2=${R1//R1.fastq.gz/R2.fastq.gz}

#   AdapterRemoval --file1 $R1 --file2 $R2 –qualitymax 50 --basename $OUTPUT/_paired

#done ;

AdapterRemoval --file1 1120_sed6_rep3_R1.fastq.gz --file2 1120_sed6_rep3_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
AdapterRemoval 1120_sed6_rep3_R1.fastq.gz 1120_sed6_rep3_R2.fastq.gz --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 1121_sed8_rep1_R1.fastq.gz --file2 1121_sed8_rep1_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 1122_sed8_rep2_R1.fastq.gz --file2 1122_sed8_rep2_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 1129_sed6_rep1_R1.fastq.gz --file2 1129_sed6_rep1_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 1130_sed6_rep2_R1.fastq.gz --file2 1130_sed6_rep2_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 1131_sed8_rep3_R1.fastq.gz --file2 1131_sed8_rep3_R2.fastq.gz  --qualitymax 50 --basename $OUTPUT
#AdapterRemoval --file1 NTC_sed_R1.fastq.gz --file2 NTC_sed_R2.fastq.gz --qualitymax 50 --basename $OUTPUT

conda deactivate
