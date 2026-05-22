#!/bin/bash
#SBATCH -A uppmax2026-1-61		# Project
#SBATCH -M pelle			# Target Pelle cluster
#SBATCH -c 2				# Number of CPU cores
#SBATCH -t 00:30:00			# Walltime
#SBATCH --mem=8G			# memory specification
#SBATCH -J fastQC_pre_assembly-RNA	# Job name
#SBATCH -o logs/fastqc-RNA_%j.out	# Stdout log
#SBATCH -e logs/fastqc-RNA_%j.err	# Stderr log

# Load FastQC
module load FastQC/0.12.1-Java-17
module load MultiQC/1.28-foss-2024a

# Define paths
WORKDIR=/home/anwo0387/genome-analysis-1MB462
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data/
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
  $READS_DIR/*_f*.fq.gz

echo "Running MultiQC ..."
multiqc \
  $FASTQC_OUT \
  -o $MULTIQC_OUT

echo "QC completed successfully"
