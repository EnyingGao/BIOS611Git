library(tidyverse)

args = commandArgs(trailingOnly = TRUE)

# Load Data
institution_information <- read_csv(args[1], col_names = c('institution', 'abstract_emphases'))

fileConn = file("combine.csv")
writeLines(paste(institution_information$institution, institution_information$abstract_emphases, sep = ','), fileConn)
close(fileConn)