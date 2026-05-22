#!/bin/bash
#SBATCH -A uppmax2026-1-61                  # Project
#SBATCH -M pelle
#SBATCH -c 4                                # Number of CPU cores (use -c on Pelle)
#SBATCH -t 01:00:00                         # Walltime
#SBATCH --mem=8G
#SBATCH -J trimmomatic                      # Job name
#SBATCH -o logs/trimmomatic_%j.out          # Stdout log
#SBATCH -e logs/trimmomatic_%j.err          # Stderr log
#SBATCH --mail-type=END,FAIL,TIME_LIMIT_80
#SBATCH --mail-user=anna.woszczyk.0387@student.uu.se

# Load Trimmomatic module
module load Trimmomatic/0.39-Java-17

# Define paths
WORKDIR=/home/anwo0387/genome-analysis-1MB462
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data
TRIM_OUT=$WORKDIR/trimmed

# Create output directory
mkdir -p $TRIM_OUT

# Run Trimmomatic (paired-end)
echo "Running Trimmomatic ..."
trimmomatic PE \
  -threads 4 \
  $READS_DIR/chr3_illumina_R1.fastq.gz \
  $READS_DIR/chr3_illumina_R2.fastq.gz \
  $TRIM_OUT/R1_paired.fastq.gz \
  $TRIM_OUT/R1_unpaired.fastq.gz \
  $TRIM_OUT/R2_paired.fastq.gz \
  $TRIM_OUT/R2_unpaired.fastq.gz \
  ILLUMINACLIP:/sw/generic/pixi-envs/shovill-1.4.2/.pixi/envs/default/share/trimmomatic-0.40-0/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

echo "Trimmomatic completed"
