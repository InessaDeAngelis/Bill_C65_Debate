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
# Note: Do not create a GPC specific model because there are not enough interventions 

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

# Read in the Women MPs data #
women_mps_data <- read_csv("Outputs/Data/women_mps_cleaned_data.csv")
show_col_types = FALSE

# Read in the Men MPs data #
men_mps_data <- read_csv("Outputs/Data/men_mps_cleaned_data.csv")
show_col_types = FALSE

#### Main (entire hansard corpus) ####
## Prepare text ## 
# Code to omit "Mr. / Madam Speaker referenced from: https://quanteda.io/reference/dfm_select.html
hansard_corpus <-
  corpus(cleaned_hansard_data, 
         text_field = "text")
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
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
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

#### Women MPs ####
## Prepare text ## 
women_mps_corpus <-
  corpus(women_mps_data, 
         text_field = "text")
women_mps_corpus

toks <- tokens(women_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

women_mps_dfm <-
  women_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

women_mps_dfm

## Make model ##
women_mps_topics <- stm(documents = women_mps_dfm, K = 10)

## Save model ##
write_rds(women_mps_topics, file = "Outputs/Model/women_mps_topics.rda")

## Read in model ##
women_mps_topics <- read_rds(file = "Outputs/Model/women_mps_topics.rda")

## View model ##
labelTopics(women_mps_topics)

plot(women_mps_topics, type = "summary", text.cex = 0.5)

#### Men MPs ####
## Prepare text ## 
men_mps_corpus <-
  corpus(men_mps_data, 
         text_field = "text")
men_mps_corpus

toks <- tokens(men_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

men_mps_dfm <-
  men_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

men_mps_dfm

## Make model ##
men_mps_topics <- stm(documents = men_mps_dfm, K = 10)

## Save model ##
write_rds(men_mps_topics, file = "Outputs/Model/men_mps_topics.rda")

## Read in model ##
men_mps_topics <- read_rds(file = "Outputs/Model/men_mps_topics.rda")

## View model ##
labelTopics(men_mps_topics)

plot(men_mps_topics, type = "summary", text.cex = 0.5)

#### Liberal MPs ####
## Prepare text ## 
LPC_mps_corpus <-
  corpus(LPC_cleaned_data, 
         text_field = "text")
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
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
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
         text_field = "text")
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
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
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
         text_field = "text")
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
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
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

#### Split models further, by both gender and party affiliation ####
#### Liberal Women MPs ####
## Filter dataset ##
LPC_women_mps_data =
women_mps_data |>
  filter(speaker_party == "Liberal")
LPC_women_mps_data
  
## Prepare text ## 
LPC_women_mps_corpus <-
  corpus(LPC_women_mps_data, 
         text_field = "text")
LPC_women_mps_corpus

