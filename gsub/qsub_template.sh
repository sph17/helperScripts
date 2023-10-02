#!/bin/bash -l
#$ -P findthecause        # Set SCC project to charge
#$ -wd /restricted/projectnb/findthecause/scRNAseq_mutdec/data # Specify the working directory
#$ -pe omp 16        # Request cores
#$ -l h_rt=72:00:00  # Specify hard time limit for the job
#$ -N t_sam2fastq       # Name job
#$ -m ea             # Send an email when the job finishes or aborts
#$ -j y              # Join error and output streams in one file

# Keep track of information related to the current job
echo "# -------------------------------------------------"
echo "Start date: $(date)"
echo "Job name: $JOB_NAME"
echo "Job ID: $JOB_ID  $SGE_TASK_ID"
echo "Running in directory: $PWD"
echo "# -------------------------------------------------"

# ------------------------------------------------------------------------------
# Load necessary modules
# Ensure that the -l flag is included in the above bash shebang
# ------------------------------------------------------------------------------

module load picard
_JAVA_OPTIONS="-Xmx16g -XX:ActiveProcessorCount=1 -Djava.util.concurrent.ForkJoinPool.common.parallelism=1 -Djava.io.tmpdir=~/tmp"

# ------------------------------------------------------------------------------
# Run code
# ------------------------------------------------------------------------------

# Run picard SamToFastq
picard SamToFastq I="${PWD}/P2_cSCC_scRNA.bam.1" \
FASTQ="${PWD}/P2_cSCC_scRNA_R1.fastq.gz" \
SECOND_END_FASTQ="${PWD}/P2_cSCC_scRNA_R2.fastq.gz"

echo "Job finished: $(date +%F)"