#!/bin/bash

#SBATCH --job-name=10_00_map_building
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p gdec
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=500G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_00_map_building.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_00_map_building.out"

# Entrée : fichier FASTA compressé
FASTA_GZ="/storage/biodatabanks/ncbi/NT/current/fasta/All/all.fasta"
OUTMAP="acc2taxa.map"

cd /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt

# Vérification du fichier
if [[ ! -f "$FASTA_GZ" ]]; then
    echo "Erreur : fichier $FASTA_GZ introuvable"
    exit 1
fi

# Extraction + parsing des headers FASTA
zgrep "^>" "$FASTA_GZ" | awk '{
    seq_id = substr($1, 2);  # enlève le >
    tax_str = "";
    for (i=2; i<=NF; i++) {
        if ($i ~ /;/) break;
        tax_str = tax_str $i " ";
    }
    gsub(/ /, ";", tax_str);
    print seq_id "\t" tax_str;
}' > "$OUTMAP"

echo "Fichier $OUTMAP généré avec succès."
