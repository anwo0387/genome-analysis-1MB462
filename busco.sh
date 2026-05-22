#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 12:00:00
#SBATCH --mem=32G
#SBATCH -J busco_Njaponicum_chr3
#SBATCH -o logs/busco_%j.out
#SBATCH -e logs/busco_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

# --------------------
# MODULES
# --------------------
module load BUSCO/5.8.2

# --------------------
# Paths
# --------------------
WORKDIR=/home/anwo0387/genome-analysis-1MB462
PROTEINS=${WORKDIR}/braker3/Njaponicum/Augustus/augustus.hints.aa
OUTDIR=${WORKDIR}/busco/braker3_chr3
LINEAGE=embryophyta_odb10

# --------------------
# Run BUSCO
# --------------------
cp ${PROTEINS} $SNIC_TMP/

busco \
    -i $SNIC_TMP/$(basename ${PROTEINS}) \
    -l ${LINEAGE} \
    -o busco_braker3_chr3 \
    -m protein \
    -c ${SLURM_CPUS_PER_TASK} \
    --out_path ${OUTDIR}

echo "BUSCO analysis completed"
