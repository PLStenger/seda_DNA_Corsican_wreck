#!/bin/bash

#SBATCH --job-name=bbduk_after_Trimmomatic
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_bbduk_Trimmomatic.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/04_bbduk_Trimmomatic.out"

# "Duk" stands for Decontamination Using Kmers. BBDuk is extremely fast, scalable, and memory-efficient, while maintaining greater sensitivity and specificity than other tools. It can do lots of different things, for example -
# Adapter trimming:
# bbduk.sh -Xmx1g in=reads.fq out=clean.fq ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo
# or
# bbduk.sh -Xmx1g in1=read1.fq in2=read2.fq out1=clean1.fq out2=clean2.fq ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/03_cleaned_data_trimmomatic
OUTPUT=/home/plstenge/seda_DNA_Corsican_wreck/05_bbduk_after_trimmomatic

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate bbduk

cd $WORKING_DIRECTORY

#bbduk.sh -Xmx1g in=reads.fq out=clean.fq ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo

#ADAPTERS=/home/plstenge/seda_DNA_Corsican_wreck/99_softwares/illumina_Meyer_and_Phix.fa
PHIX=/home/plstenge/bbmap/resources/phix174_ill.ref.fa.gz
BBDUK=/home/plstenge/bbmap/bbduk.sh

#     ref=$ADAPTERS, $PHIX \


for R1 in *pair1.truncated*; do
  R2="${R1/pair1.truncated/pair2.truncated}"
  
  $BBDUK -Xmx4g \
    in1="$R1" \
    in2="$R2" \
    out1=$OUTPUT/"clean_${R1}" \
    out2=$OUTPUT/"clean_${R2}" \
    ref=$PHIX \
    ktrim=rl \
    k=23 \
    mink=11 \
    hdist=1 \
    tpe \
    tbo \
    minlen=50 \
    qtrim=r \
    trimq=20 \
    stats="${R1%.*}_stats.txt"
done


#bbduk.sh -Xmx1g in=1120_sed6_rep3_.pair1.truncated out=$OUTPUT/1120_sed6_rep3_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1121_sed8_rep1_.pair1.truncated out=$OUTPUT/1121_sed8_rep1_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1122_sed8_rep2_.pair1.truncated out=$OUTPUT/1122_sed8_rep2_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1129_sed6_rep1_.pair1.truncated out=$OUTPUT/1129_sed6_rep1_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1130_sed6_rep2_.pair1.truncated out=$OUTPUT/1130_sed6_rep2_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1131_sed8_rep3_.pair1.truncated out=$OUTPUT/1131_sed8_rep3_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo

#bbduk.sh -Xmx1g in=1120_sed6_rep3_.pair1.truncated out=$OUTPUT/1120_sed6_rep3_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1121_sed8_rep1_.pair1.truncated out=$OUTPUT/1121_sed8_rep1_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1122_sed8_rep2_.pair1.truncated out=$OUTPUT/1122_sed8_rep2_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1129_sed6_rep1_.pair1.truncated out=$OUTPUT/1129_sed6_rep1_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1130_sed6_rep2_.pair1.truncated out=$OUTPUT/1130_sed6_rep2_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=1131_sed8_rep3_.pair1.truncated out=$OUTPUT/1131_sed8_rep3_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo

#bbduk.sh -Xmx1g in=NTC_sed_.pair1.truncated out=$OUTPUT/NTC_sed_.pair1.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo
#bbduk.sh -Xmx1g in=NTC_sed_.pair2.truncated out=$OUTPUT/NTC_sed_.pair2.cleaned ref=$ADAPTERS ktrim=r k=23 mink=11 hdist=1 tpe tbo


