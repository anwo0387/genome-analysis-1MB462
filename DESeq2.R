## USE AS INPUT FOR SLURM JOB

library(DESeq2)

# -----------------------------
# Paths
# -----------------------------
counts_file <- "counts/counts.txt"
sample_file <- "counts/sample_table.txt"

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

# ✅ Clean column names:
# - remove full paths
# - keep only BAM filenames
colnames(counts) <- basename(colnames(counts))

# -----------------------------
# Load sample metadata
# -----------------------------
coldata <- read.table(
  sample_file,
  header = TRUE,
  row.names = 1,
  stringsAsFactors = FALSE
)

# ✅ Clean rownames the same way
rownames(coldata) <- basename(rownames(coldata))

# -----------------------------
# Enforce consistent naming
# -----------------------------
# This makes DESeq2 robust against tiny typos like _12_h1 vs _12h_1
rownames(coldata) <- gsub("_12_h", "_12h_", rownames(coldata))

# -----------------------------
# Reorder metadata to match counts
# -----------------------------
coldata <- coldata[colnames(counts), , drop = FALSE]

# ✅ Final safety check
stopifnot(all(colnames(counts) == rownames(coldata)))

# -----------------------------
# Set condition factor
# -----------------------------
coldata$condition <- factor(
  coldata$condition,
  levels = c("control", "heat")
)

# -----------------------------
# Create DESeq2 object
# -----------------------------
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = coldata,
  design = ~ condition
)

# Optional: filter very low counts
dds <- dds[rowSums(counts(dds)) > 10, ]

# -----------------------------
# Run DESeq2
# -----------------------------
dds <- DESeq(dds)

res <- results(dds)

# -----------------------------
# Save outputs
# -----------------------------
write.csv(
  as.data.frame(res),
  file = "counts/deseq2_results.csv"
)

saveRDS(dds, file = "counts/deseq2_dds.rds")

cat("✅ DESeq2 finished successfully\n")
