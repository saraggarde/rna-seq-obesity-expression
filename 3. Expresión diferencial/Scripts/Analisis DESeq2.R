# Analisis de expresion diferencial con DESeq2
# ------------------------------------------------------------------
# Librerias
# ------------------------------------------------------------------
library(BiocManager)
BiocManager::install("DESeq2")
BiocManager::install("tximport")
BiocManager::install("EnhancedVolcano")
library(DESeq2)
library(tximport)
library(EnhancedVolcano)
library(pheatmap)
# ------------------------------------------------------------------
# Cargamos la matriz de conteo
counts <- list.files(path = "Personajes",pattern = "quant.sf",recursive = TRUE,full.names = TRUE
)
head(counts)
# ------------------------------------------------------------------
# Poner nombres correctos
names(counts) <- c( "AbrahamSimpson","BartSimpson","HomerSimpson","LisaSimpson","MaggieSimpson"
)
counts
# ------------------------------------------------------------------
# Importamos de Salmon
importado <- tximport(counts,type = "salmon", txOut = TRUE)
head(importado$counts)
counts_matrix <- importado$counts # Matriz de conteo
datos <- round(counts_matrix) #Numeros enteros
head(counts_matrix)
# ------------------------------------------------------------------
# Creamos el metadata
metadata <- data.frame(
  row.names = c("AbrahamSimpson","BartSimpson","HomerSimpson","LisaSimpson","MaggieSimpson"),
  grupo = c("Obeso","Normopeso","Obeso","Normopeso","Normopeso")
)
metadata # Informacion experimental necesaria para cada muestra
# ------------------------------------------------------------------
# Analisis DESeq2
# ------------------------------------------------------------------
# Creacion del objeto DESeqDataSet con el count y el metadata
dds <- DESeqDataSetFromMatrix(datos, colData=metadata, design=~grupo) #Junta metadata, matriz de conteo y grupos
# ------------------------------------------------------------------
# Ejecutamos DESeq2
dds <- DESeq(dds)
# ------------------------------------------------------------------
# Resultados
res <- results(dds,contrast = c("grupo", "Obeso", "Normopeso"),alpha = 0.05)
head(res)
summary(res)
# ------------------------------------------------------------------
# Guardo la tabla con los resultados
write.csv(as.data.frame(res),"DESeq2_results.csv")
# ------------------------------------------------------------------
# Creo un dataframe
res_df <- as.data.frame(res)
write.csv(res_df,"res_df.csv",row.names = FALSE) #Exportar la tabla de genes
res_df$GeneID <- rownames(res_df)
head(res_df)
# ------------------------------------------------------------------
# Representacion Volcano Plot

EnhancedVolcano(res_df, lab=res_df$GeneID, x='log2FoldChange', y='pvalue', labSize = 3, axisLabSize = 10)
# ------------------------------------------------------------------
# Representacion MA plot

plotMA(res) # Representacion MA plot
# ------------------------------------------------------------------
# Genes representativos 
# Ordenar por significancia ajustada
res_ordered <- res_df[order(res_df$padj), ]
# Seleccionar los 15 genes más significativos
top15_genes <- head(res_ordered, 15)
top15_genes

# Heatmap
vsd <- varianceStabilizingTransformation(dds, blind = FALSE) 
mat <- assay(vsd)[(rownames(res)), ] 
mat_scaled <- t(scale(t(mat))) 
mat_subset <- mat_scaled[(head(order(res$padj), 15)), ]
pheatmap(mat_subset,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         annotation_col = as.data.frame(colData(dds)),
         show_rownames = TRUE,
         show_colnames = TRUE,
         color = colorRampPalette(c("blue", "white", "red"))(50))

# ------------------------------------------------------------------