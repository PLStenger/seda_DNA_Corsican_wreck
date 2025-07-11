#!/bin/bash

#SBATCH --job-name=split_05
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p long
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/split_05.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol/split_05.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/99_test_Carol 

cd $INPUT

blastn \
  -query split_05.fasta \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_split_05.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4
