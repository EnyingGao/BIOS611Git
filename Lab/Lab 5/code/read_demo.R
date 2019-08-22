library(tidyverse)

demo.data <- read_csv(file = "./data/demographic_data.csv")
write_csv(demo.data, "./demographic_data_cleaned.csv")
