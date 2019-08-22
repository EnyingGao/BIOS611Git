library(tidyverse)

demo.data <- read_csv("./demographic_data_cleaned.csv")
lab.data <- read_csv("./lab_data_cleaned.csv")
medhist.data <- read_csv("./medhist_data_cleaned.csv")
data <- full_join(demo.data, lab.data, by = c("id")) %>% 
  full_join(medhist.data, by = c("id"))

data.cleaned <- data[complete.cases(data),]
write_csv(data.cleaned, "./data_cleaned.csv")
