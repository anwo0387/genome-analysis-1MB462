#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH --reservation uppmax2026-1-61_11
#SBATCH -c 8
#SBATCH -t 02:00:00
#SBATCH --mem=32G
#SBATCH -J featurecounts_TE
#SBATCH -o logs/featurecounts_TE_%j.out
#SBATCH -e logs/featurecounts_TE_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

module load Subread

WORKDIR=/home/anwo0387/genome-analysis-1MB462
BAMDIR=${WORKDIR}/hisat2/aligned
GTF=${WORKDIR}/TE_RMasker/chr3/chr3_TE_family.gtf
OUTDIR=${WORKDIR}/counts_TE

mkdir -p ${OUTDIR}

echo "Running featureCounts for TEs..."

featureCounts \
  -T ${SLURM_CPUS_PER_TASK} \
  -M --fraction \
  -a ${GTF} \
  -o ${OUTDIR}/counts_TE.txt \
  -t dispersed_repeat \
  -g gene_id \
  ${BAMDIR}/*.sorted.bam

echo "✅ TE featureCounts finished"
