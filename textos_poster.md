# Control de calidad

El control de calidad de los archivos FASTQ se realizó con FastQC y MultiQC. Todas las muestras presentaron una calidad de secuenciación muy alta y homogénea, con valores Phred entre Q35 y Q37, contenido GC consistente (45-46%), baja duplicación (0.2-0.7%) y ausencia de bases indeterminadas y de contaminación significativa por adaptadores (<1%).

Aunque FastQC detectó warnings en el contenido GC, este comportamiento es habitual en experimentos de RNA-seq debido a diferencias en abundancia de los transcritos y no indica problemas de calidad. En conjunto, los datos se consideraron adecuados para continuar directamente con el pseudoalineamiento mediante Salmon, sin necesidad de filtrado ni preprocesamiento adicional.
