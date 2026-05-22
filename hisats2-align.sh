#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4                           # Cores for HISAT2 threads
#SBATCH -t 24:00:00                    # Walltime
#SBATCH --mem=32G
#SBATCH -J hisat2_rna_chr3
#SBATCH -o logs/hisat2_align_%j.out
#SBATCH -e logs/hisat2_align_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

# Load modules

module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22-GCC-13.3.0

# Paths

WORKDIR=/home/anwo0387/genome-analysis-1MB462
HISAT2_INDEX=${WORKDIR}/hisat2/index_chr3/chr3
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data
OUTDIR=${WORKDIR}/hisat2/aligned

mkdir -p ${OUTDIR} logs

# HISAT2 alignment (paired-end, multiple samples)

hisat2 -p ${SLURM_CPUS_PER_TASK} \
  -x ${HISAT2_INDEX} \
  -1 ${READS_DIR}/Control_1_f1.fq.gz,${READS_DIR}/Control_2_f1.fq.gz,${READS_DIR}/Control_3_f1.fq.gz \
  -2 ${READS_DIR}/Control_1_r2.fq.gz,${READS_DIR}/Control_2_r2.fq.gz,${READS_DIR}/Control_3_r2.fq.gz \
  --dta \
  | samtools sort -@ ${SLURM_CPUS_PER_TASK} -o ${OUTDIR}/chr3_Aligned.sortedByCoord.out.bam

samtools index ${OUTDIR}/chr3_Aligned.sortedByCoord.out.bam

echo "HISAT2 RNA-seq alignment completed"
