#### Preamble ####
# Purpose: Creates topic models with hansard data
# Author: Inessa De Angelis
# Date: 7 December 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # 01-download_data.R
  # 02-clean_data.R
  # 03-test_data.R

#### Workspace setup ####
library(tidyverse)
library(quanteda)
library(tidytext)
library(stm)

#### Read in datasets ####
# Read in the main cleaned hansard data # 
cleaned_hansard_data <- read_csv("Outputs/Data/cleaned_hansard_data.csv")
show_col_types = FALSE

# Read in the LPC data #
LPC_cleaned_data <- read_csv("Outputs/Data/LPC_cleaned_data.csv")
show_col_types = FALSE

# Read in the CPC data #
CPC_cleaned_data <- read_csv("Outputs/Data/CPC_cleaned_data.csv")
show_col_types = FALSE

# Read in the NDP data #
NDP_cleaned_data <- read_csv("Outputs/Data/NDP_cleaned_data.csv")
show_col_types = FALSE

# Read in the Female MPs data #
female_mps_data <- read_csv("Outputs/Data/female_mps_cleaned_data.csv")
show_col_types = FALSE

# Read in the Male MPs data #
female_mps_data <- read_csv("Outputs/Data/male_mps_cleaned_data.csv")
show_col_types = FALSE

#### Prepare main dataset for modeling ####
## Prepare text ## 
# Need to omit "Mr. / Madam Speaker"
hansard_corpus <-
  corpus(cleaned_hansard_data, 
         text_field = "speechtext")
hansard_corpus

toks <- tokens(hansard_corpus)

# Create custom list of stop words #
stop_word_list_updated <-
  paste(
    "Mr. |",
    "Speaker |",
    hansard_corpus,
    collapse = " | "
  )

hansard_dfm <-
  hansard_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) 

hansard_dfm

#### Make model ####
hansard_topics <- stm(documents = hansard_dfm, K = 10)

## Save model ##
write_rds(hansard_topics, file = "Outputs/Model/hansard_topics.rda")

## Read in model ##
hansard_topics <- read_rds(file = "Outputs/Model/hansard_topics.rda")

## View model ##
labelTopics(hansard_topics)