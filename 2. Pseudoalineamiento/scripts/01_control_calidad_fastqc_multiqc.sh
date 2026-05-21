#!/bin/bash

# ============================================================
# Script: 01_control_calidad_fastqc_multiqc.sh
# Proyecto: RNA-seq Obeso1 vs Normopeso
# Objetivo: Ejecutar control de calidad de archivos FASTQ
# Herramientas: FastQC y MultiQC
# Autor: Yanis Cruz
# ============================================================

set -euo pipefail

echo "==============================================="
echo "Inicio del control de calidad RNA-seq"
echo "Fecha: $(date)"
echo "==============================================="

# Directorios de entrada y salida
FASTQ_DIR="data/raw_fastq"
FASTQC_OUT="results/fastqc"
MULTIQC_OUT="results/multiqc"

# Crear carpetas de salida si no existen
mkdir -p "${FASTQC_OUT}"
mkdir -p "${MULTIQC_OUT}"

echo "Archivos FASTQ encontrados:"
ls -lh "${FASTQ_DIR}"/*.fastq.gz

echo "Número total de archivos FASTQ:"
ls "${FASTQ_DIR}"/*.fastq.gz | wc -l

echo "==============================================="
echo "Ejecutando FastQC..."
echo "==============================================="

fastqc "${FASTQ_DIR}"/*.fastq.gz \
  -o "${FASTQC_OUT}" \
  -t 4

echo "FastQC finalizado."

echo "==============================================="
echo "Ejecutando MultiQC..."
echo "==============================================="

multiqc "${FASTQC_OUT}" \
  -o "${MULTIQC_OUT}" \
  --force

echo "MultiQC finalizado."

echo "==============================================="
echo "Control de calidad completado correctamente"
echo "Informe final:"
echo "${MULTIQC_OUT}/multiqc_report.html"
echo "Fecha de finalización: $(date)"
echo "==============================================="
