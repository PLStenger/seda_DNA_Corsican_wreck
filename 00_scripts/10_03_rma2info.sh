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


module load conda/4.12.0
source ~/.bashrc
conda activate megan

INPUT_DIR="/home/plstenge/seda_DNA_Corsican_wreck/12_blast2RMA_Adapteremoval_collapsed"
OUTPUT_DIR="/home/plstenge/seda_DNA_Corsican_wreck/13_rma2info_Adapteremoval_collapsed"

mkdir -p "$OUTPUT_DIR"

cd "$INPUT_DIR" || { echo "Erreur : dossier introuvable"; exit 1; }

for file in *.rma6; do
    base_name="${file%.rma6}"
    output="${OUTPUT_DIR}/${base_name}_taxonomy_counts.txt"
    echo "Processing $file → $output"
    rma2info -i "$file" -c2c -o "$output"
done
