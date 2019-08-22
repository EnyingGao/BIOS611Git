library(tidyverse)
library(stringr)
library(tm)
library(SnowballC)

args = commandArgs(trailingOnly = TRUE)

# Load Data
abstract <- read.delim(args[1], header = FALSE, sep = '\t')

# Create a list of keywords to find institutions
match <- c("university", "college", "institute", "school", "center", "research", "organisation", "nih", "clinic")
match <- str_c(match, collapse = "|")

# Split Author information
init_split = str_split(abstract[4,], "[()]")

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
  text <- tolower(text) # All lowercase
  text <- removePunctuation(text) # Remove punctuation
  text <- removeNumbers(text) # Remove numbers
  text <- removeWords(text, stopwords('en')) # Remove stop words from text
  text <- stripWhitespace(text) # Remove whitespace
  return(text)
}

# Apply clean_text function to title and abstract
original_text2 <- abstract[2,]
original_text5 <- abstract[5,]
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
  summarise(frequency = n()) %>% 
  arrange(desc(frequency))

# Next, we will explore the frequency of the words in general in title and abstract

# Make a Vcorpus
abstract_source <- VectorSource(abstract[c(2,5),])
abstract_corpus <- VCorpus(abstract_source)

# Cleaning and preprocessing text
clean_corpus <- function(corpus){
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removePunctuation)
  new_stops <- c("can", stopwords("en"))
  corpus <- tm_map(corpus, removeWords, new_stops)
  return(corpus)
}
cleaned_abstract_corpus <- clean_corpus(abstract_corpus)
cleaned_abstract_corpus[[2]][1]

# Create the dtm from the corpus: abstract_dtm
abstract_dtm <- DocumentTermMatrix(cleaned_abstract_corpus)

# Convert coffee_dtm to a matrix: abstract_m
abstract_m <- as.matrix(abstract_dtm)

# Calculate the colSums: term_frequency
term_frequency <- colSums(abstract_m)

# Sort term_frequency in descending order
term_frequency <- sort(term_frequency, decreasing = T)

# Select the top 10 most common words and make them into a tibble
term_frequency_general <- 
  as.tibble(term_frequency[1:10]) %>% 
  mutate(subject_emphases = names(term_frequency[1:10]))

# Join tables term_frequency_title and term_frequency_general
joined_term_frequency <- full_join(term_frequency_title, term_frequency_general, by = 'subject_emphases')

# Calculate final term frequency
final_term_frequency <- 
  joined_term_frequency %>% 
  mutate(term_frequency = rowSums(joined_term_frequency[-1], na.rm = TRUE)) %>% 
  dplyr::select(subject_emphases, term_frequency) %>% 
  arrange(desc(term_frequency))

# Combine names of the institutions and subject_emphases of the abstract into one table
abstract_emphases <- paste(unlist(final_term_frequency[1]), collapse = ' ')
institution_table_with_subject_emphases <- 
  data.frame(institution_list, abstract_emphases)

# Export table as a csv file
fileConn = file("out.csv")
writeLines(paste(institution_list, abstract_emphases, sep = ','), fileConn)
close(fileConn)