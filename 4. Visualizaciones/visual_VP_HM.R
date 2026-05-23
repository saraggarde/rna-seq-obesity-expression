# Actividad grupal. Análisis de expresión diferencial de genes relacionados con la obesidad mediante RNA-seq

# Librerías
library("ggplot2")
library("pheatmap")
library("EnhancedVolcano")

# Cargar los resultados de DESeq2 a nivel de transcrito
res_dest_crudo <- read.csv("DESeq2_results.csv", row.names = 1, check.names = FALSE)
# Convertir los IDs de transcrito en una columna normal
res_dest_crudo$transcrito <- rownames(res_dest_crudo)
# Cargar la tabla que relaciona transcritos con genes
trans_gene <- read.delim("Transcrito_a_Gen.tsv", header = FALSE, sep = "\t", stringsAsFactors = FALSE, check.names = FALSE)
# Asignar nombres a las columnas de la tabla transcrito-gen
colnames(trans_gene) <- c("transcrito", "gen")
View(trans_gene)
# Unir los resultados DESeq2 con el gen asociado a cada transcrito
res_desg_crudo <- merge(res_dest_crudo, trans_gene, by = "transcrito")
View(res_desg_crudo)
nrow(res_desg_crudo)
# Eliminar transcritos sin padj o sin log2FoldChange
res_desg_sin_NA <- res_desg_crudo[!is.na(res_desg_crudo$padj) & !is.na(res_desg_crudo$log2FoldChange),]
View(res_desg_sin_NA)
nrow(res_desg_sin_NA)


# VOLCANO PLOT

# Volcano plot de todos los transcritos pero con gen anotado
volcano_transcritos <- EnhancedVolcano(
  res_desg_sin_NA,                  # Tabla limpia con transcritos y genes
  lab = res_desg_sin_NA$gen,        # Etiquetas: nombre del gen asociado
  x = "log2FoldChange",             # Eje X: cambio de expresión
  y = "padj",                     # Eje Y: significancia estadística
  pCutoff = 0.05,                   # Umbral de significancia
  FCcutoff = 1,                     # Umbral de cambio de expresión
  title = "Volcano plot de transcritos",
  xlab = "log2 Fold Change",
  ylab = "-log10(pvalue ajustado)",
  legendLabels = c(
    "No significativo",
    "ED dentro del umbral",
    "Solo padj",
    "ED dentro del umbral y significativa"),
  legendLabSize = 8,
  legendIconSize = 3,
  axisLabSize = 12,
  titleLabSize = 16,
  subtitleLabSize = 14,
  captionLabSize = 10,
  pointSize = 0.5,
  labSize = 3
)

volcano_transcritos


# HEATMAP

# Cargar la matriz de expresión TPM a nivel de gen
mat <- read.csv("gene_tpm_salmon.csv", row.names = 1, check.names = FALSE)
View(mat)
# Comprobación del tamaño de la matriz de expresión y los nombres de las muestras
dim(mat)
colnames(mat)
# Crear la anotación de grupo para las muestras
col_grupo <- data.frame(Grupo = c("Obeso 1", "Obeso 1", "Normopeso", "Normopeso", "Normopeso"))
# Asignar los nombres de las muestras a la tabla de grupo
rownames(col_grupo) <- colnames(mat)
# Comprobación que cada muestra tiene su grupo correcto
col_grupo
View(col_grupo)

# Transformar TPM con log2 para reducir diferencias extremas
mat_log <- log2(mat + 1)
# Escalar cada gen por filas para comparar patrones relativos entre muestras
mat_scaled <- t(scale(t(mat_log)))
# Comprobar que la matriz mantiene 37 genes y 5 muestras
dim(mat_scaled)

# Definir cuántos transcritos top se van a representar
n_top <- 20
# Ordenar los transcritos por padj de menor a mayor
orden_transcritos <- res_desg_sin_NA[order(res_desg_sin_NA$padj),]
# Seleccionar los top 20 transcritos más significativos
top_transcritos <- head(orden_transcritos, n_top)
# Extraer los genes asociados a esos top transcritos
top_genes <- top_transcritos$gen
# Extraer la expresión escalada de los genes asociados a los top transcritos
mat_top_scaled <- mat_scaled[top_genes,]

# Heatmap de los top transcritos pero mostrando el gen asociado
heatmap_genes <- pheatmap(
  mat_top_scaled,
  annotation_col = col_grupo,
  annotation_colors = list(
    Grupo = c("Normopeso" = "#F2E8CF", "Obeso 1" = "#BC4749")
  ),
  color = colorRampPalette(
    c("#08306B", "#4292C6", "#FFFFBF", "#FEE08B", "#D73027")
  )(100),
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  labels_row = paste0(top_transcritos$gen, " (", top_transcritos$transcrito, ")"),
  show_rownames = TRUE,
  show_colnames = TRUE,
  fontsize_row = 7,
  fontsize_col = 9,
  main = "Heatmap de top 20 genes"
)

heatmap_genes



# Exportación 
library(grid)

# Volcano a PDF y PNG (300 dpi)
ggsave(
  filename = "volcano_transcritos_poster.pdf",
  plot = volcano_transcritos,
  width = 8,
  height = 6
)
ggsave(
  filename = "volcano_transcritos_poster.png",
  plot = volcano_transcritos,
  width = 8,
  height = 6,
  dpi = 300
)

# Hetamap a PDF y PNG (300 dpi)
pdf(
  file = "heatmap_genes_poster.pdf",
  width = 8,
  height = 10
)
grid.draw(heatmap_genes$gtable)
dev.off()
png(
  filename = "heatmap_genes_poster.png",
  width = 8,
  height = 10,
  units = "in",
  res = 300
)
grid.draw(heatmap_genes$gtable)
dev.off()

