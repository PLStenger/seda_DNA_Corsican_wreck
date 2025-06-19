#!/bin/bash

#SBATCH --job-name=02_trimmomatic
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_trimmomatic.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/02_trimmomatic.out"

# trimmomatic version 0.39
# trimmomatic manual : http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/01_raw_data
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_trimmomatic

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate trimmomatic

cd $WORKING_DIRECTORY

for R1 in *R1*
do
   R2=${R1//R1.fastq.gz/R2.fastq.gz}
   R1paired=${R1//.fastq.gz/_paired.fastq.gz}
   R1unpaired=${R1//.fastq.gz/_unpaired.fastq.gz}	
   R2paired=${R2//.fastq.gz/_paired.fastq.gz}
   R2unpaired=${R2//.fastq.gz/_unpaired.fastq.gz}	

   trimmomatic PE -Xmx60G -threads 8 -phred33 $R1 $R2 $OUTPUT/$R1paired $OUTPUT/$R1unpaired $OUTPUT/$R2paired $OUTPUT/$R2unpaired ILLUMINACLIP:"$ADAPTERFILE":2:30:10 LEADING:30 TRAILING:30 SLIDINGWINDOW:26:30 MINLEN:150
   
done ;


conda deactivate
