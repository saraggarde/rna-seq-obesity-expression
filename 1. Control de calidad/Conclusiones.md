Se realizó el control de calidad de los archivos FASTQ utilizando FastQC y posteriormente se agruparon todos los resultados con MultiQC para facilitar la interpretación conjunta de las muestras.

# 1. Duplicados
El porcentaje de secuencias duplicadas en todos los FASTQ es muy bajo, entre 0.2% y 0.7%. Esto indica  que casi todas las lecturas son únicas, la librería tiene mucha diversidad y no parece haber sobreamplificación por PCR.

# 2. Contenido GC
El porcentaje de GC es muy homogéneo entre todas las muestras, aprox. 45-46%. No se observan diferencias importantes entre librerías, lo que indica consistencia entre muestras.

# 3. Sequence Counts
Todas las muestras tienen aproximadamente el mismo número de lecturas, aprox. 1300 lecturas por FASTQ. Esto es importante porque evita sesgos debidos a diferencias grandes de secuenciación entre muestras.

# 4. Calidad por base
Todas las muestras tienen valores de calidad por base entre Q35 y Q37, es decir, valores Phred alrededor de 36, lo que representa una calidad excelente de secuenciación. Además la calidad se mantiene estable a lo largo de toda la lectura. Todas las lecturas tienen una calidad media de entre 35 y 37.

# 5. Per Base Sequence Content
No se observan desviaciones importantes ni patrones extraños en la composición de bases a lo largo de las lecturas. Para todos los individuos, tods las bases se encuentran en un porcentaje equilibrado, entre 23% y 27%. Los perfiles encajan con datos normales de RNA-seq.

# 6. Per Sequence GC Content
En este apartado aparecen 6 warnings y 6 fails. Esto ocurre porque FastQC espera una distribución aproximadamente normal típica de ADN genómico. Sin embargo, en RNA-seq la distribución depende de los genes expresados, algunos transcritos son mucho más abundantes que otros, por lo que es habitual que la distribución no sea normal. 

Lo importante es que todas las curvas son muy similares entre muestras, no aparecen picos extraños y las distribuciones están centradas aproximadamente entre 45% y 50% GC, por lo que parece una variabilidad biológica normal de RNA-seq y no un problema de contaminación.

# 8. Bases indeterminadas (N content)
El porcentaje de bases indeterminadas es 0% en todas las muestras. Esto indica ausencia de posiciones ambiguas en las lecturas.

# 9. Sequence Length Distribution
Todas las muestras presentan lecturas de longitud única de 151 bp.

# 10. Sequence Duplication Levels
La gran mayoría de las secuencias aparecen una sola vez, confirmando muy baja duplicación.

# 11. Overrepresented Sequences
Se detectaron algunas secuencias sobrerrepresentadas, pero con porcentajes muy bajos (0.01-0.08%). Las secuencias más frecuentes tienen 2 o 4 ocurrencias. Excepto una secuencia rica en adeninas con 14 ocurrencias, probablemente corresponde a colas poly-A de transcritos. No parece existir contaminación relevante.

# 12. Adapter Content
El contenido de adaptadores es menor al 1% en todas las muestras, esto indica ausencia de contaminación significativa por adaptadores.

# Conclusión
En conjunto, los resultados del control de calidad indican que todas las muestras tienen una calidad de secuenciación muy alta y homogénea entre todas las librerías. Las lecturas mantienen valores Phred muy altos y estables en toda la secuencia. Además no se observa contaminación significativa por adaptadores ni presencia de bases indeterminadas

Los niveles de duplicación son muy bajos, lo que sugiere una buena complejidad de biblioteca, y las distribuciones de contenido GC son consistentes entre muestras y compatibles con la variabilidad esperable en experimentos de RNA-seq.

Dado que no se detectaron problemas relevantes de calidad ni sesgos técnicos importantes, se decidió continuar directamente con el pseudoalineamiento mediante Salmon, sin aplicar pasos adicionales de filtrado o preprocesamiento.
