# Load Library
library(tidyverse)

# Read data
police_locals <- read.csv('police-locals.csv')

# Scatter plot
police_locals %>% 
  filter(police_force_size > 1000) %>% 
  ggplot(aes(police_force_size, all)) +
  geom_point() +
  ggsave("hw5_police_plot.png")