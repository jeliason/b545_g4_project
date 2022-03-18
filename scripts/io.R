library(magrittr)

load_scATAC <- function(matrix_dir) {
  barcode.path <- paste0(matrix_dir, "barcodes.tsv.gz")
  features.path <- paste0(matrix_dir, "peaks.bed.gz")
  matrix.path <- paste0(matrix_dir, "matrix.mtx.gz")

  features <- readr::read_tsv(features.path, col_names = F) %>% tidyr::unite(feature)
  barcodes <- readr::read_tsv(barcode.path, col_names = F) %>% tidyr::unite(barcode)

  mat <- Matrix::readMM(matrix.path) %>%
    magrittr::set_rownames(features$feature) %>%
    magrittr::set_colnames(barcodes$barcode)

  mat
}

load_scRNA <- function(matrix_dir) {
  barcode.path <- paste0(matrix_dir, "barcodes.tsv.gz")
  features.path <- paste0(matrix_dir, "features.tsv.gz")
  matrix.path <- paste0(matrix_dir, "matrix.mtx.gz")
  mat <- Matrix::readMM(file = matrix.path)
  feature.names = read.delim(features.path,
                             header = FALSE,
                             stringsAsFactors = FALSE)
  barcode.names = read.delim(barcode.path,
                             header = FALSE,
                             stringsAsFactors = FALSE)
  colnames(mat) = barcode.names$V1
  rownames(mat) = feature.names$V1

  mat
}
