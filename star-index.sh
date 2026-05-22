#!/bin/bash -l
#SBATCH -A uppmax2026-1-61                         # Project
#SBATCH -c 4
#SBATCH -t 02:00:00                                # Walltime
#SBATCH --mem=32G                                  # Memory
#SBATCH -J star_index_chr3                         # Job name
#SBATCH -o logs/star_index_%j.out                  # Std out file
#SBATCH -e logs/star_index_%j.err                  # Std error file
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80   # Get email update

# -----------------------
# Load modules
# -----------------------
module load STAR/2.7.11b-GCC-13.3.0

# -----------------------
# Paths
# -----------------------
WORKDIR=/home/anwo0387/genome-analysis-1MB462
GENOME=${WORKDIR}/pilon/chr3_pilon_round1.fasta
STAR_INDEX=${WORKDIR}/star/index_chr3

mkdir -p ${STAR_INDEX}

# -----------------------
# Build STAR genome index
# -----------------------
STAR \
  --runThreadN ${SLURM_CPUS_PER_TASK} \
  --runMode genomeGenerate \
  --genomeDir ${STAR_INDEX} \
  --genomeFastaFiles ${GENOME} \
  --genomeSAindexNbases 11

echo "STAR genome index completed"
