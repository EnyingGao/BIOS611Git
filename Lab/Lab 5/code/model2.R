library(tidyverse)
data.cleaned <- read.csv("./data_cleaned.csv")

train.data <- data.cleaned %>% select(-one_of('id', 'age'))
fit2 <- lm(bp~., data=train.data)

save(fit2, file = "model2.RData")
