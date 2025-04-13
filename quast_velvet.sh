#!/bin/bash
#SBATCH -J quast_velvet
#SBATCH -p general
#SBATCH -o quast_output_%j.txt
#SBATCH -e quast_error_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=trepala@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=12:00:00
#SBATCH --mem=80GB
#SBATCH -A c01064

# Load the necessary module
module load miniconda

# Activate the conda environment
conda activate assignment1

# Change to directory velvet output located
cd /N/u/trepala/Quartz

# Run QUAST to compare all Velvet assemblies
quast -o quast_velvet_output -l "k45,k55,k65,k75,k85" \
    velvet_output_k45/contigs.fa \
    velvet_output_k55/contigs.fa \
    velvet_output_k65/contigs.fa \
    velvet_output_k75/contigs.fa \
    velvet_output_k85/contigs.fa 

echo "QUAST analysis completed for Velvet assemblies!"

