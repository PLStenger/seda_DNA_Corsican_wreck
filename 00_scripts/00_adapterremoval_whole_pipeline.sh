#!/bin/bash

#SBATCH --job-name=00_adapterremoval_whole_pipeline
##SBATCH --time=24:00
#SBATCH --ntasks=1
#SBATCH -p smp
##SBATCH --nodelist=gdecnode02
#SBATCH --mem=250G
##SBATCH -c 32
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_adapterremoval_whole_pipeline.err"
#SBATCH --output="/home/plstenge/seda_DNA_Corsican_wreck/00_scripts/00_adapterremoval_whole_pipeline.out"

WORKING_DIRECTORY=/home/plstenge/seda_DNA_Corsican_wreck/00_scripts

cd $WORKING_DIRECTORY

# 1. AdapterRemoval
jid1=$(sbatch 02_adapterremoval.sh | awk '{print $4}')

# 2. FastQC after AdapterRemoval (independent)
jid2=$(sbatch --dependency=afterok:$jid1 03_quality_check_by_FastQC_adapteremoval.sh | awk '{print $4}')

# 3. Komplexity (depends on AdapterRemoval)
jid3=$(sbatch --dependency=afterok:$jid1 04_Komplexity_adapterremoval.sh | awk '{print $4}')

# 4. FastQC after Komplexity (depends on Komplexity)
jid4=$(sbatch --dependency=afterok:$jid3 05_quality_check_after_komplexity_adpaterremoval.sh | awk '{print $4}')

# 5. Dedupe (depends on Komplexity)
jid5=$(sbatch --dependency=afterok:$jid3 06_dedupe_adapterremoval.sh | awk '{print $4}')

# 6. FastQC after Dedupe (depends on Dedupe)
jid6=$(sbatch --dependency=afterok:$jid5 07_quality_check_after_dedup_adapterremoval.sh | awk '{print $4}')

# 7. BBDuk (depends on Dedupe)
jid7=$(sbatch --dependency=afterok:$jid5 08_bbduk_after_Adapteremoval.sh | awk '{print $4}')

# 8. FastQC after BBDuk (depends on BBDuk)
jid8=$(sbatch --dependency=afterok:$jid7 09_quality_check_after_bbduk_adapterremoval.sh | awk '{print $4}')
