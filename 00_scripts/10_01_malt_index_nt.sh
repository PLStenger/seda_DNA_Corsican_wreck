#!/bin/bash

#SBATCH --job-name=10_01_malt_index_nt
##SBATCH --time=96:00:00       
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8     
#SBATCH -p smp
#SBATCH --mem=1000G          
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index_nt.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index_nt.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $OUTPUT

############################################################################################################
## Ok avec nT soit outofmemory soit time donc on va switcher avec Diamond moins gourmand
############################################################################################################

module load conda/4.12.0
source ~/.bashrc
conda activate malt

# Pour augmenter la memoire de l'outil (bridée à 64Go):
# cd /home/plstenge/miniconda3/envs/malt
# find . -name "*.vmoptions"
# Modifier le XmX

export JAVA_TOOL_OPTIONS="-Xmx1000G"

#Build MALT-index
malt-build -i /storage/biodatabanks/ncbi/NT/current/fasta/All/all.fasta --sequenceType DNA --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt --acc2taxa /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt/acc2taxa.map --threads 8 --verbose
