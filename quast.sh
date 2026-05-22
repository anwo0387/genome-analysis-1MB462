#!/bin/bash -l
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80
#SBATCH -A uppmax2026-1-61         # Project
#SBATCH -c 2                       # QUAST does not scale much
#SBATCH -t 01:00:00                # Walltime
#SBATCH --mem=8G                   # Memory
#SBATCH -J quast_chr3              # Job name
#SBATCH -o logs/quast_%j.out       # Stdout
#SBATCH -e logs/quast_%j.err       # Stderr

# -----------------------
# Load modules
# -----------------------

module load QUAST/5.3.0-gfbf-2024a

# -----------------------
# Paths and variables
# -----------------------

WORKDIR=/home/anwo0387/genome-analysis-1MB462

CANU=${WORKDIR}/canu/canu_njaponicum_chr3.contigs.fasta
PILON=${WORKDIR}/pilon/chr3_pilon_round1.fasta

OUTDIR=${WORKDIR}/quast
mkdir -p ${OUTDIR}
mkdir -p logs

# -----------------------
# Run QUAST
# -----------------------

echo "Running QUAST evaluation"

cp ${CANU} ${PILON} $TMPDIR/
cd $TMPDIR

quast.py \
    $(basename ${CANU}) \
    $(basename ${PILON}) \
    -o $TMPDIR/quast_out \
    --threads ${SLURM_CPUS_PER_TASK} \
    --labels Canu,Pilon_round1

cp -r $TMPDIR/quast_out/* ${OUTDIR}/

echo "QUAST evaluation completed"
