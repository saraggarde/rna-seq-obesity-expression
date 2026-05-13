#!/bin/bash

# Script: 01_quality_control.sh
# Objetivo: realizar el control de calidad de archivos FASTQ con FastQC y MultiQC

set -e

# Crear carpetas necesarias
mkdir -p data/raw_fastq
mkdir -p results/fastqc
mkdir -p results/multiqc

# Instalar FastQC
sudo apt update
sudo apt install -y fastqc python3-pip python3.14-venv

# Crear entorno virtual para MultiQC fuera de OneDrive (en OneDrive da error)
if [ ! -d "$HOME/multiqc_env" ]; then
    python3 -m venv "$HOME/multiqc_env"
fi

# Activar entorno virtual
source "$HOME/multiqc_env/bin/activate"

# Instalar MultiQC dentro del entorno virtual
python -m pip install --upgrade pip
python -m pip install --upgrade multiqc

# Ejecutar FastQC sobre todos los archivos FASTQ
fastqc data/raw_fastq/*.fastq.gz -o results/fastqc/

# Ejecutar MultiQC para unificar el análisis en un solo HTML
multiqc results/fastqc/ -o results/multiqc/  --no-data-dir --force



