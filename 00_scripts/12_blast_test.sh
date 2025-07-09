#!/bin/bash

#SBATCH --job-name=12_blast_test
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/12_blast_test.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/12_blast_test.out"

OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/12_blast_test

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

cd $OUTPUT

###################################################
# 09_dedupe_Adapteremoval
###################################################

blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval/clean_1129_sed6_rep1_demux.pair2.truncated.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_Adapteremoval_clean_1129_sed6_rep1_demux.pair2.truncated.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_Adapteremoval_clean_1129_sed6_rep1_demux.pair2.truncated.komplex0.55-duplicates.fa fini"

  blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval/clean_1121_sed8_rep1_demux.pair1.truncated.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_Adapteremoval_clean_1121_sed8_rep1_demux.pair1.truncated.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_Adapteremoval_clean_1121_sed8_rep1_demux.pair1.truncated.komplex0.55-duplicates.fa fini"


###################################################
# 09_dedupe_Adapteremoval_collapsed
###################################################

  blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval_collapsed/clean_1129_sed6_rep1_demux.collapsed.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_Adapteremoval_collapsed_clean_1129_sed6_rep1_demux.collapsed.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_Adapteremoval_collapsed_clean_1129_sed6_rep1_demux.collapsed.komplex0.55-duplicates.fa fini"


  blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_Adapteremoval_collapsed/clean_1121_sed8_rep1_demux.collapsed.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_Adapteremoval_collapsed_clean_1121_sed8_rep1_demux.collapsed.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_Adapteremoval_collapsed_clean_1121_sed8_rep1_demux.collapsed.komplex0.55-duplicates.fa fini"


###################################################
# 09_dedupe_trimmomatic
###################################################

  blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic/clean_1129_sed6_rep1_R2_paired.fastq.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_trimmomatic_clean_1129_sed6_rep1_R2_paired.fastq.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_trimmomatic_clean_1129_sed6_rep1_R2_paired.fastq.komplex0.55-duplicates.faa fini"


  blastn \
  -query /home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic/clean_1121_sed8_rep1_R1_paired.fastq.komplex0.55-duplicates.fa \
  -db /storage/biodatabanks/ncbi/NT/current/flat/nt \
  -out results_blastn_09_dedupe_trimmomatic_collapsed_clean_1121_sed8_rep1_R1_paired.fastq.komplex0.55-duplicates.fa.tsv \
  -outfmt 6 \
  -max_target_seqs 10 \
  -num_threads 4

  echo "09_dedupe_trimmomatic_clean_1121_sed8_rep1_R1_paired.fastq.komplex0.55-duplicates.fa fini"



  
