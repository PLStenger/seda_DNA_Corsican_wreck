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

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/10_Krona_dedupe_trimmomatic

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

# From MetaKraken2: https://github.com/MaestSi/MetaKraken2

# Information sur les dababases dispo: https://benlangmead.github.io/aws-indexes/k2

/home/plstenge/MetaKraken2/Build_Kraken2_db.sh -db nt -t 2
