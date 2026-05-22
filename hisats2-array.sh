#!/bin/bash -l
#SBATCH --reservation uppmax2026-1-61_10
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 24:00:00
#SBATCH --mem=32G
#SBATCH -J hisat2_array
#SBATCH -o logs/hisat2-array_%A_%a.out
#SBATCH -e logs/hisat2-array_%A_%a.err
#SBATCH --array=0-5
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22-GCC-13.3.0

set -euo pipefail   # ✅ crash early if something is wrong

WORKDIR=/home/anwo0387/genome-analysis-1MB462
READS_DIR=/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data
HISAT2_INDEX=${WORKDIR}/hisat2/index_chr3/chr3
OUTDIR=${WORKDIR}/hisat2/aligned

SAMPLE_LIST=${WORKDIR}/hisats2-samples_f1.txt

mkdir -p ${OUTDIR}

# ✅ Get R1
R1=$(sed -n "$((SLURM_ARRAY_TASK_ID+1))p" ${SAMPLE_LIST})

if [[ -z "$R1" ]]; then
    echo "ERROR: No R1 file found for task ${SLURM_ARRAY_TASK_ID}" >&2
    exit 1
fi

# ✅ Extract sample name
SAMPLE=$(basename ${R1} | sed 's/_f1.*//')

# ✅ Define R2
R2=${READS_DIR}/${SAMPLE}_r2.fq.gz

echo "-----------------------------------"
echo "TASK ID: ${SLURM_ARRAY_TASK_ID}"
echo "SAMPLE: $SAMPLE"
echo "R1: $R1"
echo "R2: $R2"
echo "-----------------------------------"

# ✅ Checks
if [[ ! -f "$R1" ]]; then
    echo "ERROR: Missing R1 file: $R1" >&2
    exit 1
fi

if [[ ! -f "$R2" ]]; then
    echo "ERROR: Missing R2 file: $R2" >&2
    exit 1
fi

# ✅ Run alignment
hisat2 -p ${SLURM_CPUS_PER_TASK} \
  -x ${HISAT2_INDEX} \
  -1 ${R1} \
  -2 ${R2} \
  --dta \
| samtools sort -@ ${SLURM_CPUS_PER_TASK} \
  -o ${OUTDIR}/${SAMPLE}.sorted.bam

# ✅ Index BAM
samtools index ${OUTDIR}/${SAMPLE}.sorted.bam

echo "✅ Finished sample: $SAMPLE"
