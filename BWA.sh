#!/bin/bash -l
#SBATCH -A uppmax2026-1-61          # Project
#SBATCH -c 4                       # CPU cores (BWA benefits from threads)
#SBATCH -t 03:00:00                # Walltime
#SBATCH --mem=16G                  # Memory
#SBATCH -J bwa_mapping_chr3        # Job name
#SBATCH -o logs/bwa_%j.out         # Stdout
#SBATCH -e logs/bwa_%j.err         # Stderr

# Load modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# -----------------------
# Paths and variables
# -----------------------

WORKDIR=/home/anwo0387/genome-analysis-1MB462

# Assembly (Nanopore, Canu)
REF=${WORKDIR}/canu/canu_njaponicum_chr3.contigs.fasta

# Choose reads: UNTRIMMED or TRIMMED
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/
#READS_DIR=${WORKDIR}/trimmed/

R1=${READS_DIR}/chr3_illumina_R1.fastq.gz
R2=${READS_DIR}/chr3_illumina_R2.fastq.gz

OUTDIR=${WORKDIR}/bwa
mkdir -p ${OUTDIR}
mkdir -p logs

# -----------------------
# Index reference (only if needed)
# -----------------------

if [ ! -f "${REF}.bwt" ]; then
    echo "Indexing reference with bwa"
    bwa index ${REF}
fi

# -----------------------
# Mapping with BWA-MEM
# -----------------------

echo "Running BWA-MEM"
bwa mem -t ${SLURM_CPUS_PER_TASK} ${REF} ${R1} ${R2} \
    | samtools view -b \
    | samtools sort -@ ${SLURM_CPUS_PER_TASK} -o ${OUTDIR}/chr3.sorted.bam

# -----------------------
# Index BAM
# -----------------------

samtools index ${OUTDIR}/chr3.sorted.bam

echo "BWA mapping completed"
