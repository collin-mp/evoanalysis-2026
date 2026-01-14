#!/bin/bash
#SBATCH --job-name=merge_reads
#SBATCH -A evoanalysis
#SBATCH -t 0-00:10
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cporte26@uwyo.edu
#SBATCH -e logs/fastq_merge.err
#SBATCH -o logs/fastq_merge.out
#SBATCH --chdir=/project/evoanalysis/cporte26/evoanalysis-2026

set -euo pipefail

### merge previous task outputs into a single .txt
cat fastq_results/read_*.txt | sort -V > fastq_results/results.txt

###optional:  remove individual per-task files
###rm fastq_results/read_*.txt

echo "Merge complete: fastq_results/results.txt"
