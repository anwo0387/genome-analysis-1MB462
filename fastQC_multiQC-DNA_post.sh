#!/bin/bash
#SBATCH -A uppmax2026-1-61		# Project
#SBATCH -M pelle			# Target Pelle cluster
#SBATCH -c 2				# Number of CPU cores
#SBATCH -t 00:10:00			# Walltime
#SBATCH --mem=8G			# memory specification
#SBATCH -J fastQC_post_T		# Job name
#SBATCH -o logs/fastqc-post_%j.out		# Stdout log
#SBATCH -e logs/fastqc-post_%j.err		# Stderr log

# Load FastQC
module load FastQC/0.12.1-Java-17
module load MultiQC/1.28-foss-2024a

# Define paths
WORKDIR=/home/anwo0387/genome-analysis-1MB462
READS_DIR=$WORKDIR/trimmed
FASTQC_OUT=$WORKDIR/fastqc
MULTIQC_OUT=$WORKDIR/multiqc

# Move to working directory
cd $WORKDIR

# Create Output directories
mkdir -p $FASTQC_OUT
mkdir -p $MULTIQC_OUT

# Run FastQC & MultiQC
echo "Running FastQC ..."
fastqc \
  --threads 2 \
  --outdir $FASTQC_OUT \
  $READS_DIR/*.fastq.gz

echo "Running MultiQC ..."
multiqc \
  $FASTQC_OUT \
  -o $MULTIQC_OUT

echo "QC completed successfully"
