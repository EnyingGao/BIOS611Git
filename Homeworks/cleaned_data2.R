library(tidyverse)
source_pm <- read.csv('Database_Source_apport_studies.csv')

new_data2 <-
  as.tibble(source_pm) %>%
  rename(Year = Reference.year, sea_salt = SEA.SALT.,
         dust = DUST., traffic = TRAFFIC.,
         industry = INDUSTRY., biomass_burn_residual = BIOM..BURN..RES..,
         other_unspecified_human_origin = OTHER..unspecified.human.origin..) %>% 
  select(Year, sea_salt, dust, traffic, industry,
         biomass_burn_residual, other_unspecified_human_origin)
write_csv(new_data2, "./newdata2.csv")
