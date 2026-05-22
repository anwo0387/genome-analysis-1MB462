#!/bin/bash -l
#SBATCH --reservation uppmax2026-1-61_7
#SBATCH -A uppmax2026-1-61
#SBATCH -c 16                          # Cores for HISAT2 threads
#SBATCH -t 48:00:00                    # Walltime
#SBATCH --mem=64G
#SBATCH -J Njap_rModeler
#SBATCH -o logs/NjapRModeler_%j.out
#SBATCH -e logs/NjapRModeler_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL,TIME_LIMIT_80

# Load modules

module load RepeatModeler/2.0.7

# Paths

WORKDIR=/home/anwo0387/genome-analysis-1MB462
IN_ASM=${WORKDIR}/pilon/chr3_pilon_round1.fasta
OUTDIR=${WORKDIR}/repeatmasking
MINLEN=50000

mkdir -p ${OUTDIR}
cd ${OUTDIR}

cp ${IN_ASM} $SNIC_TMP/assembly.fa
cd $SNIC_TMP

# 1) Filter contigs to avoid GeneMark crashes
python3 <<EOF
minlen=${MINLEN}
infile = "assembly.fa"   # local copy in $SNIC_TMP
with open(infile) as fi, open("assembly.min${MINLEN}.fa","w") as fo:
    h=None; s=[]
    def flush():
        if h and len("".join(s)) >= minlen:
            fo.write(h)
            seq="".join(s)
            for i in range(0,len(seq),60):
                fo.write(seq[i:i+60]+"\n")
    for l in fi:
        if l.startswith(">"):
            flush(); h=l; s=[]
        else:
            s.append(l.strip())
    flush()
EOF

# 2) Build RepeatModeler database & library
BuildDatabase -name Njap_db assembly.min${MINLEN}.fa
RepeatModeler -database Njap_db -threads ${SLURM_CPUS_PER_TASK}

# 3) Copy results back
cp -r $SNIC_TMP/* ${OUTDIR}/
