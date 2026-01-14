#!/bin/bash

#SBATCH --job-name=fastq_reads
#SBATCH -A evoanalysis
#SBATCH -t 0-04:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cporte26@uwyo.edu
#SBATCH -e logs/fastq_reads_%A_%a.err
#SBATCH -o logs/fastq_reads_%A_%a.out
#SBATCH --array=1-38 # 38 FASTQ files
#SBATCH --chdir=/project/evoanalysis/cporte26/evoanalysis-2026

### failsafe
set -euo pipefail

### make logs/results dirs
mkdir -p fastq_results
mkdir -p logs

FASTQ_LIST="fastq_list.txt"

### assign tasks based on fastq_list.txt for array
FASTQ=/project/evoanalysis/d3challenge_fq/$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$FASTQ_LIST")

### count reads... 4 lines/read
READS=$(( $(wc -l < "$FASTQ") / 4 ))

### print counts to file
printf "%s\t%s\n" "$(basename "$FASTQ")" "$READS" > "fastq_results/read_$(basename "$FASTQ" .fastq).txt"
