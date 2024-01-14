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

## Read in datasets ##
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
male_mps_data <- read_csv("Outputs/Data/male_mps_cleaned_data.csv")
show_col_types = FALSE

#### Main (entire hansard corpus) ####
## Prepare text ## 
# Code to omit "Mr. / Madam Speaker referenced from: https://quanteda.io/reference/dfm_select.html
hansard_corpus <-
  corpus(cleaned_hansard_data, 
         text_field = "speechtext")
hansard_corpus

toks <- tokens(hansard_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

hansard_dfm <-
  hansard_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

hansard_dfm

#### Make model ####
hansard_topics <- stm(documents = hansard_dfm, K = 10)

## Save model ##
write_rds(hansard_topics, file = "Outputs/Model/hansard_topics.rda")

## Read in model ##
hansard_topics <- read_rds(file = "Outputs/Model/hansard_topics.rda")

## View model ##
labelTopics(hansard_topics)

plot(hansard_topics, type = "summary", text.cex = 0.5)

#### Female MPs ####
## Prepare text ## 
female_mps_corpus <-
  corpus(female_mps_data, 
         text_field = "speechtext")
female_mps_corpus

toks <- tokens(female_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

female_mps_dfm <-
  female_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

female_mps_dfm

## Make model ##
female_mps_topics <- stm(documents = female_mps_dfm, K = 10)

## Save model ##
write_rds(female_mps_topics, file = "Outputs/Model/female_mps_topics.rda")

## Read in model ##
female_mps_topics <- read_rds(file = "Outputs/Model/female_mps_topics.rda")

## View model ##
labelTopics(female_mps_topics)

plot(female_mps_topics, type = "summary", text.cex = 0.5)

#### Male MPs ####
## Prepare text ## 
male_mps_corpus <-
  corpus(male_mps_data, 
         text_field = "speechtext")
male_mps_corpus

toks <- tokens(male_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

male_mps_dfm <-
  male_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

male_mps_dfm

## Make model ##
male_mps_topics <- stm(documents = male_mps_dfm, K = 10)

## Save model ##
write_rds(male_mps_topics, file = "Outputs/Model/male_mps_topics.rda")

## Read in model ##
male_mps_topics <- read_rds(file = "Outputs/Model/male_mps_topics.rda")

## View model ##
labelTopics(male_mps_topics)

plot(male_mps_topics, type = "summary", text.cex = 0.5)

#### Liberal MPs ####
## Prepare text ## 
LPC_mps_corpus <-
  corpus(LPC_cleaned_data, 
         text_field = "speechtext")
LPC_mps_corpus

toks <- tokens(LPC_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

LPC_mps_dfm <-
  LPC_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

LPC_mps_dfm 

## Make model ##
lpc_mps_topics <- stm(documents = LPC_mps_dfm, K = 10)

## Save model ##
write_rds(lpc_mps_topics, file = "Outputs/Model/lpc_mps_topics.rda")

## Read in model ##
lpc_mps_topics <- read_rds(file = "Outputs/Model/lpc_mps_topics.rda")

## View model ##
labelTopics(lpc_mps_topics)

plot(lpc_mps_topics, type = "summary", text.cex = 0.5)

#### Conservative MPs ####
## Prepare text ## 
CPC_mps_corpus <-
  corpus(CPC_cleaned_data, 
         text_field = "speechtext")
CPC_mps_corpus

toks <- tokens(CPC_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

CPC_mps_dfm <-
  CPC_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

CPC_mps_dfm 

## Make model ##
cpc_mps_topics <- stm(documents = CPC_mps_dfm, K = 10)

## Save model ##
write_rds(cpc_mps_topics, file = "Outputs/Model/cpc_mps_topics.rda")

## Read in model ##
cpc_mps_topics <- read_rds(file = "Outputs/Model/cpc_mps_topics.rda")

## View model ##
labelTopics(cpc_mps_topics)

plot(cpc_mps_topics, type = "summary", text.cex = 0.5)

#### NDP MPs ####
## Prepare text ## 
NDP_mps_corpus <-
  corpus(NDP_cleaned_data, 
         text_field = "speechtext")
NDP_mps_corpus

toks <- tokens(NDP_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

NDP_mps_dfm <-
  NDP_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "snowball")) |>
  dfm_remove(mystopwords)

NDP_mps_dfm 

## Make model ##
ndp_mps_topics <- stm(documents = NDP_mps_dfm, K = 10)

## Save model ##
write_rds(ndp_mps_topics, file = "Outputs/Model/ndp_mps_topics.rda")

## Read in model ##
ndp_mps_topics <- read_rds(file = "Outputs/Model/ndp_mps_topics.rda")

## View model ##
labelTopics(ndp_mps_topics)

plot(ndp_mps_topics, type = "summary", text.cex = 0.5)

topfeatures(male_mps_dfm, n = 20, scheme = "docfreq")
