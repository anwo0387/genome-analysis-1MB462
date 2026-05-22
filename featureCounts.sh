#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH --reservation uppmax2026-1-61_10
#SBATCH -c 8
#SBATCH -t 02:00:00
#SBATCH --mem=32G
#SBATCH -J featurecounts_Njap
#SBATCH -o logs/featurecounts_%j.out
#SBATCH -e logs/featurecounts_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

# -----------------------
# Load module
# -----------------------

module load Subread

# -----------------------
# Paths
# -----------------------

WORKDIR=/home/anwo0387/genome-analysis-1MB462
BAMDIR=${WORKDIR}/hisat2/aligned
GTF=${WORKDIR}/braker3/Njaponicum/braker.gtf
OUTDIR=${WORKDIR}/counts

mkdir -p ${OUTDIR}

# -----------------------
# Sanity checks
# -----------------------

echo "Checking inputs..."

NBAM=$(ls ${BAMDIR}/*.sorted.bam 2>/dev/null | wc -l)

if [[ "$NBAM" -eq 0 ]]; then
    echo "ERROR: No BAM files found in ${BAMDIR}" >&2
    exit 1
fi

echo "Found ${NBAM} BAM files"

if [[ ! -f "$GTF" ]]; then
    echo "ERROR: GTF file not found: $GTF" >&2
    exit 1
fi

# -----------------------
# Run featureCounts
# -----------------------

echo "Running featureCounts..."

featureCounts \
  -T ${SLURM_CPUS_PER_TASK} \
  -p -B -C \
  -a ${GTF} \
  -o ${OUTDIR}/counts.txt \
  -t exon \
  -g gene_id \
  ${BAMDIR}/*.sorted.bam

echo "featureCounts finished ✅"
