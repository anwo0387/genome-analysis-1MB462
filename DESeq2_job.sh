#I did not run this job...

#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 04:00:00
#SBATCH --mem=32G
#SBATCH -J DESeq2_chr3
#SBATCH -o logs/deseq2_%j.out
#SBATCH -e logs/deseq2_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

module load R

WORKDIR=/home/anwo0387/genome-analysis-1MB462
cd ${WORKDIR}

echo "Starting DESeq2 analysis..."
Rscript DESeq2.R
echo "DESeq2 job finished."
