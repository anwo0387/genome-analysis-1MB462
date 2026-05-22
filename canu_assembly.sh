#!/bin/bash
#SBATCH -A uppmax2026-1-61         # Project
#SBATCH -M pelle
#SBATCH -n 2                      # Number of CPU cores
#SBATCH -t 24:00:00                # Walltime (adjust as needed)
#SBATCH --mem=52G
#SBATCH -J canu_assembly           # Job name
#SBATCH -o logs/canu_%j.out        # Stdout log
#SBATCH -e logs/canu_%j.err        # Stderr log

# Load modules
module load canu
module load SAMtools/1.22.1-GCC-13.3.0         

# Define paths
WORKDIR=/home/anwo0387/genome-analysis-1MB462
READS=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_clean_nanopore.fq.gz
OUTDIR=$WORKDIR/canu

# Move to working directory
cd $WORKDIR

# Run Canu
canu \
  -p canu_njaponicum_chr3 \
  -d $OUTDIR \
  genomeSize=16m \
  -nanopore $READS \
  -gridOptions="-A uppmax2026-1-61 -M pelle -t 24:00:00"
  maxThreads=2
  corThreads=2
  oeaThreads=2
  cnsThreads=2

