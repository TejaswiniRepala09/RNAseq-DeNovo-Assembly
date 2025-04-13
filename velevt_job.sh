#!/bin/bash
#SBATCH -J velvet_assembly              
#SBATCH -p general                      
#SBATCH -o velvet_output_%j.txt         
#SBATCH -e velvet_error_%j.err          
#SBATCH --mail-type=ALL                 
#SBATCH --mail-user=trepala@iu.edu      
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --time=12:00:00                   
#SBATCH --mem=150GB
#SBATCH -A c01064      

# Load the necessary module
module load miniconda

# Activate the conda environment
conda activate assignment1

# Change to working directory
cd /N/u/trepala/Quartz 


mkdir -p velvet_output_assembly


# Array of k-mer sizes to try
kmer_sizes=(45 55 65 75 85)

# Input_Files
fastq_1=SRR21904868_1.fastq
fastq_2=SRR21904868_2.fastq

# Loop through each k-mer size and run Velvet
for kmer in "${kmer_sizes[@]}"; do
    echo "Running Velvet with k-mer size $kmer"

    # Create a directory for each k-mer size
    output_dir="velvet_output_k${kmer}"
    mkdir -p ${output_dir}

    # Run velveth to generate the hash table
    velveth ${output_dir} ${kmer} -shortPaired -fastq -separate ${fastq_1} ${fastq_2}

    # Run velvetg to assemble the genome
    velvetg ${output_dir} -exp_cov auto -cov_cutoff auto

    echo "Velvet assembly complete for k-mer size $kmer"
done

echo "All Velvet assemblies completed!"


