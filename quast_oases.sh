#!/bin/bash
#SBATCH -J quast_oases
#SBATCH -p general
#SBATCH -o quast_oases_output_%j.txt
#SBATCH -e quast_oases_error_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=trepala@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=12:00:00
#SBATCH --mem=32GB
#SBATCH -A c01064

# Load the necessary module
module load miniconda

# Activate the conda environment
conda activate assignment1

# Change to directory velvet output located
cd /N/u/trepala/Quartz

# Run QUAST to compare all Velvet assemblies
quast -o quast_oases_output -l "k45,k55,k65,k75,k85" \
    velvet_output_k45/transcripts.fa \
    velvet_output_k55/transcripts.fa \
    velvet_output_k65/transcripts.fa \
    velvet_output_k75/transcripts.fa \
    velvet_output_k85/transcripts.fa

echo "QUAST analysis completed for oases assemblies!"
