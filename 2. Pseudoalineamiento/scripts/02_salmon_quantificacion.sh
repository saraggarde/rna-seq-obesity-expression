#!/bin/bash

# ============================================================
# Script: 02_salmon_quantificacion.sh
# Proyecto: RNA-seq Obeso1 vs Normopeso
# Objetivo: Crear índice de Salmon y cuantificar lecturas paired-end
# Herramienta: Salmon
# Autor: Yanis Cruz
# ============================================================

set -euo pipefail

# Corrección de locale necesaria para evitar error en Salmon
export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export LANGUAGE=en_US.utf8

echo "==============================================="
echo "Inicio de cuantificación con Salmon"
echo "Fecha: $(date)"
echo "==============================================="

# Directorios y archivos
REFERENCE="reference/Referencia.fasta"
INDEX="reference/salmon_index"
FASTQ_DIR="data/raw_fastq"
SALMON_OUT="results/salmon"
LOG_DIR="results/logs"
THREADS=4

# Muestras de la comparación Obeso1 vs Normopeso
SAMPLES=("AbrahamSimpson" "HomerSimpson" "BartSimpson" "LisaSimpson" "MaggieSimpson")

mkdir -p "${SALMON_OUT}"
mkdir -p "${LOG_DIR}"

echo "Referencia utilizada:"
ls -lh "${REFERENCE}"

echo "==============================================="
echo "Reconstruyendo índice de Salmon..."
echo "==============================================="

rm -rf "${INDEX}"

salmon index \
  -t "${REFERENCE}" \
  -i "${INDEX}" \
  -p "${THREADS}" \
  2>&1 | tee "${LOG_DIR}/salmon_index.log"

echo "Índice de Salmon creado correctamente."

echo "==============================================="
echo "Cuantificando muestras..."
echo "==============================================="

for SAMPLE in "${SAMPLES[@]}"
do
  echo "Procesando muestra: ${SAMPLE}"

  rm -rf "${SALMON_OUT}/${SAMPLE}"

  salmon quant \
    -i "${INDEX}" \
    -l A \
    -1 "${FASTQ_DIR}/${SAMPLE}_R1.fastq.gz" \
    -2 "${FASTQ_DIR}/${SAMPLE}_R2.fastq.gz" \
    --validateMappings \
    -p "${THREADS}" \
    -o "${SALMON_OUT}/${SAMPLE}" \
    2>&1 | tee "${LOG_DIR}/${SAMPLE}_salmon_quant.log"

done

echo "==============================================="
echo "Verificando archivos quant.sf generados"
echo "==============================================="

find "${SALMON_OUT}" -name "quant.sf"

echo "==============================================="
echo "Porcentaje de lecturas mapeadas por muestra"
echo "==============================================="

grep -H '"percent_mapped"' "${SALMON_OUT}"/*/aux_info/meta_info.json

echo "==============================================="
echo "Cuantificación con Salmon finalizada correctamente"
echo "Fecha de finalización: $(date)"
echo "==============================================="
