library(tidyverse)

medhist.data1 <- read_csv(file = "./data/medhist_data1.csv")
medhist.data2 <- read_csv(file = "./data/medhist_data2.csv")

medhist.data <- rbind(medhist.data1, medhist.data2)
write_csv(medhist.data, "./medhist_data_cleaned.csv")
