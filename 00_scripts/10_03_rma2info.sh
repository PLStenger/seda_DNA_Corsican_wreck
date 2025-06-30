#!/bin/bash

#SBATCH --job-name=10_03_rma2info
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_03_rma2info.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_03_rma2info.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/12_rma2info

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate megan

cd $INPUT || exit

# Boucle sur tous les fichiers .rma6
for file in *.rma6; do
    # Extraire le nom sans extension
    base_name="${file%.rma6}"
    # Créer le nom de sortie
    output="$OUTPUT/${base_name}_taxonomy_counts.txt"
    # Lancer la commande rma2info
    echo "Processing $file → $output"
    rma2info -i "$file" -t -o "$output"
done
