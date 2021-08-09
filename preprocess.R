#! /usr/bin/env Rscript
# Copyright @ 2021, Shixiang Wang
# Input and Output are a standard Segment file for GISTIC
#
# Usage: Rscript preprocess.R input.seg [minimal_prob, default 0] [output_file, default set a file with the same prefix but add '_clean_overlap.txt']
#
# Example: Rscript preprocess.R input.seg 5
# Filter segments with less than 5 probes and then clean overlap segments
# by weighted multiplication
message("Loading dependent packages...")
library(data.table)
library(tidygenomics)
library(magrittr)

message("Parsing input arguments...")
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) {
  if (length(args) < 2) {
    args[2] <- 0L
  } else {
    args[2] <- max(0L, as.integer(args[2]))
  }
  output_file <- paste0(sub('\\..[^\\.]*$', '', args[1]), "_clean_overlap.txt")
} else if (length(args) == 3) { 
  args[2] <- max(0L, as.integer(args[2]))
  output_file <- args[3]
} else {
  stop("Too many arguments!")
}


message("Reading file...")
data <- fread(args[1])
colnames(data) <- c("Sample_ID", "Chromosome", "Start", "End", "Num_Probes", "Segment_Mean")

if (args[2] != 0) {
  message("Filtering segments with at least ", args[2], " probes...")
  nr <- nrow(data)
  data <- data[Num_Probes >= args[2]]
  message(nr - nrow(data), " rows dropped.")
}

drop_overlaps <- function(x) {
  x2 <- genome_cluster(
    x,
    by = c("Chromosome", "Start", "End"),
    max_distance = 0) %>% 
    data.table::as.data.table()
  
  x2[, .(
    Chromosome = unique(Chromosome),
    Start = max(min(Start), 1),
    End = max(End),
    Num_Probes = sum(Num_Probes),
    Segment_Mean = sum(Segment_Mean * Num_Probes) / sum(Num_Probes)
  ), by = cluster_id]
}

message("Cleaning overlaps...")
data_drop <- data[, drop_overlaps(.SD), by = Sample_ID]
data_drop$cluster_id <- NULL

message("Outputing...")
if (!dir.exists(dirname(output_file))) {
  dir.create(dirname(output_file), recursive = TRUE)
}

data.table::fwrite(data_drop, output_file, sep = "\t")
message("Done.")
