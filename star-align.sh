#!/bin/bash -l
#SBATCH -A uppmax2026-1-61                         # Project
#SBATCH -c 8
#SBATCH -t 30:00:00                                # Walltime
#SBATCH --mem=32G                                  # Memory
#SBATCH -J star_rna_chr3                           # Job name
#SBATCH -o logs/star_align_%j.out                  # Std out file
#SBATCH -e logs/star_align_%j.err                  # Std error file
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80   # Get email update

# -----------------------
# Load modules
# -----------------------

module load STAR/2.7.11b-GCC-13.3.0
module load SAMtools/1.22-GCC-13.3.0

# -----------------------
# Paths
# -----------------------
WORKDIR=/home/anwo0387/genome-analysis-1MB462

STAR_INDEX=${WORKDIR}/star/index_chr3
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data

R1_1=${READS_DIR}/Control_1_f1.fq.gz
R2_1=${READS_DIR}/Control_1_r2.fq.gz
R1_2=${READS_DIR}/Control_2_f1.fq.gz
R2_2=${READS_DIR}/Control_2_r2.fq.gz
R1_3=${READS_DIR}/Control_3_f1.fq.gz
R2_3=${READS_DIR}/Control_3_r2.fq.gz


OUTDIR=${WORKDIR}/star/aligned
mkdir -p ${OUTDIR}
mkdir -p logs

# -----------------------
# STAR alignment
# -----------------------

STAR \
  --runThreadN ${SLURM_CPUS_PER_TASK} \
  --genomeDir ${STAR_INDEX} \
  --readFilesIn ${R1_1},${R1_2},${R1_3} ${R2_1},${R2_2},${R2_3} \
  --readFilesCommand zcat \
  --outFileNamePrefix ${OUTDIR}/chr3_ \
  --outSAMtype BAM SortedByCoordinate \
  --outSAMattributes All \
  --twopassMode Basic

# -----------------------
# Index BAM
# -----------------------

samtools index ${OUTDIR}/chr3_Aligned.sortedByCoord.out.bam

echo "STAR RNA-seq alignment completed"
