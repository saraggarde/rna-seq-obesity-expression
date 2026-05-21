#!/usr/bin/env python3

import csv
from collections import defaultdict

# Archivos de entrada
metadata_file = "metadata/samples_obeso1_normopeso.csv"
tx2gene_file = "reference/tx2gene.tsv"
salmon_dir = "results/salmon"

# Archivos de salida
out_counts = "results/matrices/gene_counts_salmon.csv"
out_tpm = "results/matrices/gene_tpm_salmon.csv"

# Crear carpeta de salida si no existe
import os
os.makedirs("results/matrices", exist_ok=True)

# Leer metadatos
samples = []
with open(metadata_file, newline="") as f:
    reader = csv.DictReader(f)
    for row in reader:
        samples.append(row["sample"])

# Leer relación transcrito -> gen
tx2gene = {}
with open(tx2gene_file) as f:
    for line in f:
        tx, gene = line.strip().split("\t")
        tx2gene[tx] = gene

# Diccionarios para almacenar conteos y TPM por gen
gene_counts = defaultdict(lambda: defaultdict(float))
gene_tpm = defaultdict(lambda: defaultdict(float))

# Procesar cada archivo quant.sf
for sample in samples:
    quant_file = os.path.join(salmon_dir, sample, "quant.sf")

    with open(quant_file, newline="") as f:
        reader = csv.DictReader(f, delimiter="\t")

        for row in reader:
            tx = row["Name"]
            gene = tx2gene.get(tx)

            if gene is None:
                continue

            gene_counts[gene][sample] += float(row["NumReads"])
            gene_tpm[gene][sample] += float(row["TPM"])

# Lista ordenada de genes
genes = sorted(gene_counts.keys())

# Guardar matriz de conteos
with open(out_counts, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["GeneID"] + samples)

    for gene in genes:
        row = [gene] + [round(gene_counts[gene][sample], 3) for sample in samples]
        writer.writerow(row)

# Guardar matriz de TPM
with open(out_tpm, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["GeneID"] + samples)

    for gene in genes:
        row = [gene] + [round(gene_tpm[gene][sample], 6) for sample in samples]
        writer.writerow(row)

print("Matrices generadas correctamente:")
print(out_counts)
print(out_tpm)
print(f"Número de genes incluidos: {len(genes)}")
print(f"Muestras incluidas: {', '.join(samples)}")
