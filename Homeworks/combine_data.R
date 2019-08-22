# Join table death and sdpm25
library(tidyverse)
source('Project_2_functions.R')
death <- read.csv('Death.csv', skip = 2, col.names = c("country", "cause", "death_both_sexes", "death_male", "death_female", "death_both_sexes_per_100000", "death_male_per_100000", "death_female_per_100000", "death_both_sexes_age_adjusted", "death_male_age_adjusted", "death_female_age_adjusted"))
sdpm25 <- read.csv('SDGPM25.csv', skip = 2, col.names = c("country", "rural_concentration", "urban_concentration", "total_concentration"))

new_data <-
  as.tibble(left_join(death, sdpm25, by = 'country')) %>% 
  mutate(male = number_extract1(death_male), female = number_extract1(death_female),
         total_concentration = number_extract1(total_concentration),
         cause = trimws(cause)) %>% 
  gather(sex, death, male, female) %>% 
  select(country, cause, sex, death, total_concentration)
write_csv(new_data, "./newdata.csv")
