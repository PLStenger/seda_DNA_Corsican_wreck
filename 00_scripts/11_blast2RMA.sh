#!/bin/bash

#SBATCH --job-name=11_blast2RMA
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/11_blast2RMA.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/11_blast2RMA.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/12_blast2RMA

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate megan

cd $INPUT

#blast2RMA (requires lots of memory)
#input=./
ms=50
me=0.01
supp=0
mpi=95

for i in $INPUT/*-dedupe.gz; do b=${i/.gz-dedupe.gz/.blastn.gz}; blast2rma -r $i -i $b -o $input -v -ms $ms -me $me -f BlastText -supp $supp -mpi $mpi -alg weighted -lcp 80; done | parallel -j 8 --delay 6

#run blast2RMA
nohup ./run-blast2rma.sh &
