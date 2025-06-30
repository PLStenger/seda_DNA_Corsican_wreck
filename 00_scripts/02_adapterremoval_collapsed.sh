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
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval_collapsed.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_adapterremoval_collapsed.out"

# installing FastQC from https://anaconda.org/bioconda/adapterremoval
# adapterremoval v2.3.4 
# And see https://github.com/MikkelSchubert/adapterremoval

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/01_raw_data
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_adapterremoval_collapsed
ADAPTER_FILE=/home/plstenge/seda_DNA_Corsican_wreck/99_softwares/adapters_adpateremoval.txt

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

# Boucle 1: Démultiplexage pour chaque échantillon
echo "## Début du démultiplexage"
for r1_file in *_R1.fastq.gz; do
    # Vérifier les fichiers R2 correspondants
    r2_file="${r1_file/_R1/_R2}"
    if [[ ! -f "$r2_file" ]]; then
        echo "ERREUR: Fichier R2 manquant pour $r1_file" >&2
        continue
    fi

    # Extraire le préfixe du nom de base
    base_name="${r1_file%%_R1.fastq.gz}"
    
    echo "# Traitement de $base_name"

   # AdapterRemoval --adapter-list "$ADAPTER_FILE" --file1 "$r1_file" --file2 "$r2_file" --basename "${base_name}_demux" --demultiplex-only --gzip
    
    AdapterRemoval \
    --adapter-list "$ADAPTER_FILE" \
    --file1 "$r1_file" \
    --file2 "$r2_file" \
    --basename $OUTPUT/"${base_name}_demux" \
    --qualitymax 50 \
    --trimns \       
    --trimqualities \ 
    --minlength 25 \     
    --collapse \         
    --gzip
done

echo "## Démultiplexage terminé"
echo

cd $OUTPUT 

# Boucle 2: Nettoyage des reads pour chaque échantillon
echo "## Début du nettoyage des reads"
for demux_file in *_demux.pair1.fastq.gz; do
    pair2_file="${demux_file/pair1/pair2}"
    base_name="${demux_file%_demux.pair1.fastq.gz}"
    
AdapterRemoval \
    --file1 "$demux_file" \
    --file2 "$pair2_file" \
    --basename "${base_name}_paired" \
    --trimns \
    --trimqualities \
    --minlength 25 \
    --qualitymax 50 \
    --collapse \
    --gzip
    
done

echo "## Nettoyage des reads terminé"

conda deactivate
