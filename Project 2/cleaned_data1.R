library(tidyverse)
source('Project_2_functions.R')
air_quality <- read.csv('aap_air_quality_database_2018_v12.csv', skip = 2)

new_data1 <-
  as.tibble(air_quality) %>% 
  mutate(pm2.5 = number_extract2(Annual.mean..ug.m3.1)) %>% 
  select(Country, Region, Year, pm2.5)
write_csv(new_data1, "./newdata1.csv")
