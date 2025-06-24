#!/bin/bash

#SBATCH --job-name=10_kraken_krona
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_kraken_krona.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_kraken_krona.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/10_Krona_dedupe_trimmomatic

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

# From MetaKraken2: https://github.com/MaestSi/MetaKraken2

module load conda/4.12.0

source ~/.bashrc
conda activate MetaKraken2_env

cd $OUTPUT

#gunzip /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic/clean_1120_sed6_rep3_R1_paired.fastq.komplex0.55.gz-dedupe.gz

for FILE in $(ls $INPUT/*)
do
      /home/plstenge/MetaKraken2/MetaKraken2.sh -f $FILE -db /home/plstenge/MetaKraken2/viral_db -c 0.5 -t 2
done ;

#/home/plstenge/MetaKraken2/MetaKraken2.sh -f /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic/clean_1120_sed6_rep3_R1_paired.fastq.komplex0.55.gz-dedupe  -db /home/plstenge/MetaKraken2/viral_db -c 0.1 -t 2 -o /home/plstenge/seda_DNA_Corsican_wreck/10_Krona_dedupe_trimmomatic
