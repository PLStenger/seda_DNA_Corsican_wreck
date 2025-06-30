#!/bin/bash

#SBATCH --job-name=04_bbduk_after_Adapteremoval_collapsed
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_bbduk_after_Adapteremoval_collapsed.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_bbduk_after_Adapteremoval_collapsed.out"

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_adapterremoval 
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/05_bbduk_after_Adapteremoval_collapsed

mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate bbduk

cd $WORKING_DIRECTORY

# Chemin vers Phix
PHIX=/home/plstenge/bbmap/resources/phix174_ill.ref.fa.gz
BBDUK=/home/plstenge/bbmap/bbduk.sh

# Boucle sur les fichiers collapsed.gz
for FILE in *.collapsed.gz; do
  # Nom du fichier de sortie nettoyé
  OUTFILE=$OUTPUT/"clean_${FILE}"

  $BBDUK -Xmx4g \
    in="$FILE" \
    out="$OUTFILE" \
    ref="$PHIX" \
    ktrim=rl \
    k=23 \
    mink=11 \
    hdist=1 \
    tpe \
    tbo \
    minlen=25 \
    qtrim=r \
    trimq=20 \
    stats="${FILE%.collapsed.gz}_stats.txt"
done
