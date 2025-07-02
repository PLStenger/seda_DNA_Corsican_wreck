#!/bin/bash

#SBATCH --job-name=00_blast
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/00_blast.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/00_blast.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/test.fasta 

cd $INPUT

blastn \
  -query test.fasta \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4
