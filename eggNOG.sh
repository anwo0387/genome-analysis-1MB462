#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 25:00:00
#SBATCH --mem=128G
#SBATCH -J Njap_eggnog
#SBATCH -o logs/eggnog_%j.out
#SBATCH -e logs/eggnog_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

module load eggnog-mapper/2.1.13

set -euo pipefail

WORKDIR=/home/anwo0387/genome-analysis-1MB462
PROT=${WORKDIR}/braker3/Njaponicum/Augustus/augustus.hints.aa
OUTDIR=${WORKDIR}/eggnog/Njaponicum
EGGNOG_DB=/sw/data/uppnex/eggNOG/5.0/rackham

mkdir -p ${OUTDIR}

if [[ ! -f "$PROT" ]]; then
  echo "ERROR: Missing protein file: $PROT" >&2
  exit 1
fi

cp ${PROT} $SNIC_TMP/
cd $SNIC_TMP || exit 1

OUTPREFIX=Njaponicum

emapper.py \
  -i $(basename ${PROT}) \
  -o ${OUTPREFIX} \
  --output_dir ${OUTDIR} \
  --data_dir ${EGGNOG_DB} \
  --cpu ${SLURM_CPUS_PER_TASK} \
  --itype proteins \
  -m diamond \
  --tax_scope 33090 \
  --override \
  --pfam_realign realign \
  --report_orthologs \
  --go_evidence non-electronic \
  --scratch_dir $SNIC_TMP

