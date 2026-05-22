#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 8
#SBATCH -t 72:00:00
#SBATCH --mem=96G
#SBATCH -J Njap_braker3
#SBATCH -o logs/braker_%j.out
#SBATCH -e logs/braker_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

WORKDIR=/home/anwo0387/genome-analysis-1MB462

GENOME=${WORKDIR}/repeatmasking/assembly.min50000.softmasked.fa
BAM=${WORKDIR}/hisat2/aligned/chr3_Aligned.sortedByCoord.out.bam
PROT=${WORKDIR}/proteins/p_patens-ref_proteins.fasta
OUTDIR=${WORKDIR}/braker3/Njaponicum

export AUGUSTUS_CONFIG_PATH=/home/anwo0387/genome-analysis-1MB462/bin/augustus_config

mkdir -p ${OUTDIR}

for f in ${GENOME} ${BAM} ${PROT}; do
  if [[ ! -f "$f" ]]; then
    echo "ERROR: Missing input file: $f" >&2
    exit 1
  fi
done

cp ${GENOME} ${BAM} ${PROT} $SNIC_TMP/

singularity exec \
  --bind ${WORKDIR}:${WORKDIR} \
  --bind /home/anwo0387:/home/anwo0387 \
  --bind $SNIC_TMP:$SNIC_TMP \
  --bind /home/anwo0387/genome-analysis-1MB462/bin/augustus_config:/opt/Augustus/config \
  /crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif \
  braker.pl \
    --genome=$SNIC_TMP/$(basename ${GENOME}) \
    --bam=$SNIC_TMP/$(basename ${BAM}) \
    --prot_seq=$SNIC_TMP/$(basename ${PROT}) \
    --softmasking \
    --species=Niphotrichum_japonicum \
    --threads=${SLURM_CPUS_PER_TASK} \
    --workingdir=${OUTDIR}
