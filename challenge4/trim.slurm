#!/bin/bash

#SBATCH --job-name trimming_CMP
#SBATCH -A evoanalysis
#SBATCH -t 0-01:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=cporte26@uwyo.edu
#SBATCH -e /project/evoanalysis/cporte26/evoanalysis-2026/challenge4/logs/trim_%A_%a.err
#SBATCH -o /project/evoanalysis/cporte26/evoanalysis-2026/challenge4/logs/trim_%A_%a.out 
#SBATCH --array=1-38
#SBATCH --chdir=/project/evoanalysis/cporte26/evoanalysis-2026/challenge4

module load fastp/0.23.4

## define directories for raw data, outputs, and reports
RAW_DIR="/project/evoanalysis/d3challenge_fq"
OUTDIR="/project/evoanalysis/cporte26/evoanalysis-2026/challenge4/trim_out"
REPORTDIR="/project/evoanalysis/cporte26/evoanalysis-2026/challenge4/trim_out/fastp_reports"

## create directories if nonexistent
mkdir -p $OUTDIR
mkdir -p $REPORTDIR

## create list from raw fastqs
cd "$RAW_DIR"
FASTQS=(*.fastq)

## all forward reads!
FORWARD="${FASTQS[$SLURM_ARRAY_TASK_ID-1]}"

SAMPLE=$(basename "$FORWARD" .combined_final.fastq)

O_FOR="${OUTDIR}/${SAMPLE}_trimmed.fastq.gz"
REPORT_JSON="${REPORTDIR}/${SAMPLE}_fastp.json"
REPORT_HTML="${REPORTDIR}/${SAMPLE}_fastp.html"

fastp -i "$FORWARD" \
	-o "$O_FOR" \
	-h "$REPORT_HTML" -j "$REPORT_JSON" \
	--length_required 70 \
	--trim_poly_g --trim_poly_x \
	--qualified_quality_phred 20 \
	--unqualified_percent_limit 30 \
 	--n_base_limit 5 \
	--cut_window_size 4 --cut_mean_quality 20 --cut_right \
	-w "$SLURM_CPUS_PER_TASK"
