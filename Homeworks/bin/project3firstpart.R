library(tidyverse)

args = commandArgs(trailingOnly = TRUE)

# Load Data
abstract <- read_lines(args[1])

# Create a list of keywords to find institutions
match <- c("university", "college", "institute", "school", "center", "research", "organisation", "nih", "clinic")
match <- str_c(match, collapse = "|")

# Split Author information
author <- if(str_detect(abstract[4], "Author")) {
  abstract[4]} else if (str_detect(abstract[3], "Author")) {
    abstract[3]} else {
      abstract[5]
    }
init_split = str_split(author, "[()]")

# Clean the list of authors
cleaned_list = init_split[[1]][c(seq(3, length(init_split[[1]]), 2))]

# Create a function that returns the name of the insitution per author
find_institution <- function(number) {
  words = str_trim(unlist(str_split(cleaned_list[number], ","))) # split sentences into wordss
  find_keywords = str_detect(str_to_lower(words), match) # match wordss with keywords
  if(length(words[find_keywords]) == 1) {
    return(words[find_keywords])
  } else if (length(words[find_keywords]) == 0) {
    return(words[1])
  } else {
    return(words[find_keywords][length(words[find_keywords])])
  }
}

# Use for loop to generate a list of institution names for this particular abstract
institution_list = vector('character', length(cleaned_list))
for(i in seq_along(cleaned_list)) {
  institution = find_institution(i)
  institution_list[i] = institution }

# Result of associated institutions
institution_list

# Create a function that clean up the text
clean_text <- function(text){
  text <- tolower(text)
  text <- gsub("[[:punct:][:blank:]]+", " ", text)
  text <- gsub('[[:digit:]]+', '', text)
  return(text)
}


# Apply clean_text function to title and abstract
original_text2 <- if(str_detect(abstract[4], "Author")) {
  abstract[2]} else if (str_detect(abstract[3], "Author")) {
    abstract[1]} else {
      abstract[3]
    }
original_text5 <- if(str_detect(abstract[4], "Author")) {
  abstract[5]} else if (str_detect(abstract[3], "Author")) {
    abstract[4]} else {
      abstract[6]
    }
cleaned_text2 <- clean_text(original_text2) # Cleaned title
cleaned_text5 <- clean_text(original_text5) # Cleaned abstract

# Since titles are often infomative, we would use titles as foundations to discover the most frequent words being mentioned in the abstract
# Use words from title to create a list of keywords to find subject emphases of the abstract
match <- unlist(str_split(str_trim(cleaned_text2), " "))
match <- str_c(match, collapse = "|")
words <-  unlist(str_split(str_trim(cleaned_text5), " "))
find_keywords <-  str_detect(str_to_lower(words), match) # match words with keywords

# Create a data frame that list the frequency of the words in the abstract based on title
term_frequency_title <- 
  data_frame(subject_emphases = words[find_keywords]) %>% 
  group_by(subject_emphases) %>% 
  filter(!(subject_emphases %in% c('to', 'a', 'of', 'the','and','in','can','for','it','this',
                                   'as','into','is', 'from', 'that', 'have', 'has', 'not', 'should',
                                   'might', 'they', "", "or", "was", "with", "after", "before", "at", 
                                   "were", "those", "without"))) %>% 
  summarise(frequency = n()) %>% 
  arrange(desc(frequency)) %>% 
  head(10)

# Result of term_frequency_title
term_frequency_title

# Next, we will explore the frequency of the words in general in title and abstract

# Lowercase title and abstract and combine them together
text <- paste0(tolower(abstract[2]), tolower(abstract[5]), collapse = " ")

# Apply clean_text function and split string into words
words <- unlist(str_split(str_trim(clean_text(text)), " "))

# Create a data frame that list the frequency of the words in the abstract and title
# Select the top 10 most common words
term_frequency_general <- 
  data_frame(words) %>% 
  group_by(words) %>% 
  filter(!(words %in% c('to', 'a', 'of', 'the','and','in','can','for','it','this',
                        'as','into','is', 'from', 'that', 'have', 'has', 'not', 'should',
                        'might', 'they', "", "or", "was", "with", "after", "before", "at", 
                        "were", "those", "without", "by", "we", "are", "95%", "an", "among",
                        "between"))) %>% 
  summarise(frequency = n()) %>% 
  arrange(desc(frequency)) %>% 
  head(10)

# Result of term_frequency_general
term_frequency_general

# Join tables term_frequency_title and term_frequency_general
joined_term_frequency <- full_join(term_frequency_title, term_frequency_general, by = c('subject_emphases' = 'words'))

# Calculate final term frequency
final_term_frequency <- 
  joined_term_frequency %>% 
  mutate(term_frequency = rowSums(joined_term_frequency[-1], na.rm = TRUE)) %>% 
  dplyr::select(subject_emphases, term_frequency) %>% 
  arrange(desc(term_frequency))

# Result of final_term_frequency
final_term_frequency

# Combine names of the institutions and subject_emphases of the abstract into one table
abstract_emphases <- paste(unlist(final_term_frequency[1]), collapse = ' ')
institution_table_with_subject_emphases <- 
  data.frame(institution_list, abstract_emphases)

# Result of institution table with subject emphases
institution_table_with_subject_emphases

# Export table as a csv file
fileConn = file("out.csv")
writeLines(paste(institution_list, abstract_emphases, sep = ','), fileConn)
close(fileConn)
