#!/bin/bash

#SBATCH --job-name=00_split_fasta
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/00_split_fasta.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/00_split_fasta.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol 

cd $INPUT

# splitter le gros fichier en cinq pour faciliter les analyses (pour gérer le probleme de time out).

# Compter le nombre total de séquences
total=$(grep -c '^>' all_seq.fasta)
# Calculer le nombre de séquences par fichier
perfile=$(( (total + 4) / 5 ))  # arrondi vers le haut pour répartir équitablement

awk -v perfile="$perfile" '
  /^>/ {
    if (seqnum % perfile == 0) {
      if (out) close(out)
      out = sprintf("split_%02d.fasta", ++file)
    }
    seqnum++
  }
  { print >> out }
' all_seq.fasta
