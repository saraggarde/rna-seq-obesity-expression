# Expresión diferencial de genes relacionados con la obesidad mediante RNA-seq

Repositorio del proyecto realizado para el Máster Universitario en Bioinformática (UNIR), centrado en el análisis de expresión diferencial de genes relacionados con la obesidad mediante datos de RNA-seq.

El objetivo principal del proyecto es identificar genes diferencialmente expresados entre individuos obesos y normopeso utilizando técnicas de secuenciación de nueva generación y herramientas bioinformáticas de análisis transcriptómico.

---

# Estructura del repositorio

```text
rna-seq-obesity-expression/
│
├── 1. Control de calidad/
│   ├── data/raw_fastq/
│   ├── results/
│   ├── scripts/
│   └── Conclusiones.md
│
├── 2. Pseudoalineamiento/
│   ├── entregables_poster/
│   ├── resultados_salmon/
│   └── scripts/
│
├── 3. Expresión diferencial/
│   ├── Resultados/
│   └── Scripts/
│
├── 4. Visualizaciones/
│   ├── analisis_visual_RNAseq.Rmd
│   ├── analisis_visual_RNAseq.html
│   ├── heatmap_genes_poster.pdf
│   ├── volcano_transcritos_poster.pdf
│   ├── visual_VP_HM.R
│   └── visualizaciones.txt
│
├── 5. Póster/
│
├── LICENSE
└── README.md
```

---

# Flujo de trabajo

El análisis se desarrolló en varias etapas:

## 1. Control de calidad

Se realizó el control de calidad de los archivos FASTQ utilizando:

- FastQC
- MultiQC

Se evaluaron métricas como:

- calidad Phred
- contenido GC
- duplicación
- contenido de adaptadores
- secuencias sobrerrepresentadas

Los resultados mostraron una calidad de secuenciación alta y homogénea entre muestras.

---

## 2. Pseudoalineamiento

El pseudoalineamiento y cuantificación de transcritos se realizó con:

- Salmon

Se obtuvieron métricas de mapeo y tablas de expresión TPM para posteriores análisis.

---

## 3. Expresión diferencial

El análisis de expresión diferencial se llevó a cabo mediante:

- DESeq2

Se compararon muestras de individuos obesos y normopeso para identificar genes diferencialmente expresados asociados a procesos metabólicos y regulación del apetito.

---

## 4. Visualización de resultados

Se generaron distintas representaciones gráficas para interpretar los resultados:

- Volcano plot
- Heatmap de genes diferencialmente expresados

Las visualizaciones fueron realizadas en R utilizando:

- ggplot2
- pheatmap
- EnhancedVolcano

---

# Resultados principales

El análisis identificó varios genes potencialmente relacionados con obesidad y regulación metabólica, entre ellos:

- LEP
- LEPR
- POMC
- PCSK1
- PPARG
- KSR2
- BDNF

Los resultados sugieren posibles alteraciones en:

- regulación del apetito
- saciedad
- metabolismo energético
- señalización hormonal

---

# Tecnologías y herramientas utilizadas

## Lenguajes

- R
- Bash

## Herramientas bioinformáticas

- FastQC
- MultiQC
- Salmon
- DESeq2

## Librerías de R

- ggplot2
- pheatmap
- EnhancedVolcano

---

# Reparto de trabajo
| Persona | Tarea | Hecho |
|---|---|---|
| Persona 1 | Montar un repositorio de GitHub para subir todo allí. | Hecho |
| Persona 1 | Organizar los ficheros en GitHub. | Hecho |
| Persona 1 | Realizar el **control de calidad de los FASTQ**. | Hecho |
| Persona 1 | Justificar si es necesario filtrado/preprocesamiento. | Hecho |
| Persona 1 | Preparar los resultados gráficos, tablas, figuras y texto resumen del control de calidad para añadir al póster. | Hecho |
| Persona 2 | Realizar el **pseudoalineamiento con Salmon**. | Hecho |
| Persona 2 | Obtener una matriz de conteos por gen y muestra. | Hecho |
| Persona 2 | Preparar los resultados gráficos, tablas, figuras y texto resumen del pseudoalineamiento para añadir al póster. | Hecho |
| Persona 3 | Justificar que no hace falta normalización externa, ya que **DESeq2** incorpora normalización interna. | Hecho |
| Persona 3 | Comparar los dos grupos asignados y detectar genes más o menos expresados con **DESeq2**. | Hecho |
| Persona 3 | Crear una tabla de genes diferencialmente expresados. | Hecho |
| Persona 3 | Preparar los resultados gráficos, tablas, figuras y texto resumen del análisis diferencial para añadir al póster. | Hecho |
| Persona 4 | Preparar el **volcano plot**. | Hecho |
| Persona 4 | Preparar el **heatmap**. | Hecho |
| Persona 4 | Preparar la tabla de expresión por gen/personaje. | Hecho |
| Persona 4 | Adaptar todos los gráficos para el póster. | Hecho |
| Persona 4 | Redactar un texto de análisis de los resultados de los gráficos. | Hecho |
| Persona 5 | Realizar la interpretación biológica final, unificando todos los resultados. | Hecho |
| Persona 5 | Montar el póster con todos los gráficos, tablas y resultados proporcionados por el resto del grupo. | Hecho |

# Autores

- Pablo Carballo López
- Sara Guillén Garde
- Vicente Llorente Úbeda
- Víctor Pérez Amores
- Yanis Cruz Quintana

---

# Licencia

Este proyecto se distribuye bajo licencia GPL-3.0.
