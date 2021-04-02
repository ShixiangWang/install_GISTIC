#! /usr/bin/env Rscript
# Copyright @ 2020, Shixiang Wang
# Input and Output are a standard Segment file for GISTIC
#
# Usage: Rscript preprocess.R input.seg [minimal_prob, default 0]
#
# Example: Rscript preprocess.R input.seg 5
# Filter segments with less than 5 probes and then clean overlap segments
# by weighted multiplication
message("Loading dependent packages...")
library(data.table)
library(tidygenomics)

message("Parsing input arguments...")
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  args[2] <- 0L
} else {
  args[2] <- max(0L, as.integer(args[2]))
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
outfile <- sub('\\..[^\\.]*$', '', args[1])
data.table::fwrite(data_drop, paste0(outfile, "_clean_overlap.txt"), sep = "\t")
message("Done.")

