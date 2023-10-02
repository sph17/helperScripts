#!/bin/bash -l
#$ -P rd-spat        # Set SCC project to charge
#$ -t 92-104	     # array index 1-?
#$ -cwd              # set the current working directory of the job to the directory from which the job is submitted
#$ -pe omp 16        # Request cores
#$ -l h_rt=72:00:00  # Specify hard time limit for the job
#$ -o /usr3/graduate/sphao/barcode/logs/granular_bc_array.<job_id>.<task_id>
#$ -e /usr3/graduate/sphao/barcode/logs/granular_bc_array_err
#$ -N granular_bc_array # Name job
#$ -m ea             # Send an email when the job finished or aborted
#$ -j y              # Join error and output streams in one file
#$ -l mem_per_core=8G

# Keep track of information related to the current job
echo "# -------------------------------------------------"
echo "Start date : $(date)"
echo "Job name : $JOB_NAME"
echo "Job ID : $JOB_ID  $SGE_TASK_ID"
echo "Running in directory: $PWD"
echo "# -------------------------------------------------"

# ------------------------------------------------------------------------------
# Load necessary modules
# Ensure that the -l flag is included in the above bash shebang
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Run code
# ------------------------------------------------------------------------------

# Name of the input file
# input_file="complexity.tsv"
input_file="/usr3/graduate/sphao/barcode/input.tsv"

# Declare an empty array
lines_array=()

# Read each line from the file and append it to the array
while IFS= read -r line; do
  lines_array+=("$line")
done < "$input_file"


# Run R script

script="/usr3/graduate/sphao/barcode/random_sample_poisson_simulations.R"
script_basename=$(basename "$script")

echo "Script basename: $script_basename"

taskinput=${lines_array[$(($SGE_TASK_ID-1))]}

echo "Run script: $script_basename"
echo "Inputs: $taskinput"

Rscript $script $taskinput 

echo "Job finished: $(date +%F)"


