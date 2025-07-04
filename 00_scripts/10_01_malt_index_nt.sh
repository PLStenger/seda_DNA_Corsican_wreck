#!/bin/bash

#SBATCH --job-name=10_01_malt_index_nt
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=350G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index_nt.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index_nt.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate malt

#Build MALT-index
malt-build -i /storage/biodatabanks/ncbi/NT/current/fasta/All/all.fasta --sequenceType DNA --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt --acc2taxa /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/nt/acc2taxa.map --threads 16 --verbose
