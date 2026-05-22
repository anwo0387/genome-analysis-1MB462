#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 2
#SBATCH -t 05:00:00
#SBATCH --mem=32G
#SBATCH -J hisat2_index_chr3
#SBATCH -o logs/hisat2_index_%j.out
#SBATCH -e logs/hisat2_index_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

# -----------------------
# Load modules
# -----------------------

module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22-GCC-13.3.0

# -----------------------
# Paths
# -----------------------

WORKDIR=/home/anwo0387/genome-analysis-1MB462
GENOME=${WORKDIR}/pilon/chr3_pilon_round1.fasta
HISAT2_INDEX=${WORKDIR}/hisat2/index_chr3

mkdir -p ${HISAT2_INDEX}

# -----------------------
# Build HISAT2 index
# -----------------------

hisat2-build \
  -p ${SLURM_CPUS_PER_TASK} \
  ${GENOME} \
  ${HISAT2_INDEX}/chr3

echo "HISAT2 genome index completed successfully"
