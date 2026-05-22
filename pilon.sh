#!/bin/bash -l
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80
#SBATCH -t 30:00:00                # Walltime (Pilon can be slow)
#SBATCH -A uppmax2026-1-61         # Project
#SBATCH --mem=16G                  # Memory
#SBATCH -c 2                       # CPU cores (as instructed)
#SBATCH -J pilon_chr3              # Job name
#SBATCH -o logs/pilon_%j.out       # Stdout
#SBATCH -e logs/pilon_%j.err       # Stderr

# -----------------------
# Load modules
# -----------------------

module load Pilon/1.24-Java-17
module load SAMtools/1.22-GCC-13.3.0

# -----------------------
# Paths and variables
# -----------------------

WORKDIR=/home/anwo0387/genome-analysis-1MB462

REF=${WORKDIR}/canu/canu_njaponicum_chr3.contigs.fasta
BAM=${WORKDIR}/bwa/chr3.sorted.bam

OUTDIR=${WORKDIR}/pilon
mkdir -p ${OUTDIR}
mkdir -p logs

PREFIX=chr3_pilon_round1

# -----------------------
# Sanity checks
# -----------------------

echo "Checking BAM index"
if [ ! -f "${BAM}.bai" ]; then
    samtools index ${BAM}
fi

# -----------------------
# Run Pilon
# -----------------------

echo "Running Pilon polishing"

cp ${REF} ${BAM} ${BAM}.bai $TMPDIR/
cd $TMPDIR

java -Xmx14G -jar $EBROOTPILON/pilon.jar \
    --genome $(basename ${REF}) \
    --frags $(basename ${BAM}) \
    --output ${PREFIX} \
    --outdir $TMPDIR \
    --threads ${SLURM_CPUS_PER_TASK} \
    --changes --vcf --fix all

cp $TMPDIR/*.fasta $TMPDIR/*.vcf $TMPDIR/*.changes ${OUTDIR}/

echo "Pilon polishing completed"

