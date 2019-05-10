# This script concatenates all expected read count files from
# GBRS output.

library(tidyverse)

# Glob all read count files.
filepaths <- (file.path(Sys.glob("[MF][0-9]*"),
                        "gbrs.quantified.diploid.genes.expected_read_counts"))

sampleID <- rep(dirname(filepaths[i]), times = dim(read_table(filepaths[i])))

# Create a table of all read count files.
# Preserve the sample ID.
count_table <- tibble()
for (i in 1:length(filepaths)) {
  tmp <- read_table2(filepaths[i])
  rownum <- dim(tmp)[1]
  sampleID <- rep(dirname(filepaths[i]), times = rownum)
  names(sampleID)[1] <- "sampleID"
  tmp <- cbind(sampleID, tmp)
  count_table <- bind_rows(count_table, tmp)
}



