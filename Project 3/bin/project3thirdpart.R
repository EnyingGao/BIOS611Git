library(tidyverse)

args = commandArgs(trailingOnly = TRUE)

# Load Data
institution_information <- read_csv(args[1], col_names = c('institution', 'abstract_emphases'))

# Count the number of collaborations for each institution
number_of_collaborations <- 
  institution_information %>% 
  group_by(institution) %>% 
  summarise(collaborations = n()) %>% 
  arrange(desc(collaborations))

# Determine abstract emphases for each institution

# Combine abstract emphases for the same institution
subject_emphases_of_collaborations1 <-
  institution_information %>% 
  group_by(institution) %>% 
  mutate(new = paste0(abstract_emphases, collapse = " ")) %>% 
  dplyr::select(institution, new) %>% 
  unique()

# Split emphases into terms
subject_emphases_of_collaborations2 <-  str_split(subject_emphases_of_collaborations1$new, " ")

# Determine 5 subject emphases
subject_emphases_of_collaborations3 = vector('character', length(subject_emphases_of_collaborations2))
for (i in seq_along(subject_emphases_of_collaborations2)) {
  most_frequent_mentioned_words = 
    data_frame(lala2 = subject_emphases_of_collaborations2[[i]]) %>% 
    group_by(lala2) %>% 
    summarise(frequency = n()) %>% 
    arrange(desc(frequency)) %>% 
    head(5) %>% 
    dplyr::select(lala2)
  final_most_frequent_mentioned_words = paste(unlist(most_frequent_mentioned_words), collapse = ' ')
  subject_emphases_of_collaborations3[i] = final_most_frequent_mentioned_words
}

# Combine into the dataframe
subject_emphases_of_collaborations1$subject_emphases <- subject_emphases_of_collaborations3

# Combine number of collaborations and abstract emphases for each institution
final_result <- 
  subject_emphases_of_collaborations1 %>% 
  dplyr::select(institution, subject_emphases) %>% 
  inner_join(number_of_collaborations)

# Filter out insitutions that are not UNC
target <- c("University of North Carolina",
            "University of North Carolina at Chapel Hill",
            "Universityof North Carolina at Chapel Hill",
            "University of North Carolinaat Chapel Hill",
            "University ofNorth Carolina at Chapel Hill",
            "University of NorthCarolina at Chapel Hill",
            "University of North Carolina atChapel Hill",
            "University of North Carolina at ChapelHill",
            "University of North Carolina-Chapel Hill",
            "University ofNorth Carolina-Chapel Hill",
            "University of North Carolina at Chapel Hill",
            "The University ofNorth Carolina",
            "The University of North Carolina",
            "and University of North Carolina atChapel Hill",
            "Universityof North Carolina",
            "University of North Carolina Chapel Hill",
            "University of North Carolina at Chapel Hill School of Medicine",
            "University of North Carolina at Chapel Hill School ofMedicine",
            "University of North Carolina Chapel Hill",
            "The University of North Carolina at Chapel Hill",
            "University of North Carolina School of Medicine", 
            "University of NorthCarolina", NA, ".")
final_result <- final_result %>% 
  filter(!(institution %in% target))

# Export table as a csv file
fileConn = file("final.csv")
writeLines(paste(final_result$institution, final_result$collaborations, final_result$subject_emphases, sep = ','), fileConn)
close(fileConn)