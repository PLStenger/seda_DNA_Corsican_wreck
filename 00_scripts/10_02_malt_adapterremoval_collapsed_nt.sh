#!/bin/bash

#SBATCH --job-name=10_02_malt_adapterremoval_collapsed_nt
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_02_malt_adapterremoval_collapsed_nt.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_02_malt_adapterremoval_collapsed_nt.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval_collapsed
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt_Adapteremoval_collapsed_nt
ALIGNMENT_OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt_Adapteremoval_collapsed_alignmennt

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT
mkdir -p $ALIGNMENT_OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate malt

cd $INPUT

#Run MALT
malt-run -i *-dedupe.gz --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt --mode BlastN --alignmentType SemiGlobal -t 8 --verbose --output $OUTPUT --alignments $ALIGNMENT_OUTPUT --format Text
