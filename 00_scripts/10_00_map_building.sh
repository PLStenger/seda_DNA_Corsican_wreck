#!/bin/bash

#SBATCH --job-name=10_00_map_building
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_00_map_building.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_00_map_building.out"


# Entrée : FASTA compressé
FASTA_GZ="/home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz"
# Sortie : fichier acc2taxa.map
OUTMAP="acc2taxa.map"

# Extraire les headers, parser les IDs et assigner un taxid simulé par hiérarchie
zgrep "^>" "$FASTA_GZ" | awk -F'[ ;]' '
{
  seq_id = substr($1, 2);  # enlève le '>'
  tax_str = "";
  for (i=2; i<=NF; i++) {
    if ($i ~ /;/) break;
    tax_str = tax_str $i " ";
  }
  gsub(/ /, ";", tax_str);
  print seq_id "\t" tax_str;
}' > "$OUTMAP"