toks <- tokens(LPC_women_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

LPC_women_mps_dfm <-
  LPC_women_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

LPC_women_mps_dfm

## Make model ##
LPC_women_mps_topics <- stm(documents = LPC_women_mps_dfm, K = 10)

## Save model ##
write_rds(LPC_women_mps_topics, file = "Outputs/Model/LPC_women_mps_topics.rda")

## Read in model ##
LPC_women_mps_topics <- read_rds(file = "Outputs/Model/LPC_women_mps_topics.rda")

## View model ##
labelTopics(LPC_women_mps_topics)

plot(LPC_women_mps_topics, type = "summary", text.cex = 0.5)

#### Liberal Men MPs ####
## Filter dataset ##
LPC_men_mps_data =
  men_mps_data |>
  filter(speaker_party == "Liberal")
LPC_men_mps_data

## Prepare text ## 
LPC_men_mps_corpus <-
  corpus(LPC_men_mps_data, 
         text_field = "text")
LPC_men_mps_corpus

toks <- tokens(LPC_men_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

LPC_men_mps_dfm <-
  LPC_men_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

LPC_men_mps_dfm

## Make model ##
LPC_men_mps_topics <- stm(documents = LPC_men_mps_dfm, K = 10)

## Save model ##
write_rds(LPC_men_mps_topics, file = "Outputs/Model/LPC_men_mps_topics.rda")

## Read in model ##
LPC_men_mps_topics <- read_rds(file = "Outputs/Model/LPC_men_mps_topics.rda")

## View model ##
labelTopics(LPC_men_mps_topics)

plot(LPC_men_mps_topics, type = "summary", text.cex = 0.5)

#### Conservative Women MPs ####
## Filter dataset ##
CPC_women_mps_data =
  women_mps_data |>
  filter(speaker_party == "Conservative")
CPC_women_mps_data

## Prepare text ## 
CPC_women_mps_corpus <-
  corpus(CPC_women_mps_data, 
         text_field = "text")
CPC_women_mps_corpus

toks <- tokens(CPC_women_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

CPC_women_mps_dfm <-
  CPC_women_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

CPC_women_mps_dfm

## Make model ##
CPC_women_mps_topics <- stm(documents = CPC_women_mps_dfm, K = 10)

## Save model ##
write_rds(CPC_women_mps_topics, file = "Outputs/Model/CPC_women_mps_topics.rda")

## Read in model ##
CPC_women_mps_topics <- read_rds(file = "Outputs/Model/CPC_women_mps_topics.rda")

## View model ##
labelTopics(CPC_women_mps_topics)

plot(CPC_women_mps_topics, type = "summary", text.cex = 0.5)

#### Conservative Men MPs ####
## Filter dataset ##
CPC_men_mps_data =
  men_mps_data |>
  filter(speaker_party == "Conservative")
CPC_men_mps_data

## Prepare text ## 
CPC_men_mps_corpus <-
  corpus(CPC_men_mps_data, 
         text_field = "text")
CPC_men_mps_corpus

toks <- tokens(CPC_men_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

CPC_men_mps_dfm <-
  CPC_men_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

CPC_men_mps_dfm

## Make model ##
CPC_men_mps_topics <- stm(documents = CPC_men_mps_dfm, K = 10)

## Save model ##
write_rds(CPC_men_mps_topics, file = "Outputs/Model/CPC_men_mps_topics.rda")

## Read in model ##
CPC_men_mps_topics <- read_rds(file = "Outputs/Model/CPC_men_mps_topics.rda")

## View model ##
labelTopics(CPC_men_mps_topics)

plot(CPC_men_mps_topics, type = "summary", text.cex = 0.5)

#### New Democratic Women MPs ####
## Filter dataset ##
NDP_women_mps_data =
  women_mps_data |>
  filter(speaker_party == "New Democratic Party")
NDP_women_mps_data

## Prepare text ## 
NDP_women_mps_corpus <-
  corpus(NDP_women_mps_data, 
         text_field = "text")
NDP_women_mps_corpus

toks <- tokens(NDP_women_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

NDP_women_mps_dfm <-
  NDP_women_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

NDP_women_mps_dfm

## Make model ##
NDP_women_mps_topics <- stm(documents = NDP_women_mps_dfm, K = 10)

## Save model ##
write_rds(NDP_women_mps_topics, file = "Outputs/Model/NDP_women_mps_topics.rda")

## Read in model ##
NDP_women_mps_topics <- read_rds(file = "Outputs/Model/NDP_women_mps_topics.rda")

## View model ##
labelTopics(NDP_women_mps_topics)

plot(NDP_women_mps_topics, type = "summary", text.cex = 0.5)

#### New Democratic Men MPs ####
## Filter dataset ##
NDP_men_mps_data =
  men_mps_data |>
  filter(speaker_party == "New Democratic Party")
NDP_men_mps_data

## Prepare text ## 
NDP_men_mps_corpus <-
  corpus(NDP_men_mps_data, 
         text_field = "text")
NDP_men_mps_corpus

toks <- tokens(NDP_men_mps_corpus)

# Create custom list of stop words #
mystopwords <- c("mr", "madam", "speaker")
char_select(mystopwords, c("mr", "madam", "speaker"), selection = "remove")

NDP_men_mps_dfm <-
  NDP_men_mps_corpus |>
  tokens(
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_numbers = TRUE
  ) |>
  dfm() |>
  dfm_trim(min_termfreq = 2, min_docfreq = 2, ) |>
  dfm_remove(stopwords(source = "stopwords-iso")) |>
  dfm_remove(mystopwords)

NDP_men_mps_dfm

## Make model ##
NDP_men_mps_topics <- stm(documents = NDP_men_mps_dfm, K = 10)

## Save model ##
write_rds(NDP_men_mps_topics, file = "Outputs/Model/NDP_men_mps_topics.rda")

## Read in model ##
NDP_men_mps_topics <- read_rds(file = "Outputs/Model/NDP_men_mps_topics.rda")

## View model ##
labelTopics(NDP_men_mps_topics)

plot(NDP_men_mps_topics, type = "summary", text.cex = 0.5)