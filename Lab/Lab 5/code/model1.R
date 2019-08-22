library(tidyverse)
data.cleaned <- read.csv("./data_cleaned.csv")

train.data <- data.cleaned %>% select(-id)
fit1 <- lm(bp~., data=train.data)

save(fit1, file = "model1.RData")
