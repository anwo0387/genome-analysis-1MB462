## USE AS INPUT FOR SLURM JOB

# =============================
# DESeq2 Analysis Script (chr3 RNA-seq)
# =============================

library(DESeq2)

# -----------------------------
# Paths
# -----------------------------
counts_file <- "counts/counts.txt"
sample_file <- "counts/sample_table.txt"
eggnog_file <- "eggnog/Njaponicum/Njaponicum.emapper.annotations"

# -----------------------------
# Load counts
# -----------------------------
counts <- read.table(
  counts_file,
  header = TRUE,
  row.names = 1,
  check.names = FALSE
)

# Remove featureCounts annotation columns
counts <- counts[, 6:ncol(counts)]

# Remove path → keep only filenames
colnames(counts) <- basename(colnames(counts))

# -----------------------------
# Load metadata
# -----------------------------
coldata <- read.table(
  sample_file,
  header = TRUE,
  row.names = 1,
  stringsAsFactors = FALSE
)

# Clean rownames
rownames(coldata) <- basename(rownames(coldata))

# Fix common naming inconsistencies
rownames(coldata) <- gsub("_12_h", "_12h_", rownames(coldata))

# Match order
coldata <- coldata[colnames(counts), , drop = FALSE]

# Final safety check
stopifnot(all(colnames(counts) == rownames(coldata)))

# -----------------------------
# DESeq2 setup
# -----------------------------
coldata$condition <- factor(coldata$condition,
                            levels = c("control", "heat"))

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = coldata,
  design = ~ condition
)

# Filter low-expression genes
dds <- dds[rowSums(counts(dds)) > 10, ]

# Run DESeq2
dds <- DESeq(dds)
res <- results(dds)

# -----------------------------
# Save full DE results
# -----------------------------
write.csv(
  as.data.frame(res),
  "counts/deseq2_results.csv"
)

cat("✅ DESeq2 results saved\n")

# -----------------------------
# Extract TOP 15 genes ONLY (no eggNOG)
# -----------------------------
res_df <- as.data.frame(res)

# Remove NA p-values
res_df <- res_df[!is.na(res_df$pvalue), ]

# Order by p-value
res_df <- res_df[order(res_df$pvalue), ]

# Select top 15
top15 <- head(res_df, 15)

# Add GeneID column
top15$GeneID <- rownames(top15)

# Format values
top15$baseMean <- round(top15$baseMean, 2)
top15$log2FoldChange <- round(top15$log2FoldChange, 2)
top15$lfcSE <- round(top15$lfcSE, 2)
top15$pvalue <- signif(top15$pvalue, 3)
top15$padj <- signif(top15$padj, 3)

# Add regulation label
top15$Regulation <- ifelse(
  top15$log2FoldChange > 1, "Up (heat)",
  ifelse(top15$log2FoldChange < -1, "Down (heat)", "Moderate")
)

# Keep nice columns
top15 <- top15[, c(
  "GeneID",
  "baseMean",
  "log2FoldChange",
  "lfcSE",
  "pvalue",
  "padj",
  "Regulation"
)]

# Save
write.csv(
  top15,
  "counts/top15_genes_only.csv",
  row.names = FALSE
)

cat("✅ Top 15 DE genes saved (no eggNOG)\n")
