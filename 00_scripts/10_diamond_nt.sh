#!/bin/bash

#SBATCH --job-name=10_diamond_nt
##SBATCH --time=96:00:00       
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8     
#SBATCH -p smp
#SBATCH --mem=750G          
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_diamond_nt.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/10_diamond_nt.out"

INPUT=/home/plstenge/seda_DNA_Corsican_wreck/09_dedupe_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/11_diamond

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

#tmp=/home/plstenge

cd $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate diamond

# --tmpdir $tmp
# --memory-limit 50  

diamond  blastx -p 8 -d /storage/biodatabanks/ncbi/NT/current/diamond/NT.dmnd --out $OUTPUT/clean_1120_sed6_rep3_R1_paired.fastq.komplex0.55-duplicates.fa.blastx --query  clean_1120_sed6_rep3_R1_paired.fastq.komplex0.55-duplicates.fa  --outfmt 6   --max-target-seqs 25 --sensitive  --evalue 0.01  --index-chunks 1 --block-size 2 

