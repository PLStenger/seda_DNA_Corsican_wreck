#!/bin/bash

#SBATCH --job-name=00_trimmomatic_whole_pipeline
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_trimmomatic_whole_pipeline.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_trimmomatic_whole_pipeline.out"

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/00_scripts

cd $WORKING_DIRECTORY

# 02_trimmomatic_q30.sh
#   └─> 03_quality_check_by_FastQC_trimmomatic.sh
#   └─> 04_Komplexity_trimmomatic.sh
#         ├─> 05_quality_check_after_komplexity_trimmomatic.sh
#         └─> 06_dedupe_trimmomatic.sh
#               ├─> 07_quality_check_after_dedup_trimmomatic.sh
#               └─> 08_bbduk_after_Trimmomatic.sh
#                     └─> 09_quality_check_after_bbduk_trimmomatic.sh

# 1. Trimmomatic
jid1=$(sbatch 02_trimmomatic_q30.sh | awk '{print $4}')

# 2. FastQC after Trimmomatic
jid2=$(sbatch --dependency=afterok:$jid1 03_quality_check_by_FastQC_trimmomatic.sh | awk '{print $4}')

# 3. Komplexity (depends on Trimmomatic)
jid3=$(sbatch --dependency=afterok:$jid1 04_Komplexity_trimmomatic.sh | awk '{print $4}')

# 4. FastQC after Komplexity
jid4=$(sbatch --dependency=afterok:$jid3 05_quality_check_after_komplexity_trimmomatic.sh | awk '{print $4}')

# 5. Dedupe (depends on Komplexity)
jid5=$(sbatch --dependency=afterok:$jid3 06_dedupe_trimmomatic.sh | awk '{print $4}')

# 6. FastQC after Dedupe
jid6=$(sbatch --dependency=afterok:$jid5 07_quality_check_after_dedup_trimmomatic.sh | awk '{print $4}')

# 7. BBDuk (depends on Dedupe)
jid7=$(sbatch --dependency=afterok:$jid5 08_bbduk_after_Trimmomatic.sh | awk '{print $4}')

# 8. FastQC after BBDuk
jid8=$(sbatch --dependency=afterok:$jid7 09_quality_check_after_bbduk_trimmomatic.sh | awk '{print $4}')
