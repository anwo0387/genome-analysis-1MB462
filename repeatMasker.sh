#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 8
#SBATCH -t 24:00:00
#SBATCH --mem=64G
#SBATCH -J Njap_rMasker
#SBATCH -o logs/Njap_rMasker_%j.out
#SBATCH -e logs/Njap_rMasker_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

module load RepeatMasker/4.2.1

WORKDIR=/home/anwo0387/genome-analysis-1MB462
RMDIR=${WORKDIR}/repeatmasking
ASM=${RMDIR}/assembly.min50000.fa
LIB=$(ls ${RMDIR}/*families.fa | head -n 1)

# Copy inputs to local scratch for faster I/O
cp ${ASM} ${LIB} $SNIC_TMP/
cd $SNIC_TMP

RepeatMasker \
  -lib $(basename ${LIB}) \
  -xsmall \
  -pa ${SLURM_CPUS_PER_TASK} \
  $(basename ${ASM})

mv assembly.min50000.fa.masked assembly.min50000.softmasked.fa

# Copy results back
cp -r $SNIC_TMP/* ${RMDIR}/
