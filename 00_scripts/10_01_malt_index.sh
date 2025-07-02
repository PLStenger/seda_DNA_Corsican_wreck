#!/bin/bash

#SBATCH --job-name=10_01_malt_index
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_01_malt_index.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_malt

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate malt

#Build MALT-index
#malt-build -i /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz --sequenceType DNA --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138_2_SSURef_NR99 --threads 16 --verbose
#malt-build -i /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz --sequenceType DNA --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138_2_SSURef_NR99   --taxonomy /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/ncbi_taxdump/ --acc2taxa /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138_2_SSURef_NR99/acc2taxa.map --threads 16 --verbose
malt-build -i /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138.2_SSURef_NR99_tax_silva.fasta.gz --sequenceType DNA --index /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138_2_SSURef_NR99 --acc2taxa /home/plstenge/seda_DNA_Corsican_wreck/99_softwares/SILVA_138_2_SSURef_NR99/acc2taxa.map --threads 16 --verbose
