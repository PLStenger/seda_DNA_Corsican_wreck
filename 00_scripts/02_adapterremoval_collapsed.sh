#!/bin/bash
#SBATCH --job-name=02_adapterremoval
#SBATCH --ntasks=1
#SBATCH -p smp
#SBATCH --mem=250G
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval.out"

WORKING_DIRECTORY="/home/plstenge/seda_DNA_Corsican_wreck/01_raw_data"
OUTPUT="/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_adapterremoval"
ADAPTER_FILE="/home/plstenge/seda_DNA_Corsican_wreck/99_softwares/adapters_adpateremoval.txt"

mkdir -p "$OUTPUT"

module load conda/4.12.0
source ~/.bashrc
conda activate adapterremoval

cd "$WORKING_DIRECTORY"

# Boucle 1: Démultiplexage et trimming/collapse pour chaque échantillon
for r1_file in *_R1.fastq.gz; do
    r2_file="${r1_file/_R1/_R2}"
    [[ ! -f "$r2_file" ]] && { echo "ERREUR: Fichier R2 manquant pour $r1_file" >&2; continue; }
    base_name="${r1_file%%_R1.fastq.gz}"
    AdapterRemoval \
        --adapter-list "$ADAPTER_FILE" \
        --file1 "$r1_file" \
        --file2 "$r2_file" \
        --basename "$OUTPUT/${base_name}_demux" \
        --trimns \
        --trimqualities \
        --minlength 25 \
        --qualitymax 50 \
        --collapse \
        --gzip
done

# Boucle 2: Nettoyage des reads pour chaque échantillon (dans OUTPUT)
cd "$OUTPUT"
for demux_file in *_demux.pair1.fastq.gz; do
    pair2_file="${demux_file/pair1/pair2}"
    [[ ! -f "$pair2_file" ]] && { echo "ERREUR: Fichier pair2 manquant pour $demux_file" >&2; continue; }
    base_name="${demux_file%_demux.pair1.fastq.gz}"
    base_name="${base_name##*/}" # pour garder juste le nom de base
    AdapterRemoval \
        --file1 "$demux_file" \
        --file2 "$pair2_file" \
        --basename "$OUTPUT/${base_name}_paired" \
        --trimns \
        --trimqualities \
        --minlength 25 \
        --qualitymax 50 \
        --collapse \
        --gzip
done

conda deactivate
