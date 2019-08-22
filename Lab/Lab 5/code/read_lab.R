library(tidyverse)

lab.data1 <- read_csv(file = "./data/lab_data1.csv")
lab.data2 <- read_csv(file = "./data/lab_data2.csv")
lab.data3 <- read_csv(file = "./data/lab_data3.csv")
lab.data4 <- read_csv(file = "./data/lab_data4.csv")

colnames(lab.data2) <- c("id", "bmi", "bp")
colnames(lab.data4) <- c("id", "bmi", "bp")
lab.data <- rbind(lab.data1,lab.data2,lab.data3,lab.data4)

write_csv(lab.data, "./lab_data_cleaned.csv")
