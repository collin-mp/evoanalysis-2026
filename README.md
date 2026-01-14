# Advanced Evolutionary Analysis 2026

## 1/14/2026 - Array scripts to count reads from multiple FASTQ files
The repo contains three script: fastq_read_init.sh, fastq_reads.slurm, and fastq_cat.slurm.
fastq_read_init.sh is a bash script to be run first; it creates a list of FASTQ filenames for downstream use and navigates to the proper wd.
fastq_reads.slurm is a slurm script that finds the number of reads from each FASTQ file. The array # should be modified for the number of FASTQ files identified with the initial script.
fastq_cat.slurm is an additional slurm script that compiles reads from each FASTQ file into a single document.
