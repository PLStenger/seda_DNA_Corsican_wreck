#!/bin/bash

#SBATCH --job-name=11_blast2RMA_Adapteremoval_collapsed
#SBATCH --ntasks=1
#SBATCH -p smp
#SBATCH --mem=250G
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/11_blast2RMA_Adapteremoval_collapsed.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/11_blast2RMA_Adapteremoval_collapsed.out"

INPUT_DEDUPE=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval_collapsed
INPUT_BLASTN=/home/plstenge/seda_DNA_Corsican_wreck/11_malt_Adapteremoval_collapsed_alignment
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/12_blast2RMA_Adapteremoval_collapsed

mkdir -p "$OUTPUT"

module load conda/4.12.0
source ~/.bashrc
conda activate megan

ms=50
me=0.01
supp=0
mpi=95

for rfile in "$INPUT_DEDUPE"/*-dedupe.gz; do
    base=$(basename "$rfile" "-dedupe.gz")
    ifile="$INPUT_BLASTN/${base}.blastn.gz"
    ofile="$OUTPUT/${base}.rma6"

    if [[ -f "$ifile" ]]; then
        echo "Running blast2rma for $base"
        blast2rma -r "$rfile" -i "$ifile" -o "$ofile" -v -ms $ms -me $me -f BlastText -supp $supp -mpi $mpi -alg weighted -lcp 80
    else
        echo "Missing BLAST file for $base — skipping."
    fi
done
